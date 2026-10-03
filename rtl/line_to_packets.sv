
module line_to_packets #(
    parameter DEPTH = 4096,
    // Width of AXI stream interfaces in bits
    parameter DATA_WIDTH = 64,
    parameter KEEP_WIDTH = ((DATA_WIDTH + 7) / 8),
    parameter ID_WIDTH = 8,
    parameter DEST_WIDTH = 8,
    parameter USER_WIDTH = 1,
    // parameters of packetizer 
    parameter PW = 32,
    parameter IN_PCNT = 2
    // localparam MAX_LENGTH = $floor((7996 - 20 - 8 - 8)/8)   // payload size without IP & UDP & custom header
) (

    input wire clk,
    input wire rst,

    /*
     * data input
     */
    input [            11:0] i_vres,
    input [            11:0] i_hres,
    input                    i_vsync,
    input                    i_hsync,
    input                    i_de,
    input                    i_valid,
    input [            63:0] i_pixel,
    input [            15:0] mss,
    input [             7:0] pixel_mode,

    /*
     * AXI output
     */
    output wire [DATA_WIDTH-1:0] m_axis_tdata,
    output wire [KEEP_WIDTH-1:0] m_axis_tkeep,
    output wire                  m_axis_tvalid,
    input  wire                  m_axis_tready,
    output wire                  m_axis_tlast,
    output wire [  ID_WIDTH-1:0] m_axis_tid,
    output wire [DEST_WIDTH-1:0] m_axis_tdest,
    output wire [USER_WIDTH-1:0] m_axis_tuser,

    /**
     * UDP header output
     */
    input  wire        m_hdr_ready,
    output wire        m_hdr_valid,
    output wire [15:0] pkt_length
);

typedef enum logic [2:0] {
    IDLE = 0,
    HEADER,
    PAYLOAD,
    WAIT,
    NEXT_PKT
} state_t;

assign m_axis_tid   = 1;
assign m_axis_tdest = 0;
assign m_axis_tuser = 0;
assign m_axis_tkeep = '1;

logic [            31:0] frame_cnt;
logic [            15:0] line_cnt;
logic [            11:0] r_vres;
logic [            11:0] r_hres;
logic                    r_vsync;
logic                    r_hsync;
logic                    r_de;
logic                    r_valid;
logic [            63:0] r_pixel;

always @(posedge clk) begin
    if (rst) begin
        r_vres <= '0;
        r_hres <= '0;
        r_vsync <= '0;
        r_hsync <= '0;
        r_de <= '0;
        r_valid <= '0;
        r_pixel <= '0;
    end else begin
        r_vres <= i_vres;
        r_hres <= i_hres;
        r_vsync <= i_vsync;
        r_hsync <= i_hsync;
        r_de <= i_de;
        r_valid <= i_valid;
        r_pixel <= i_pixel;
    end
end

wire rising_vsync = !r_vsync && i_vsync;
wire rising_hsync = !r_hsync && i_hsync;
wire rising_de = !r_de && i_de;
wire falling_vsync = r_vsync && !i_vsync;
wire falling_hsync = r_hsync && !i_hsync;
wire falling_de = r_de && !i_de;

always @(posedge clk) begin
    if (rst) begin
        frame_cnt <= '0;
        line_cnt  <= '0;
    end else begin
        if (falling_vsync) frame_cnt <= frame_cnt + 1;

        if (!r_vsync) line_cnt <= '0;
        else if (falling_de) line_cnt <= line_cnt + 1;
    end
end


wire [15:0] dbg_trans_rdcnt;
wire dbg_trans_rst_busy;
wire w_trans_full;
wire w_trans_empty;

wire [11:0] dbg_txdata_rd_datacount;
wire dbg_size_busy;
wire w_full;
wire w_empty;
wire [63:0] w_pixel;

logic [15:0] wr_beat_cnt = 0;
wire [15:0] wr_beat_cnt_next = i_valid && !w_full ? wr_beat_cnt + 1 : wr_beat_cnt;
wire [15:0] wr_beat_cnt_dout;

logic [15:0] line_rd_cnt = 0;
logic [15:0] packet_rd_cnt = 0;
state_t rd_state;
state_t next_rd_state;
wire w_rd_en;

