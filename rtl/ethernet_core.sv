

module ethernet_core #(
    parameter PW = 16,
    parameter IN_PCNT = 2
) (
    input clk,        //156.25Mhz
    input rst,        //156.25Mhz sync reset
    input video_rst,  //156.25Mhz sync reset
    input clk_100m,

    output wire o_eth_rx_active,
    output wire o_eth_tx_active,

    // Configuration
    input [47:0] local_mac,
    input [31:0] local_ip,
    input [31:0] gateway_ip,
    input [31:0] subnet_mask,
    input [31:0] udp_ip_dest_ip,
    input [15:0] udp_source_port,
    input [15:0] udp_dest_port,
    input [15:0] mss,
    input [ 7:0] pixel_mode,

    // pixel data
    input [            11:0] i_vres,
    input [            11:0] i_hres,
    input                    i_vsync,
    input                    i_hsync,
    input                    i_de,
    input                    i_valid,
    input [PW * IN_PCNT-1:0] i_pixel,

    // parameters
    output [7:0]  o_exposure,
    output [7:0]  o_gain_r,
    output [7:0]  o_gain_g,
    output [7:0]  o_gain_b,

    input  [15:0] p1_apb3_paddr,
    input         p1_apb3_psel,
    input         p1_apb3_penable,
    output        p1_apb3_pready,
    input         p1_apb3_pwrite,
    input  [31:0] p1_apb3_pwdata,
    output [31:0] p1_apb3_prdata,
    output        p1_apb3_pslverror,

    /*
     * Ethernet: SFP+
     */
    input              init_rst_n,
    input              PMA_CMN_READY,
    input              PMA_XCVR_PLLCLK_EN_ACK,
    input  [3:0]       PMA_XCVR_POWER_STATE_ACK,
    input              PMA_RX_SIGNAL_DETECT,
    output             PMA_XCVR_PLLCLK_EN,
    output [3:0]       PMA_XCVR_POWER_STATE_REQ,

    output wire [63:0] sfp0_txd,
    output wire [ 7:0] sfp0_txc,
    input       [63:0] sfp0_rxd,
    input       [ 7:0] sfp0_rxc
);

reg                      clk_50m;

// AXI between MAC and Ethernet modules
wire  [            63:0] rx_axis_tdata;
wire  [             7:0] rx_axis_tkeep;
wire                     rx_axis_tvalid;
wire                     rx_axis_tready;
wire                     rx_axis_tlast;
wire                     rx_axis_tuser;

wire  [            63:0] rx_axis_fifo_tdata;
wire  [             7:0] rx_axis_fifo_tkeep;
wire                     rx_axis_fifo_tvalid;
wire                     rx_axis_fifo_tready;
wire                     rx_axis_fifo_tlast;
wire                     rx_axis_fifo_tuser;

wire  [            63:0] tx_axis_tdata;
wire  [             7:0] tx_axis_tkeep;
wire                     tx_axis_tvalid;
wire                     tx_axis_tready;
wire                     tx_axis_tlast;
wire                     tx_axis_tuser;

// Ethernet frame between Ethernet modules and UDP stack
wire                     rx_eth_hdr_ready;
wire                     rx_eth_hdr_valid;
wire  [            47:0] rx_eth_dest_mac;
wire  [            47:0] rx_eth_src_mac;
wire  [            15:0] rx_eth_type;
wire  [            63:0] rx_eth_payload_axis_tdata;
wire  [             7:0] rx_eth_payload_axis_tkeep;
wire                     rx_eth_payload_axis_tvalid;
wire                     rx_eth_payload_axis_tready;
wire                     rx_eth_payload_axis_tlast;
wire                     rx_eth_payload_axis_tuser;

wire                     tx_eth_hdr_ready;
wire                     tx_eth_hdr_valid;
wire  [            47:0] tx_eth_dest_mac;
wire  [            47:0] tx_eth_src_mac;
wire  [            15:0] tx_eth_type;
wire  [            63:0] tx_eth_payload_axis_tdata;
wire  [             7:0] tx_eth_payload_axis_tkeep;
wire                     tx_eth_payload_axis_tvalid;
wire                     tx_eth_payload_axis_tready;
wire                     tx_eth_payload_axis_tlast;
wire                     tx_eth_payload_axis_tuser;

// IP frame connections
wire                     rx_ip_hdr_valid;
wire                     rx_ip_hdr_ready;
wire  [            47:0] rx_ip_eth_dest_mac;
wire  [            47:0] rx_ip_eth_src_mac;
wire  [            15:0] rx_ip_eth_type;
wire  [             3:0] rx_ip_version;
wire  [             3:0] rx_ip_ihl;
wire  [             5:0] rx_ip_dscp;
wire  [             1:0] rx_ip_ecn;
wire  [            15:0] rx_ip_length;
wire  [            15:0] rx_ip_identification;
wire  [             2:0] rx_ip_flags;
wire  [            12:0] rx_ip_fragment_offset;
wire  [             7:0] rx_ip_ttl;
wire  [             7:0] rx_ip_protocol;
wire  [            15:0] rx_ip_header_checksum;
wire  [            31:0] rx_ip_source_ip;
wire  [            31:0] rx_ip_dest_ip;
wire  [            63:0] rx_ip_payload_axis_tdata;
wire  [             7:0] rx_ip_payload_axis_tkeep;
wire                     rx_ip_payload_axis_tvalid;
wire                     rx_ip_payload_axis_tready;
wire                     rx_ip_payload_axis_tlast;
wire                     rx_ip_payload_axis_tuser;