logic r_axis_tlast = 0;
logic [15:0] offset = '0;
logic [15:0] r_pkt_length = 0;
logic r_hdr_valid = 0;
wire [7:0] frame_type = 1;
wire [63:0] header = {pixel_mode, offset, line_cnt[0+:16], 4'b0, r_hres, frame_type};

// assign s_axis_tready = !w_full;
assign m_axis_tvalid = rd_state != IDLE && rd_state != NEXT_PKT;
assign m_axis_tlast = r_axis_tlast;
assign w_rd_en = next_rd_state == PAYLOAD;
assign m_axis_tdata = rd_state == HEADER ? header : w_pixel;
assign pkt_length = r_pkt_length;
assign m_hdr_valid = r_hdr_valid;

always @(*) begin
    case (rd_state)
        IDLE: begin
            if (!w_trans_empty) begin
                next_rd_state = HEADER;
            end else begin
                next_rd_state = IDLE;
            end
        end

        HEADER: begin
            if (m_axis_tready)
                next_rd_state = PAYLOAD;
            else
                next_rd_state = HEADER;
        end

        PAYLOAD: begin
            if (!m_axis_tready) begin
                next_rd_state = WAIT;
            end else if (r_axis_tlast) begin
                next_rd_state = NEXT_PKT;
            end else begin
                next_rd_state = PAYLOAD;
            end
        end

        WAIT: begin
            if (m_axis_tvalid && m_axis_tready) begin
                if (r_axis_tlast) begin
                    next_rd_state = NEXT_PKT;
                end else begin
                    next_rd_state = PAYLOAD;
                end
            end else begin
                next_rd_state = WAIT;
            end
        end

        NEXT_PKT: begin  // wait until header is received. 
            if (m_hdr_valid && m_hdr_ready) begin
                if (line_rd_cnt == wr_beat_cnt_dout)
                    next_rd_state = IDLE;
                else
                    next_rd_state = HEADER;
            end else begin
                next_rd_state = NEXT_PKT;
            end
        end

        default: begin
            next_rd_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        r_pkt_length <= '0;
        r_hdr_valid  <= '0;
    end else begin
        if (m_axis_tready && m_axis_tvalid && m_axis_tlast) begin
            r_pkt_length <= (packet_rd_cnt << 3) + 8;
            r_hdr_valid  <= 1;
        end else if (m_hdr_valid && m_hdr_ready) begin
            r_hdr_valid <= 0;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        rd_state <= IDLE;
        packet_rd_cnt <= '0;
        line_rd_cnt <= '0;
        r_axis_tlast <= '0;
        offset <= '0;
    end else begin
        rd_state <= next_rd_state;

        if (rd_state == IDLE) begin
            offset <= '0;
        end else if (m_axis_tready == 1 && m_axis_tvalid == 1 && rd_state != HEADER) begin
            offset <= offset + (64 >> 3);
        end

        if (rd_state == IDLE) begin
            line_rd_cnt   <= '0;
            packet_rd_cnt <= '0;
        end else if (rd_state == NEXT_PKT) begin
            packet_rd_cnt <= '0;
        end else begin
            if (w_rd_en) begin
                line_rd_cnt   <= line_rd_cnt + 1;
                packet_rd_cnt <= packet_rd_cnt + 1;
            end
        end

        if (rd_state == IDLE) begin
            r_axis_tlast <= '0;
        end else if (m_axis_tready && m_axis_tvalid && r_axis_tlast) begin
            r_axis_tlast <= 0;
        end else begin
            if (packet_rd_cnt + 1 == mss || line_rd_cnt + 1 == wr_beat_cnt_dout) begin
                r_axis_tlast <= 1;
            end
        end
    end
end

always @(posedge clk) begin : counting_incoming_axi_beats
    if (rst) begin
        wr_beat_cnt <= 0;
    end else begin
        if (falling_de) begin
            wr_beat_cnt <= 0;
        end else if (i_valid && !w_full) begin
            wr_beat_cnt <= wr_beat_cnt + 1;
        end
    end
end

reg [31:0] drop_line = 0;
always_ff @(posedge clk) begin
    if (rst) begin
        drop_line <= '0;
    end else begin
        if ((w_trans_full || w_full) && rising_de)
            drop_line <= drop_line + 1;
    end
end


efx_fifo_top_custom #(
    .OPTIONAL_FLAGS(0),
    .SYNC_CLK(0),
    .DEPTH(DEPTH),
    .DATA_WIDTH(64),
    .ASYM_WIDTH_RATIO(4),
    .MODE("STANDARD"),
    .OUTPUT_REG(0),
    .BYPASS_RESET_SYNC(0),
    .PROG_FULL_ASSERT(128),
    .PIPELINE_REG(1),
    .PROG_FULL_NEGATE(128),
    .SYNC_STAGE(2),
    .PROG_EMPTY_ASSERT(0),
    .PROG_EMPTY_NEGATE(2),
    .PROGRAMMABLE_FULL("NONE"),
    .PROGRAMMABLE_EMPTY("NONE"),
    .FAMILY("TITANIUM")
) u_fwft_fifo_trans (
    .a_rst_i       (rst),
    .wr_clk_i      (clk),
    .wr_en_i       (i_valid),
    .wdata         ({i_pixel}),
    .rd_clk_i      (clk),
    .rd_en_i       (w_rd_en),
    .rdata         ({w_pixel}),
    .full_o        (w_full),
    .empty_o       (w_empty),
    .wr_datacount_o(),
    .rd_datacount_o(dbg_txdata_rd_datacount),
    .rst_busy      (dbg_size_busy)
);

efx_fifo_top_custom #(
    .OPTIONAL_FLAGS(0),
    .SYNC_CLK(0),
    .DEPTH(512),
    .DATA_WIDTH(16),
    .ASYM_WIDTH_RATIO(4),
    .MODE("FWFT"),
    .OUTPUT_REG(0),
    .BYPASS_RESET_SYNC(0),
    .PROG_FULL_ASSERT(128),
    .PIPELINE_REG(1),
    .PROG_FULL_NEGATE(128),
    .SYNC_STAGE(2),
    .PROG_EMPTY_ASSERT(0),
    .PROG_EMPTY_NEGATE(2),
    .PROGRAMMABLE_FULL("NONE"),
    .PROGRAMMABLE_EMPTY("NONE"),
    .FAMILY("TITANIUM")
) u_fwft_fifo_data (
    .a_rst_i       (rst),
    .wr_clk_i      (clk),
    .wr_en_i       (falling_de && wr_beat_cnt_next != 0),
    .wdata         (wr_beat_cnt_next),
    .rd_clk_i      (clk),
    .rd_en_i       (rd_state != IDLE && next_rd_state == IDLE),
    .rdata         (wr_beat_cnt_dout),
    .full_o        (w_trans_full),
    .empty_o       (w_trans_empty),
    .wr_datacount_o(),
    .rd_datacount_o(dbg_trans_rdcnt),
    .rst_busy      (dbg_trans_rst_busy)
);

endmodule