wire                     tx_ip_hdr_valid;
wire                     tx_ip_hdr_ready;
wire  [             5:0] tx_ip_dscp;
wire  [             1:0] tx_ip_ecn;
wire  [            15:0] tx_ip_length;
wire  [             7:0] tx_ip_ttl;
wire  [             7:0] tx_ip_protocol;
wire  [            31:0] tx_ip_source_ip;
wire  [            31:0] tx_ip_dest_ip;
wire  [            63:0] tx_ip_payload_axis_tdata;
wire  [             7:0] tx_ip_payload_axis_tkeep;
wire                     tx_ip_payload_axis_tvalid;
wire                     tx_ip_payload_axis_tready;
wire                     tx_ip_payload_axis_tlast;
wire                     tx_ip_payload_axis_tuser;

// UDP frame connections
wire                     rx_udp_hdr_valid;
wire                     rx_udp_hdr_ready;
wire  [            47:0] rx_udp_eth_dest_mac;
wire  [            47:0] rx_udp_eth_src_mac;
wire  [            15:0] rx_udp_eth_type;
wire  [             3:0] rx_udp_ip_version;
wire  [             3:0] rx_udp_ip_ihl;
wire  [             5:0] rx_udp_ip_dscp;
wire  [             1:0] rx_udp_ip_ecn;
wire  [            15:0] rx_udp_ip_length;
wire  [            15:0] rx_udp_ip_identification;
wire  [             2:0] rx_udp_ip_flags;
wire  [            12:0] rx_udp_ip_fragment_offset;
wire  [             7:0] rx_udp_ip_ttl;
wire  [             7:0] rx_udp_ip_protocol;
wire  [            15:0] rx_udp_ip_header_checksum;
wire  [            31:0] rx_udp_ip_source_ip;
wire  [            31:0] rx_udp_ip_dest_ip;
wire  [            15:0] rx_udp_source_port;
wire  [            15:0] rx_udp_dest_port;
wire  [            15:0] rx_udp_length;
wire  [            15:0] rx_udp_checksum;
wire  [            63:0] rx_udp_payload_axis_tdata;
wire  [             7:0] rx_udp_payload_axis_tkeep;
wire                     rx_udp_payload_axis_tvalid;
wire                     rx_udp_payload_axis_tready;
wire                     rx_udp_payload_axis_tlast;
wire                     rx_udp_payload_axis_tuser;

wire                     tx_udp_hdr_valid;
wire                     tx_udp_hdr_ready;
wire  [             5:0] tx_udp_ip_dscp;
wire  [             1:0] tx_udp_ip_ecn;
wire  [             7:0] tx_udp_ip_ttl;
wire  [            31:0] tx_udp_ip_source_ip;
wire  [            31:0] tx_udp_ip_dest_ip;
wire  [            15:0] tx_udp_source_port;
wire  [            15:0] tx_udp_dest_port;
wire  [            15:0] tx_udp_length;
wire  [            15:0] tx_udp_checksum;
wire  [            63:0] tx_udp_payload_axis_tdata;
wire  [             7:0] tx_udp_payload_axis_tkeep;
wire                     tx_udp_payload_axis_tvalid;
wire                     tx_udp_payload_axis_tready;
wire                     tx_udp_payload_axis_tlast;
wire                     tx_udp_payload_axis_tuser;

// wire [          63:0] rx_fifo_udp_payload_axis_tdata;
// wire [           7:0] rx_fifo_udp_payload_axis_tkeep;
// wire                  rx_fifo_udp_payload_axis_tvalid;
// wire                  rx_fifo_udp_payload_axis_tready;
// wire                  rx_fifo_udp_payload_axis_tlast;
// wire                  rx_fifo_udp_payload_axis_tuser;

wire  [            63:0] tx_fifo_udp_payload_axis_tdata;
wire  [             7:0] tx_fifo_udp_payload_axis_tkeep;
wire                     tx_fifo_udp_payload_axis_tvalid;
wire                     tx_fifo_udp_payload_axis_tready;
wire                     tx_fifo_udp_payload_axis_tlast;
wire                     tx_fifo_udp_payload_axis_tuser;

wire  [            63:0] tx_linepkt_axis_tdata;
wire  [             7:0] tx_linepkt_axis_tkeep;
wire                     tx_linepkt_axis_tvalid;
wire                     tx_linepkt_axis_tready;
wire                     tx_linepkt_axis_tlast;
wire                     tx_linepkt_axis_tuser;
wire                     tx_linepkt_hdr_valid;
wire                     tx_linepkt_hdr_ready;
wire  [            15:0] tx_linepkt_hdr_pkt_length;

wire                     ip_rx_busy;
wire                     ip_tx_busy;
wire                     udp_rx_busy;
wire                     udp_tx_busy;
wire                     ip_rx_error_header_early_termination;
wire                     ip_rx_error_payload_early_termination;
wire                     ip_rx_error_invalid_header;
wire                     ip_rx_error_invalid_checksum;
wire                     ip_tx_error_payload_early_termination;
wire                     ip_tx_error_arp_failed;
wire                     udp_rx_error_header_early_termination;
wire                     udp_rx_error_payload_early_termination;

wire  [            15:0] apb3_paddr;
wire                     apb3_psel;
wire                     apb3_penable;
wire                     apb3_pready;
wire                     apb3_pwrite;
wire  [            31:0] apb3_pwdata;
wire  [            31:0] apb3_prdata;
wire                     apb3_pslverror;
// // Configuration
// wire [          47:0] local_mac = 48'h02_00_00_00_00_00;
// wire [          31:0] local_ip = {8'd192, 8'd168, 8'd1, 8'd128};
// wire [          31:0] gateway_ip = {8'd192, 8'd168, 8'd1, 8'd1};
// wire [          31:0] subnet_mask = {8'd255, 8'd255, 8'd255, 8'd0};

logic [            31:0] frame_cnt;
logic [            11:0] line_cnt;
logic [            11:0] r_vres;
logic [            11:0] r_hres;
logic [PW * IN_PCNT-1:0] r_pixel;
logic [PW * IN_PCNT-1:0] temp_pixel;
logic                    r_valid;
logic                    r_vsync;
logic                    r_hsync;
logic                    r_de;
logic                    r2_vsync;
logic                    r2_hsync;
logic                    r2_de;
logic [             1:0] pack_state;

wire  [            31:0] tx_udp_in_tdata;
wire  [             3:0] tx_udp_in_tkeep;
wire                     tx_udp_in_tvalid;
wire                     tx_udp_in_tready;
wire                     tx_udp_in_tlast;
wire                     tx_udp_in_tuser;

wire                     rising_vsync = !r2_vsync && r_vsync;
wire                     rising_hsync = !r2_hsync && r_hsync;
wire                     rising_de = !r2_de && r_de;
wire                     falling_vsync = r2_vsync && !r_vsync;
wire                     falling_hsync = r2_hsync && !r_hsync;
wire                     falling_de = r2_de && !r_de;

wire  [            63:0] vsync_frame_header = {8'b0, frame_cnt[0+:32], 4'b0, r_vres, 8'b0};

typedef enum logic [1:0] {
    ARGB8888 = 0,
    RGB888 = 1,
    RGB565 = 2
} PixelFormat;

// IP ports not used
assign rx_ip_hdr_ready = 1;
assign rx_ip_payload_axis_tready = 1;

assign tx_ip_hdr_valid = 0;
assign tx_ip_dscp = 0;
assign tx_ip_ecn = 0;
assign tx_ip_length = 0;
assign tx_ip_ttl = 0;
assign tx_ip_protocol = 0;
assign tx_ip_source_ip = 0;
assign tx_ip_dest_ip = 0;
assign tx_ip_payload_axis_tdata = 0;
assign tx_ip_payload_axis_tkeep = 0;
assign tx_ip_payload_axis_tvalid = 0;
assign tx_ip_payload_axis_tlast = 0;
assign tx_ip_payload_axis_tuser = 0;

always @(posedge clk) begin
    if (rst) begin
        frame_cnt <= '0;
        line_cnt  <= '0;
    end else begin
        if (falling_vsync)
            frame_cnt <= frame_cnt + 1;

        if (!r2_vsync)
            line_cnt <= '0;
        else if (falling_de)
            line_cnt <= line_cnt + 1;
    end
end

always @(posedge clk) begin
    if (video_rst) begin
        r_vres <= '0;
        r_hres <= '0;
        r_vsync <= '0;
        r_hsync <= '0;
        r_de <= '0;
        r_valid <= '0;
        r_pixel <= '0;
        temp_pixel <= '0;
        r2_vsync <= '0;
        r2_hsync <= '0;
        r2_de <= '0;
        pack_state <= '0;
    end else begin
        r_vres <= i_vres;
        r_hres <= i_hres;
        r_vsync <= i_vsync;
        r_hsync <= i_hsync;
        r_de <= i_de;
        r2_vsync <= r_vsync;
        r2_hsync <= r_hsync;
        r2_de <= r_de;

        if (i_valid)
            case (pixel_mode)
                RGB888: pack_state <= pack_state + 1;
                RGB565: pack_state <= pack_state[0] + 1;
                default: pack_state <= 0;
            endcase
        else if (!i_hsync)
            pack_state <= '0;

        case (pixel_mode)
            ARGB8888: begin
                r_pixel <= i_pixel;
                r_valid <= i_valid;
            end

            RGB888: begin
                // assigning falling edge of i_de to r_valid only when temp_pixel is not empty or
                // r_pixel is not empty but no valid last cycle 
                case (pack_state)
                0: begin
                    r_valid <= 0;
                    r_pixel <= {16'b0, i_pixel[32 +: 24], i_pixel[0 +: 24]};
                    temp_pixel <= '0;
                end

                1: begin
                    r_valid <= i_valid || (r_de && !i_de);
                    r_pixel <= {i_pixel[0 +: 16], r_pixel[0 +: 48]};
                    temp_pixel <= {i_pixel[32 +: 24], i_pixel[16 +: 8]};
                end

                2: begin
                    r_valid <= i_valid || (r_de && !i_de);
                    r_pixel <= {i_pixel[32 +: 8], i_pixel[0 +: 24], temp_pixel[0 +: 32]};
                    temp_pixel <= i_pixel[40 +: 16];
                end

                3: begin
                    r_valid <= i_valid || (r_de && !i_de);
                    r_pixel <= {i_pixel[32 +: 24], i_pixel[0 +: 24], temp_pixel[0 +: 16]};
                    temp_pixel <= '0;
                end
                endcase
            end
            
            RGB565: begin
                case (pack_state[0])
                0: begin
                    r_valid <= 0;
                    r_pixel <= {
                        32'b0,
                        i_pixel[48 + 3 +: 5],
                        i_pixel[40 + 2 +: 6],
                        i_pixel[32 + 3 +: 5],
                        i_pixel[16 + 3 +: 5],
                        i_pixel[8  + 2 +: 6],
                        i_pixel[0  + 3 +: 5]
                    };
                end

                1: begin
                    r_valid <= i_valid;
                    r_pixel <= {
                        i_pixel[48 + 3 +: 5],
                        i_pixel[40 + 2 +: 6],
                        i_pixel[32 + 3 +: 5],
                        i_pixel[16 + 3 +: 5],
                        i_pixel[8  + 2 +: 6],
                        i_pixel[0  + 3 +: 5],
                        r_pixel[0      +: 32]
                    };
                end
                endcase
            end

            default : begin
                r_pixel <= i_pixel;
                r_valid <= i_valid;
            end
        endcase
    end
end

assign tx_udp_ip_dscp = 0;
assign tx_udp_ip_ecn = 0;
assign tx_udp_ip_ttl = 64;
assign tx_udp_ip_source_ip = local_ip;
assign tx_udp_ip_dest_ip = udp_ip_dest_ip;
assign tx_udp_source_port = udp_source_port;
assign tx_udp_dest_port = udp_dest_port;
assign tx_udp_checksum = 0;
assign tx_udp_hdr_valid = rising_vsync ? 1 : tx_linepkt_hdr_valid;  // send data on every active lines 
assign tx_udp_length = rising_vsync ? 8 + 8 : tx_linepkt_hdr_pkt_length;    // 8 is header size; 4 is frame count
assign tx_linepkt_hdr_ready = rising_vsync ? 0 : tx_udp_hdr_ready;

// insert line count at rising edge of hsync. Assume hsync > de
// assuming r_valid, rising_de, rising_vsync are mutually exclusive
assign tx_fifo_udp_payload_axis_tdata = rising_vsync ? vsync_frame_header : tx_linepkt_axis_tdata;
assign tx_fifo_udp_payload_axis_tkeep = rising_vsync ? '1 : tx_linepkt_axis_tkeep;
assign tx_fifo_udp_payload_axis_tvalid = rising_vsync ? 1 : tx_linepkt_axis_tvalid;
assign tx_fifo_udp_payload_axis_tlast = rising_vsync ? 1 : tx_linepkt_axis_tlast;
assign tx_fifo_udp_payload_axis_tuser = rising_vsync ? 0 : tx_linepkt_axis_tuser;
assign tx_linepkt_axis_tready = rising_vsync ? 0 : tx_fifo_udp_payload_axis_tready;

assign rx_udp_hdr_ready = 1;
assign rx_udp_payload_axis_tready = 1;
// assign rx_fifo_udp_payload_axis_tdata = rx_udp_payload_axis_tdata;
// assign rx_fifo_udp_payload_axis_tkeep = rx_udp_payload_axis_tkeep;
// assign rx_fifo_udp_payload_axis_tvalid = rx_udp_payload_axis_tvalid;
// assign rx_fifo_udp_payload_axis_tlast = rx_udp_payload_axis_tlast;
// assign rx_fifo_udp_payload_axis_tuser = rx_udp_payload_axis_tuser;

logic valid_last = 0;
logic [31:0] eth_rx_count = 0;
logic [31:0] eth_tx_count = 0;
logic [7:0] exposure = 0;
logic [7:0] gain_r = 0;
logic [7:0] gain_g = 0;
logic [7:0] gain_b = 0;
logic rxpkt_valid_r;
logic [7:0] r_sfp0_txc;
logic [7:0] r_sfp0_rxc;
wire rxpkt_valid;
wire match_cond = rx_udp_dest_port == 1236;
assign rxpkt_valid = rxpkt_valid_r || (rx_udp_hdr_valid && rx_udp_hdr_ready && match_cond);
assign o_exposure = exposure;
assign o_gain_r = gain_r;
assign o_gain_g = gain_g;
assign o_gain_b = gain_b;
assign o_eth_rx_active = eth_rx_count[1];
assign o_eth_tx_active = eth_tx_count[15];

always_ff @(posedge clk_100m) begin
    clk_50m <= !clk_50m;
end

always_ff @(posedge clk) begin
    if (rst) begin
        rxpkt_valid_r <= '0;
        exposure <= '0;
        gain_r <= '0;
        gain_g <= '0;
        gain_b <= '0;
    end else begin
        rxpkt_valid_r <= rxpkt_valid;
        if (rxpkt_valid) begin
            if (rx_udp_payload_axis_tready && rx_udp_payload_axis_tvalid) begin
                rxpkt_valid_r <= 0;
                case (rx_udp_payload_axis_tdata[0+:8])
                    2: begin
                        exposure <= rx_udp_payload_axis_tdata[8+:8];
                        gain_r   <= rx_udp_payload_axis_tdata[16+:8];
                        gain_g   <= rx_udp_payload_axis_tdata[24+:8];
                        gain_b   <= rx_udp_payload_axis_tdata[32+:8];
                    end
                    default: ;
                endcase
            end
        end
    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        r_sfp0_txc   <= '0;
        eth_tx_count <= '0;
    end else begin
        r_sfp0_txc <= sfp0_txc;
        if (r_sfp0_txc != '0 && sfp0_txc == '0) begin
            eth_tx_count <= eth_tx_count + 1;
        end
    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        r_sfp0_rxc   <= '0;
        eth_rx_count <= '0;
    end else begin
        r_sfp0_rxc <= sfp0_rxc;
        if (r_sfp0_rxc != '0 && sfp0_rxc == '0) begin
            eth_rx_count <= eth_rx_count + 1;
        end
    end
end

line_to_packets #(
    .DEPTH(16384),
    .DATA_WIDTH(64),
    .KEEP_WIDTH(((64 + 7) / 8)),
    .ID_WIDTH(8),
    .DEST_WIDTH(8),
    .USER_WIDTH(1)
    // .PW(PW),
    // .IN_PCNT(IN_PCNT)
) u_line_to_packets (
    .clk(clk),
    .rst(video_rst),

    .i_vres(r_vres),
    .i_hres(r_hres),
    .i_vsync(r_vsync),
    .i_hsync(r_hsync),
    .i_de(r_de),
    .i_valid(r_valid),
    .i_pixel(r_pixel),
    .mss(mss),
    .pixel_mode(pixel_mode),

    .m_axis_tdata(tx_linepkt_axis_tdata),
    .m_axis_tkeep(tx_linepkt_axis_tkeep),
    .m_axis_tvalid(tx_linepkt_axis_tvalid),
    .m_axis_tready(tx_linepkt_axis_tready),
    .m_axis_tlast(tx_linepkt_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(tx_linepkt_axis_tuser),

    .m_hdr_ready(tx_linepkt_hdr_ready),
    .m_hdr_valid(tx_linepkt_hdr_valid),
    .pkt_length (tx_linepkt_hdr_pkt_length)
);

mac10gbe #() u_mac10gbe (
    .mac_reset_n                       (!video_rst),
    .mac10gbe_clk                      (clk),
    .init_clk                          (clk_50m),
    .init_rst_n                        (init_rst_n),
    .PMA_CMN_READY                     (PMA_CMN_READY),
    .PMA_XCVR_PLLCLK_EN_ACK            (PMA_XCVR_PLLCLK_EN_ACK),
    .PMA_XCVR_POWER_STATE_ACK          (PMA_XCVR_POWER_STATE_ACK),
    .PMA_RX_SIGNAL_DETECT              (PMA_RX_SIGNAL_DETECT),
    .PMA_XCVR_PLLCLK_EN                (PMA_XCVR_PLLCLK_EN),
    .PMA_XCVR_POWER_STATE_REQ          (PMA_XCVR_POWER_STATE_REQ),
    .phy_init_done                     (phy_init_done),
    .tx_axis_mac_tdata                 (tx_axis_tdata),
    .tx_axis_mac_tvalid                (tx_axis_tvalid),
    .tx_axis_mac_tlast                 (tx_axis_tlast),
    .tx_axis_mac_tkeep                 (tx_axis_tkeep),
    .tx_axis_mac_tuser                 (tx_axis_tuser),
    .tx_axis_mac_tready                (tx_axis_tready),
    
    .rx_axis_mac_tdata                 (rx_axis_tdata),
    .rx_axis_mac_tvalid                (rx_axis_tvalid),
    .rx_axis_mac_tlast                 (rx_axis_tlast),
    .rx_axis_mac_tkeep                 (rx_axis_tkeep),
    .rx_axis_mac_tuser                 (rx_axis_tuser),
    .rx_pause_ignore                   (),
    .tx_pause_gen                      (),
    .tx_pause_busy                     (),
    .tx_pause_quant                    (),
    .rx_address_filtering_mask         (),
    .cnt_rst_n                         (!video_rst),
    .cnt_tx_frame_transmitted_good     (),
    .cnt_tx_frame_pause_mac_ctrl       (),
    .cnt_tx_frame_error_txfifo_overflow(),
    .cnt_tx_frame_is_fe                (),
    .cnt_rx_frame_received_good        (),
    .cnt_rx_frame_error_fcs            (),
    .cnt_rx_frame_pause_mac_ctrl       (),
    .cnt_rx_frame_errors               (),
    .cnt_rx_frame_received_total       (),
    .cnt_rx_frame_undersized           (),
    .cnt_rx_frame_oversized            (),
    .cnt_rx_frame_mismatched_length    (),
    .cnt_rx_frame_filtered_by_address  (),
    .rpt_rx_frame_length               (),
    .XGMII_TXD                         (sfp0_txd),
    .XGMII_TXC                         (sfp0_txc),
    .XGMII_RXD                         (sfp0_rxd),
    .XGMII_RXC                         (sfp0_rxc)
);

axis_fifo #(
    .DATA_WIDTH(64),
    .DEPTH(4096),
    .KEEP_ENABLE(1),
    .ID_ENABLE(0),
    .DEST_ENABLE(0),
    .USER_ENABLE(1),
    .USER_WIDTH(1),
    .FRAME_FIFO(0)
) u_axis_fifo (
    .clk(clk),
    .rst(video_rst),

    .s_axis_tdata(rx_axis_tdata),
    .s_axis_tkeep(rx_axis_tkeep),
    .s_axis_tvalid(rx_axis_tvalid),
    .s_axis_tready(rx_axis_tready),
    .s_axis_tlast(rx_axis_tlast),
    .s_axis_tuser(rx_axis_tuser),

    .m_axis_tdata(rx_axis_fifo_tdata),
    .m_axis_tkeep(rx_axis_fifo_tkeep),
    .m_axis_tvalid(rx_axis_fifo_tvalid),
    .m_axis_tready(rx_axis_fifo_tready),
    .m_axis_tlast(rx_axis_fifo_tlast),
    .m_axis_tuser(rx_axis_fifo_tuser),

    .pause_req(0)
);

eth_axis_rx #(
    .DATA_WIDTH(64)
) eth_axis_rx_inst (
    .clk(clk),
    .rst(video_rst),
    // AXI input
    .s_axis_tdata(rx_axis_fifo_tdata),
    .s_axis_tkeep(rx_axis_fifo_tkeep),
    .s_axis_tvalid(rx_axis_fifo_tvalid),
    .s_axis_tready(rx_axis_fifo_tready),
    .s_axis_tlast(rx_axis_fifo_tlast),
    .s_axis_tuser(rx_axis_fifo_tuser),
    // Ethernet frame output
    .m_eth_hdr_valid(rx_eth_hdr_valid),
    .m_eth_hdr_ready(rx_eth_hdr_ready),
    .m_eth_dest_mac(rx_eth_dest_mac),
    .m_eth_src_mac(rx_eth_src_mac),
    .m_eth_type(rx_eth_type),
    .m_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
    .m_eth_payload_axis_tkeep(rx_eth_payload_axis_tkeep),
    .m_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tready(rx_eth_payload_axis_tready),
    .m_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
    // Status signals
    .busy(),
    .error_header_early_termination()
);

eth_axis_tx #(
    .DATA_WIDTH(64)
) eth_axis_tx_inst (
    .clk(clk),
    .rst(video_rst),
    // Ethernet frame input
    .s_eth_hdr_valid(tx_eth_hdr_valid),
    .s_eth_hdr_ready(tx_eth_hdr_ready),
    .s_eth_dest_mac(tx_eth_dest_mac),
    .s_eth_src_mac(tx_eth_src_mac),
    .s_eth_type(tx_eth_type),
    .s_eth_payload_axis_tdata(tx_eth_payload_axis_tdata),
    .s_eth_payload_axis_tkeep(tx_eth_payload_axis_tkeep),
    .s_eth_payload_axis_tvalid(tx_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tready(tx_eth_payload_axis_tready),
    .s_eth_payload_axis_tlast(tx_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(tx_eth_payload_axis_tuser),
    // AXI output
    .m_axis_tdata(tx_axis_tdata),
    .m_axis_tkeep(tx_axis_tkeep),
    .m_axis_tvalid(tx_axis_tvalid),
    .m_axis_tready(tx_axis_tready),
    .m_axis_tlast(tx_axis_tlast),
    .m_axis_tuser(tx_axis_tuser),
    // Status signals
    .busy()
);

udp_complete_64 #(
    .UDP_CHECKSUM_PAYLOAD_FIFO_DEPTH(32768),
    .UDP_CHECKSUM_HEADER_FIFO_DEPTH (128)
) udp_complete_inst (
    .clk(clk),
    .rst(video_rst),
    // Ethernet frame input
    .s_eth_hdr_valid(rx_eth_hdr_valid),
    .s_eth_hdr_ready(rx_eth_hdr_ready),
    .s_eth_dest_mac(rx_eth_dest_mac),
    .s_eth_src_mac(rx_eth_src_mac),
    .s_eth_type(rx_eth_type),
    .s_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
    .s_eth_payload_axis_tkeep(rx_eth_payload_axis_tkeep),
    .s_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tready(rx_eth_payload_axis_tready),
    .s_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
    // Ethernet frame output
    .m_eth_hdr_valid(tx_eth_hdr_valid),
    .m_eth_hdr_ready(tx_eth_hdr_ready),
    .m_eth_dest_mac(tx_eth_dest_mac),
    .m_eth_src_mac(tx_eth_src_mac),
    .m_eth_type(tx_eth_type),
    .m_eth_payload_axis_tdata(tx_eth_payload_axis_tdata),
    .m_eth_payload_axis_tkeep(tx_eth_payload_axis_tkeep),
    .m_eth_payload_axis_tvalid(tx_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tready(tx_eth_payload_axis_tready),
    .m_eth_payload_axis_tlast(tx_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(tx_eth_payload_axis_tuser),
    // IP frame input
    .s_ip_hdr_valid(tx_ip_hdr_valid),
    .s_ip_hdr_ready(tx_ip_hdr_ready),
    .s_ip_dscp(tx_ip_dscp),
    .s_ip_ecn(tx_ip_ecn),
    .s_ip_length(tx_ip_length),
    .s_ip_ttl(tx_ip_ttl),
    .s_ip_protocol(tx_ip_protocol),
    .s_ip_source_ip(tx_ip_source_ip),
    .s_ip_dest_ip(tx_ip_dest_ip),
    .s_ip_payload_axis_tdata(tx_ip_payload_axis_tdata),
    .s_ip_payload_axis_tkeep(tx_ip_payload_axis_tkeep),
    .s_ip_payload_axis_tvalid(tx_ip_payload_axis_tvalid),
    .s_ip_payload_axis_tready(tx_ip_payload_axis_tready),
    .s_ip_payload_axis_tlast(tx_ip_payload_axis_tlast),
    .s_ip_payload_axis_tuser(tx_ip_payload_axis_tuser),
    // IP frame output
    .m_ip_hdr_valid(rx_ip_hdr_valid),
    .m_ip_hdr_ready(rx_ip_hdr_ready),
    .m_ip_eth_dest_mac(rx_ip_eth_dest_mac),
    .m_ip_eth_src_mac(rx_ip_eth_src_mac),
    .m_ip_eth_type(rx_ip_eth_type),
    .m_ip_version(rx_ip_version),
    .m_ip_ihl(rx_ip_ihl),
    .m_ip_dscp(rx_ip_dscp),
    .m_ip_ecn(rx_ip_ecn),
    .m_ip_length(rx_ip_length),
    .m_ip_identification(rx_ip_identification),
    .m_ip_flags(rx_ip_flags),
    .m_ip_fragment_offset(rx_ip_fragment_offset),
    .m_ip_ttl(rx_ip_ttl),
    .m_ip_protocol(rx_ip_protocol),
    .m_ip_header_checksum(rx_ip_header_checksum),
    .m_ip_source_ip(rx_ip_source_ip),
    .m_ip_dest_ip(rx_ip_dest_ip),
    .m_ip_payload_axis_tdata(rx_ip_payload_axis_tdata),
    .m_ip_payload_axis_tkeep(rx_ip_payload_axis_tkeep),
    .m_ip_payload_axis_tvalid(rx_ip_payload_axis_tvalid),
    .m_ip_payload_axis_tready(rx_ip_payload_axis_tready),
    .m_ip_payload_axis_tlast(rx_ip_payload_axis_tlast),
    .m_ip_payload_axis_tuser(rx_ip_payload_axis_tuser),
    // UDP frame input
    .s_udp_hdr_valid(tx_udp_hdr_valid),
    .s_udp_hdr_ready(tx_udp_hdr_ready),
    .s_udp_ip_dscp(tx_udp_ip_dscp),
    .s_udp_ip_ecn(tx_udp_ip_ecn),
    .s_udp_ip_ttl(tx_udp_ip_ttl),
    .s_udp_ip_source_ip(tx_udp_ip_source_ip),
    .s_udp_ip_dest_ip(tx_udp_ip_dest_ip),
    .s_udp_source_port(tx_udp_source_port),
    .s_udp_dest_port(tx_udp_dest_port),
    .s_udp_length(tx_udp_length),
    .s_udp_checksum(tx_udp_checksum),
    .s_udp_payload_axis_tdata(tx_udp_payload_axis_tdata),
    .s_udp_payload_axis_tkeep(tx_udp_payload_axis_tkeep),
    .s_udp_payload_axis_tvalid(tx_udp_payload_axis_tvalid),
    .s_udp_payload_axis_tready(tx_udp_payload_axis_tready),
    .s_udp_payload_axis_tlast(tx_udp_payload_axis_tlast),
    .s_udp_payload_axis_tuser(tx_udp_payload_axis_tuser),
    // UDP frame output
    .m_udp_hdr_valid(rx_udp_hdr_valid),
    .m_udp_hdr_ready(rx_udp_hdr_ready),
    .m_udp_eth_dest_mac(rx_udp_eth_dest_mac),
    .m_udp_eth_src_mac(rx_udp_eth_src_mac),
    .m_udp_eth_type(rx_udp_eth_type),
    .m_udp_ip_version(rx_udp_ip_version),
    .m_udp_ip_ihl(rx_udp_ip_ihl),
    .m_udp_ip_dscp(rx_udp_ip_dscp),
    .m_udp_ip_ecn(rx_udp_ip_ecn),
    .m_udp_ip_length(rx_udp_ip_length),
    .m_udp_ip_identification(rx_udp_ip_identification),
    .m_udp_ip_flags(rx_udp_ip_flags),
    .m_udp_ip_fragment_offset(rx_udp_ip_fragment_offset),
    .m_udp_ip_ttl(rx_udp_ip_ttl),
    .m_udp_ip_protocol(rx_udp_ip_protocol),
    .m_udp_ip_header_checksum(rx_udp_ip_header_checksum),
    .m_udp_ip_source_ip(rx_udp_ip_source_ip),
    .m_udp_ip_dest_ip(rx_udp_ip_dest_ip),
    .m_udp_source_port(rx_udp_source_port),
    .m_udp_dest_port(rx_udp_dest_port),
    .m_udp_length(rx_udp_length),
    .m_udp_checksum(rx_udp_checksum),
    .m_udp_payload_axis_tdata(rx_udp_payload_axis_tdata),
    .m_udp_payload_axis_tkeep(rx_udp_payload_axis_tkeep),
    .m_udp_payload_axis_tvalid(rx_udp_payload_axis_tvalid),
    .m_udp_payload_axis_tready(rx_udp_payload_axis_tready),
    .m_udp_payload_axis_tlast(rx_udp_payload_axis_tlast),
    .m_udp_payload_axis_tuser(rx_udp_payload_axis_tuser),
    // Status signals
    .ip_rx_busy(ip_rx_busy),
    .ip_tx_busy(ip_tx_busy),
    .udp_rx_busy(udp_rx_busy),
    .udp_tx_busy(udp_tx_busy),
    .ip_rx_error_header_early_termination(ip_rx_error_header_early_termination),
    .ip_rx_error_payload_early_termination(ip_rx_error_payload_early_termination),
    .ip_rx_error_invalid_header(ip_rx_error_invalid_header),
    .ip_rx_error_invalid_checksum(ip_rx_error_invalid_checksum),
    .ip_tx_error_payload_early_termination(ip_tx_error_payload_early_termination),
    .ip_tx_error_arp_failed(ip_tx_error_arp_failed),
    .udp_rx_error_header_early_termination(udp_rx_error_header_early_termination),
    .udp_rx_error_payload_early_termination(udp_rx_error_payload_early_termination),
    .udp_tx_error_payload_early_termination(udp_tx_error_payload_early_termination),
    // Configuration
    .local_mac(local_mac),
    .local_ip(local_ip),
    .gateway_ip(gateway_ip),
    .subnet_mask(subnet_mask),
    .clear_arp_cache(1'b0)
);

axis_fifo #(
    .DEPTH(32768),
    .DATA_WIDTH(64),
    .KEEP_ENABLE(1),
    .KEEP_WIDTH(8),
    .ID_ENABLE(0),
    .DEST_ENABLE(0),
    .USER_ENABLE(1),
    .USER_WIDTH(1),
    .FRAME_FIFO(0)
) udp_payload_fifo (
    .clk(clk),
    .rst(video_rst),

    // AXI input
    .s_axis_tdata(tx_fifo_udp_payload_axis_tdata),
    .s_axis_tkeep(tx_fifo_udp_payload_axis_tkeep),
    .s_axis_tvalid(tx_fifo_udp_payload_axis_tvalid),
    .s_axis_tready(tx_fifo_udp_payload_axis_tready),
    .s_axis_tlast(tx_fifo_udp_payload_axis_tlast),
    .s_axis_tid(0),
    .s_axis_tdest(0),
    .s_axis_tuser(tx_fifo_udp_payload_axis_tuser),

    // AXI output
    .m_axis_tdata(tx_udp_payload_axis_tdata),
    .m_axis_tkeep(tx_udp_payload_axis_tkeep),
    .m_axis_tvalid(tx_udp_payload_axis_tvalid),
    .m_axis_tready(tx_udp_payload_axis_tready),
    .m_axis_tlast(tx_udp_payload_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(tx_udp_payload_axis_tuser),

    // Status
    .status_overflow  (),
    .status_bad_frame (),
    .status_good_frame()
);

endmodule
