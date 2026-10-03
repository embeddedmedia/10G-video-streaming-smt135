

module udp_video_generator #(

) (
    input clk_100m,
    input clk_156m,
    input clk_100m_rstn,
    input clk_156m_rstn,
    input mipi_clk,

    output o_cfg_done,
    output o_cam_active,
    output o_fb_active,
    output o_eth_rx_active,
    output o_eth_tx_active,

    // -------------------------------------------------------
    // -- SoC interface
    // -------------------------------------------------------
    input  [15:0] p0_apb3_paddr,
    input         p0_apb3_psel,
    input         p0_apb3_penable,
    output        p0_apb3_pready,
    input         p0_apb3_pwrite,
    input  [31:0] p0_apb3_pwdata,
    output [31:0] p0_apb3_prdata,
    output        p0_apb3_pslverror,

    input  [15:0] p1_apb3_paddr,
    input         p1_apb3_psel,
    input         p1_apb3_penable,
    output        p1_apb3_pready,
    input         p1_apb3_pwrite,
    input  [31:0] p1_apb3_pwdata,
    output [31:0] p1_apb3_prdata,
    output        p1_apb3_pslverror,

    // -------------------------------------------------------
    // -- Camera interface
    // -------------------------------------------------------
    DphyRx4LaneIface.slv    dphy_rx,
    output                  cam_en,

    // -------------------------------------------------------
    // -- DDR interface
    // -------------------------------------------------------
    output logic         ddr_ARSTN_0,
    output               ddr_ARQOS_0,
    output               ddr_AWQOS_0,
    output       [  5:0] ddr_AWID_0,
    output       [ 32:0] ddr_AWADDR_0,
    output       [  7:0] ddr_AWLEN_0,
    output       [  2:0] ddr_AWSIZE_0,
    output       [  1:0] ddr_AWBURST_0,
    output               ddr_AWVALID_0,
    output       [  3:0] ddr_AWCACHE_0,
    output               ddr_AWCOBUF_0,
    output               ddr_AWLOCK_0,
    output               ddr_AWAPCMD_0,
    output               ddr_AWALLSTRB_0,
    output       [  5:0] ddr_ARID_0,
    output       [ 32:0] ddr_ARADDR_0,
    output       [  7:0] ddr_ARLEN_0,
    output       [  2:0] ddr_ARSIZE_0,
    output       [  1:0] ddr_ARBURST_0,
    output               ddr_ARVALID_0,
    output               ddr_ARLOCK_0,
    output               ddr_ARAPCMD_0,
    output               ddr_WLAST_0,
    output               ddr_WVALID_0,
    output       [511:0] ddr_WDATA_0,
    output       [ 63:0] ddr_WSTRB_0,
    output               ddr_BREADY_0,
    output               ddr_RREADY_0,
    input                ddr_AWREADY_0,
    input                ddr_ARREADY_0,
    input                ddr_WREADY_0,
    input        [  5:0] ddr_BID_0,
    input        [  1:0] ddr_BRESP_0,
    input                ddr_BVALID_0,
    input        [  5:0] ddr_RID_0,
    input                ddr_RLAST_0,
    input                ddr_RVALID_0,
    input        [511:0] ddr_RDATA_0,
    input        [  1:0] ddr_RRESP_0,

    output cfg_start,
    output cfg_reset,
    output cfg_sel,
    input  cfg_done,

    // -------------------------------------------------------
    // -- ethernet interface
    // -------------------------------------------------------
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
    input  wire [63:0] sfp0_rxd,
    input  wire [ 7:0] sfp0_rxc

);

localparam MAX_HRES = 13'd3840;
localparam MAX_VRES = 13'd2160;

wire w_cfg_ok;
assign ddr_ARSTN_0 = clk_100m_rstn;

////////////////////////////////////////////////////////////////
// Debayer & RGB gain
logic [12:0] r_rx_frame_cnt;
logic [12:0] r_rx_x_mipi;
logic [12:0] r_rx_x_mipi_last;
logic [12:0] r_rx_y_mipi;
logic [63:0] r_rx_data;
logic [31:0] vs_interval;
logic [31:0] frame_interval;
logic [ 0:0] r_rx_hs = 0;
logic [ 0:0] r_rx_valid = 0;
logic [ 0:0] r_rx_vs = 0;
logic        r_frame_buf_vs;
logic [12:0] r_frame_buf_frame_cnt;

wire  [15:0] w_mipi_rx_wordcount;
wire  [ 1:0] w_mipi_rx_vc;
wire  [ 5:0] w_mipi_rx_dt;
wire         w_mipi_rx_vs;
wire         w_mipi_rx_hs;
wire         w_mipi_rx_valid;
wire  [63:0] w_mipi_rx_data;

wire         w_frame_buf_hs;
wire         w_frame_buf_vs;
wire         w_frame_buf_valid;
wire         w_frame_buf_de;
wire  [31:0] w_frame_buf_data;

wire         w_fb_vga_gen_hs;
wire         w_fb_vga_gen_vs;
wire         w_fb_vga_gen_valid;
wire         w_fb_vga_gen_de;
wire  [15:0] w_fb_vga_gen_x;
wire  [15:0] w_fb_vga_gen_y;

wire         video_156m_rstn;
wire         video_rstn;
wire         hdmi_reset;
wire  [15:0] dyn_hres;
wire  [15:0] dyn_H_SyncPulse;
wire  [15:0] dyn_H_BackPorch;
wire  [15:0] dyn_H_ActivePix;
wire  [15:0] dyn_H_FrontPorch;
wire  [15:0] dyn_V_SyncPulse;
wire  [15:0] dyn_V_BackPorch;
wire  [15:0] dyn_V_ActivePix;
wire  [15:0] dyn_V_FrontPorch;
wire  [15:0] dyn_P_Cnt;

wire         w_debayer_hs;
wire         w_debayer_vs;
wire         w_debayer_de;
wire         w_debayer_valid;
wire  [12:0] w_debayer_x;
wire  [12:0] w_debayer_y;
wire  [15:0] w_debayer_r;
wire  [15:0] w_debayer_g;
wire  [15:0] w_debayer_b;

wire         w_gain_vs;
wire         w_gain_hs;
wire         w_gain_de;
wire         w_gain_valid;
wire  [15:0] w_gain_r;
wire  [15:0] w_gain_g;
wire  [15:0] w_gain_b;
wire  [12:0] w_gain_x;
wire  [12:0] w_gain_y;

wire  [ 9:0] w_r_gain;
wire  [ 9:0] w_g_gain;
wire  [ 9:0] w_b_gain;
wire  [ 7:0] w_r_offset;
wire  [ 7:0] w_g_offset;
wire  [ 7:0] w_b_offset;
wire  [ 7:0] override_exposure;
wire  [ 7:0] override_gain_r;
wire  [ 7:0] override_gain_g;
wire  [ 7:0] override_gain_b;

wire  [31:0] local_ip;
wire  [31:0] gateway_ip;
wire  [31:0] dest_ip;
wire  [15:0] source_port;
wire  [15:0] dest_port;
wire  [15:0] mss;
wire  [ 7:0] pixel_mode;

assign cam_en = video_rstn;
assign dphy_rx.RESET_N = clk_100m_rstn;
assign dphy_rx.RST0_N = clk_100m_rstn;
assign o_cfg_done = w_cfg_ok;
assign o_cam_active = r_rx_frame_cnt[4];
assign o_fb_active = r_frame_buf_frame_cnt[4];

reset #(
    .IN_RST_ACTIVE("LOW"),
    .OUT_RST_ACTIVE("LOW"),
    .CYCLE(2)
) u_reset (
    .i_clk (clk_156m),
    .i_arst(video_rstn),
    .o_srst(video_156m_rstn)
);

cfg_fsm u0_cfg_fsm (
    .clk (clk_100m),
    .rstn(clk_100m_rstn),

    .cfg_sel_override  (0),
    .cfg_reset_override(0),
    .cfg_start         (cfg_start),
    .cfg_reset         (cfg_reset),
    .cfg_sel           (cfg_sel),
    .cfg_done          (cfg_done),
    .cfg_ok            (w_cfg_ok),
    .ddr_ctrl_rstn     (),
    .ddr_phy_rstn      (),

    .training_duration(),
    .dbg_cfg_st       ()
);

localparam NUM_DATA_LANE = 4;
// Mapping to DPHY RX IF
logic RxUlpsClkNot;
logic RxUlpsActiveClkNot;
logic [NUM_DATA_LANE-1:0] RxErrEsc;
logic [NUM_DATA_LANE-1:0] RxErrControl;
logic [NUM_DATA_LANE-1:0] RxErrSotSyncHS;
logic [NUM_DATA_LANE-1:0] RxClkEsc;
logic [NUM_DATA_LANE-1:0] RxUlpsEsc;
logic [NUM_DATA_LANE-1:0] RxUlpsActiveNot;
logic [NUM_DATA_LANE-1:0] RxSkewCalHS;
logic [NUM_DATA_LANE-1:0] RxStopState;
logic [NUM_DATA_LANE-1:0] RxValidHS;
logic [NUM_DATA_LANE-1:0] RxSyncHS;
logic [NUM_DATA_LANE-1:0][15:0] RxDataHS;

assign RxUlpsClkNot = dphy_rx.RX_ULPS_CLK_NOT;
assign RxUlpsActiveClkNot = dphy_rx.RX_ULPS_ACTIVE_CLK_NOT;
assign RxErrEsc[0] = dphy_rx.ERR_ESC_LAN0;
assign RxErrEsc[1] = dphy_rx.ERR_ESC_LAN1;
assign RxErrEsc[2] = dphy_rx.ERR_ESC_LAN2;
assign RxErrEsc[3] = dphy_rx.ERR_ESC_LAN3;
assign RxErrControl[0] = dphy_rx.LINESTATE_LAN0_ERROR;
assign RxErrControl[1] = dphy_rx.LINESTATE_LAN1_ERROR;
assign RxErrControl[2] = dphy_rx.LINESTATE_LAN2_ERROR;
assign RxErrControl[3] = dphy_rx.LINESTATE_LAN3_ERROR;
assign RxErrSotSyncHS[0] = dphy_rx.ERR_SOT_SYNC_HS_LAN0;
assign RxErrSotSyncHS[1] = dphy_rx.ERR_SOT_SYNC_HS_LAN1;
assign RxErrSotSyncHS[2] = dphy_rx.ERR_SOT_SYNC_HS_LAN2;
assign RxErrSotSyncHS[3] = dphy_rx.ERR_SOT_SYNC_HS_LAN3;
assign RxUlpsEsc[0] = dphy_rx.RX_ULPS_ESC_LAN0;
assign RxUlpsEsc[1] = dphy_rx.RX_ULPS_ESC_LAN1;
assign RxUlpsEsc[2] = dphy_rx.RX_ULPS_ESC_LAN2;
assign RxUlpsEsc[3] = dphy_rx.RX_ULPS_ESC_LAN3;
assign RxClkEsc[0] = dphy_rx.ESC_LAN0_CLK;
assign RxClkEsc[1] = dphy_rx.ESC_LAN1_CLK;
assign RxClkEsc[2] = dphy_rx.ESC_LAN2_CLK;
assign RxClkEsc[3] = dphy_rx.ESC_LAN3_CLK;
assign RxUlpsActiveNot[0] = dphy_rx.RX_ULPS_ACTIVE_NOT_LAN0;
assign RxUlpsActiveNot[1] = dphy_rx.RX_ULPS_ACTIVE_NOT_LAN1;
assign RxUlpsActiveNot[2] = dphy_rx.RX_ULPS_ACTIVE_NOT_LAN2;
assign RxUlpsActiveNot[3] = dphy_rx.RX_ULPS_ACTIVE_NOT_LAN3;
assign RxSkewCalHS[0] = dphy_rx.RX_SKEW_CAL_HS_LAN0;
assign RxSkewCalHS[1] = dphy_rx.RX_SKEW_CAL_HS_LAN1;
assign RxSkewCalHS[2] = dphy_rx.RX_SKEW_CAL_HS_LAN2;
assign RxSkewCalHS[3] = dphy_rx.RX_SKEW_CAL_HS_LAN3;
assign RxStopState[0] = dphy_rx.STOPSTATE_LAN0;
assign RxStopState[1] = dphy_rx.STOPSTATE_LAN1;
assign RxStopState[2] = dphy_rx.STOPSTATE_LAN2;
assign RxStopState[3] = dphy_rx.STOPSTATE_LAN3;
assign RxValidHS[0] = dphy_rx.RX_VALID_HS_LAN0;
assign RxValidHS[1] = dphy_rx.RX_VALID_HS_LAN1;
assign RxValidHS[2] = dphy_rx.RX_VALID_HS_LAN2;
assign RxValidHS[3] = dphy_rx.RX_VALID_HS_LAN3;
assign RxSyncHS[0] = dphy_rx.RX_SYNC_HS_LAN0;
assign RxSyncHS[1] = dphy_rx.RX_SYNC_HS_LAN1;
assign RxSyncHS[2] = dphy_rx.RX_SYNC_HS_LAN2;
assign RxSyncHS[3] = dphy_rx.RX_SYNC_HS_LAN3;
assign RxDataHS[0] = dphy_rx.RX_DATA_HS_LAN0;
assign RxDataHS[1] = dphy_rx.RX_DATA_HS_LAN1;
assign RxDataHS[2] = dphy_rx.RX_DATA_HS_LAN2;
assign RxDataHS[3] = dphy_rx.RX_DATA_HS_LAN3;

efx_csi2_rx_top_rx inst_csi2_rx_top (
    .reset_n        (clk_100m_rstn),
    .clk            (clk_100m),
    .reset_byte_HS_n(clk_100m_rstn),
    .clk_byte_HS    (dphy_rx.SLOWCLK),
    .reset_pixel_n  (video_rstn),
    .clk_pixel      (clk_100m),

    // PPI Interface
    .RxClkEsc          (RxClkEsc),
    .RxUlpsClkNot      (RxUlpsClkNot),
    .RxUlpsActiveClkNot(RxUlpsActiveClkNot),
    .RxErrEsc          (RxErrEsc),
    .RxErrControl      (RxErrControl),
    .RxErrSotSyncHS    (RxErrSotSyncHS),
    .RxUlpsEsc         (RxUlpsEsc),
    .RxUlpsActiveNot   (RxUlpsActiveNot),
    .RxSkewCalHS       (RxSkewCalHS),
    .RxStopState       (RxStopState),
    .RxSyncHS          (RxSyncHS),
    .RxDataHS0         (RxDataHS[0]),
    .RxDataHS1         (RxDataHS[1]),
    .RxDataHS2         (RxDataHS[2]),
    .RxDataHS3         (RxDataHS[3]),
    .RxDataHS4         (),
    .RxDataHS5         (),
    .RxDataHS6         (),
    .RxDataHS7         (),
    .RxValidHS0        ({RxValidHS[0], RxValidHS[0]}),
    .RxValidHS1        ({RxValidHS[1], RxValidHS[1]}),
    .RxValidHS2        ({RxValidHS[2], RxValidHS[2]}),
    .RxValidHS3        ({RxValidHS[3], RxValidHS[3]}),
    .RxValidHS4        (),
    .RxValidHS5        (),
    .RxValidHS6        (),
    .RxValidHS7        (),

    .axi_clk    (clk_100m),
    .axi_reset_n(reset_mipi_n),
    .axi_awaddr (rx_axi_awaddr),
    .axi_awvalid(rx_axi_awvalid),
    .axi_awready(rx_axi_awready),
    .axi_wdata  (rx_axi_wdata),
    .axi_wvalid (rx_axi_wvalid),
    .axi_wready (rx_axi_wready),
    .axi_bvalid (rx_axi_bvalid),
    .axi_bready (rx_axi_bready),
    .axi_araddr (rx_axi_araddr),
    .axi_arvalid(rx_axi_arvalid),
    .axi_arready(rx_axi_arready),
    .axi_rdata  (rx_axi_rdata),
    .axi_rvalid (rx_axi_rvalid),
    .axi_rready (rx_axi_rready),

    .hsync_vc0(w_mipi_rx_hs),
    .vsync_vc0(w_mipi_rx_vs),

    .vc                 (w_mipi_rx_vc),
    .vcx                (),
    .word_count         (w_mipi_rx_wordcount),
    .shortpkt_data_field(),
    .datatype           (w_mipi_rx_dt),         // RAW8
    .pixel_per_clk      (),
    .pixel_data         (w_mipi_rx_data),
    .pixel_data_valid   (w_mipi_rx_valid),
    .irq                ()

);


always @(negedge clk_100m_rstn or posedge clk_100m) begin
    if (~clk_100m_rstn) begin
        r_rx_frame_cnt   <= '0;
        r_rx_x_mipi      <= '0;
        r_rx_x_mipi_last <= '0;
        r_rx_y_mipi      <= '0;
        r_rx_hs          <= '0;
        r_rx_valid       <= '0;
        r_rx_vs          <= '0;
        vs_interval      <= '0;
        r_rx_data        <= '0;
    end else begin
        r_rx_vs   <= w_mipi_rx_vs;
        r_rx_hs   <= w_mipi_rx_hs;
        r_rx_data <= w_mipi_rx_data;

        if (w_mipi_rx_valid && (r_rx_x_mipi << 2) < MAX_HRES && r_rx_y_mipi < MAX_VRES && w_mipi_rx_dt == 6'h2B) begin
            r_rx_valid <= 1;
        end else begin
            r_rx_valid <= 0;
        end

        if (w_mipi_rx_vs) vs_interval <= vs_interval + 1;

        if (w_mipi_rx_hs) begin  //x count of 1st data is 0
            if (w_mipi_rx_valid) begin
                r_rx_x_mipi <= r_rx_x_mipi + 1'b1;
                r_rx_x_mipi_last <= r_rx_x_mipi;
            end
        end else begin
            r_rx_x_mipi <= {13{1'b0}};
            r_rx_x_mipi_last <= 0;
        end

        if (!w_mipi_rx_vs && r_rx_vs) begin
            r_rx_y_mipi <= {13{1'b0}};
            vs_interval <= 32'd0;
            frame_interval <= vs_interval;
            r_rx_frame_cnt <= r_rx_frame_cnt + 1;
        end else if (~w_mipi_rx_hs && r_rx_hs) begin
            r_rx_y_mipi <= r_rx_y_mipi + 1'b1;
        end
    end
end

logic [31:0] pixel_sum;
logic [31:0] pixel_sum_reg;
logic [31:0] pixel_cnt;
logic [31:0] pixel_cnt_reg;
always_ff @(posedge clk_100m or negedge video_rstn) begin
    if (!video_rstn) begin
        pixel_sum <= '0;
        pixel_sum_reg <= '0;
    end else begin
        if (!r_rx_vs) begin
            pixel_sum <= '0;
            pixel_cnt <= '0;
        end else if (r_rx_hs && r_rx_valid) begin
            pixel_sum <= pixel_sum + r_rx_data[9:2] + r_rx_data[19:12] + r_rx_data[29:22] + r_rx_data[39:32];
            pixel_cnt <= pixel_cnt + 4;
        end

        if (!w_mipi_rx_vs && r_rx_vs) begin
            pixel_sum_reg <= pixel_sum;
            pixel_cnt_reg <= pixel_cnt;
        end
    end
end

vga_gen_dynamic #(
    .PW(16)
) inst_vga_gen_P2 (
    .in_pclk(clk_156m),
    .in_rstn(video_156m_rstn),

    .out_hs(w_fb_vga_gen_hs),
    .out_vs(w_fb_vga_gen_vs),
    .out_de(w_fb_vga_gen_de),
    .out_valid(w_fb_vga_gen_valid),
    .out_x(w_fb_vga_gen_x),
    .out_y(w_fb_vga_gen_y),

    .H_SyncPulse (dyn_H_SyncPulse),
    .H_BackPorch (dyn_H_BackPorch),
    .H_ActivePix (dyn_H_ActivePix),
    .H_FrontPorch (dyn_H_FrontPorch),
    .V_SyncPulse (dyn_V_SyncPulse),
    .V_BackPorch (dyn_V_BackPorch),
    .V_ActivePix (dyn_V_ActivePix),
    .V_FrontPorch (dyn_V_FrontPorch),
    .P_Cnt   (dyn_P_Cnt),
    .start_delay (0)
);

frame_buffer_512 inst_frame_buffer_512 (
    .wr_p_clk_0(clk_100m),
    .wr_p_clk_1(clk_100m),
    .rd_p_clk_0(clk_156m),
    .rd_p_clk_1(clk_156m),
    .axi_clk   (clk_100m),
    .axi_rstn  (clk_100m_rstn),
    .wr_rstn_0 (video_rstn),
    .wr_rstn_1 (video_rstn),
    .rd_rstn_0 (video_156m_rstn),
    .rd_rstn_1 (video_156m_rstn),

    .x_win_wr_0  (dyn_hres),
    .x_win_wr_1  (dyn_hres),
    .x_win_rd_0  (dyn_hres),
    .x_win_rd_1  (dyn_hres),
    .x_start_wr_0(13'd0),
    .x_start_wr_1(13'd0),
    .x_start_rd_0(13'd0),
    .x_start_rd_1(13'd0),
    .y_win_wr_0  (dyn_V_ActivePix),
    .y_win_wr_1  (1),
    .y_win_rd_0  (dyn_V_ActivePix),
    .y_win_rd_1  (dyn_V_ActivePix),
    .y_start_wr_0(13'd0),
    .y_start_wr_1(13'd0),
    .y_start_rd_0(13'd0),
    .y_start_rd_1(13'd0),

    .arid   (ddr_ARID_0),
    .araddr (ddr_ARADDR_0),
    .arlen  (ddr_ARLEN_0),
    .arsize (ddr_ARSIZE_0),
    .arburst(ddr_ARBURST_0),
    .arlock (ddr_ARLOCK_0),
    .arvalid(ddr_ARVALID_0),
    .arready(ddr_ARREADY_0),
    .awid   (ddr_AWID_0),
    .awaddr (ddr_AWADDR_0),
    .awlen  (ddr_AWLEN_0),
    .awsize (ddr_AWSIZE_0),
    .awburst(ddr_AWBURST_0),
    .awlock (ddr_AWLOCK_0),
    .awvalid(ddr_AWVALID_0),
    .awready(ddr_AWREADY_0),
    .wdata  (ddr_WDATA_0),
    .wstrb  (ddr_WSTRB_0),
    .wlast  (ddr_WLAST_0),
    .wvalid (ddr_WVALID_0),
    .wready (ddr_WREADY_0),
    .rid    (ddr_RID_0),
    .rdata  (ddr_RDATA_0),
    .rlast  (ddr_RLAST_0),
    .rvalid (ddr_RVALID_0),
    .rready (ddr_RREADY_0),
    .bid    (ddr_BID_0),
    .bvalid (ddr_BVALID_0),
    .bready (ddr_BREADY_0),

    .in_0_x_wr (r_rx_x_mipi_last << 2),  //<< 2 becuase 1 cnt = 4 pixels
    .in_0_y_wr (r_rx_y_mipi),
    .in_0_wr_en(r_rx_valid),
    .in_0_hs   (r_rx_hs),
    .in_0_vs   (r_rx_vs),
    .in_0_wr_00(r_rx_data[9:2]),
    .in_0_wr_01(r_rx_data[19:12]),
    .in_0_wr_10(r_rx_data[29:22]),
    .in_0_wr_11(r_rx_data[39:32]),

    .in_1_x_wr (0),
    .in_1_y_wr (0),
    .in_1_wr_en(0),
    .in_1_hs   (0),
    .in_1_vs   (0),
    .in_1_wr_00(0),
    .in_1_wr_01(0),
    .in_1_wr_10(0),
    .in_1_wr_11(0),

    .in_0_de   (w_fb_vga_gen_de),
    .in_0_valid(w_fb_vga_gen_valid),
    .in_0_hsync(w_fb_vga_gen_hs),
    .in_0_vsync(w_fb_vga_gen_vs),

    .in_1_de   (0),
    .in_1_valid(0),
    .in_1_hsync(0),
    .in_1_vsync(0),

    .out_0_de   (w_frame_buf_de),
    .out_0_valid(w_frame_buf_valid),
    .out_0_hsync(w_frame_buf_hs),
    .out_0_vsync(w_frame_buf_vs),
    .out_0_rd_00(w_frame_buf_data[7:0]),
    .out_0_rd_01(w_frame_buf_data[15:8]),
    .out_0_rd_10(w_frame_buf_data[23:16]),
    .out_0_rd_11(w_frame_buf_data[31:24]),

    .out_1_de   (),
    .out_1_valid(),
    .out_1_hsync(),
    .out_1_vsync(),
    .out_1_rd_00(),
    .out_1_rd_01(),
    .out_1_rd_10(),
    .out_1_rd_11()
);

always_ff @(posedge clk_156m or negedge video_156m_rstn) begin
    if (!video_156m_rstn) begin
        r_frame_buf_frame_cnt <= '0;
        r_frame_buf_vs <= '0;
    end else begin
        r_frame_buf_vs <= w_frame_buf_vs;
        if (!w_frame_buf_vs && r_frame_buf_vs) begin
            r_frame_buf_frame_cnt <= r_frame_buf_frame_cnt + 1;
        end
    end
end

apb3_slave_video #(
    .ADDR_WIDTH(10),
    .DATA_WIDTH(32)
) inst_mipi_abp (
    .clk   (clk_100m),
    .resetn(clk_100m_rstn),

    .PADDR    (p0_apb3_paddr),
    .PSEL     (p0_apb3_psel),
    .PENABLE  (p0_apb3_penable),
    .PREADY   (p0_apb3_pready),
    .PWRITE   (p0_apb3_pwrite),
    .PWDATA   (p0_apb3_pwdata),
    .PRDATA   (p0_apb3_prdata),
    .PSLVERROR(p0_apb3_pslverror),

    .pixel_avg(pixel_sum_reg),
    .pixel_cnt(pixel_cnt_reg),
    .override_exposure(override_exposure),
    .override_gain_r(override_gain_r),
    .override_gain_g(override_gain_g),
    .override_gain_b(override_gain_b),
    .gain_r   (w_r_gain),
    .gain_g   (w_g_gain),
    .gain_b   (w_b_gain),
    .offset_r (w_r_offset),
    .offset_g (w_g_offset),
    .offset_b (w_b_offset),
    .frame_interval (frame_interval),

    .video_rstn      (video_rstn),
    .dyn_hres        (dyn_hres),
    .dyn_H_SyncPulse (dyn_H_SyncPulse),
    .dyn_H_BackPorch (dyn_H_BackPorch),
    .dyn_H_ActivePix (dyn_H_ActivePix),
    .dyn_H_FrontPorch(dyn_H_FrontPorch),
    .dyn_V_SyncPulse (dyn_V_SyncPulse),
    .dyn_V_BackPorch (dyn_V_BackPorch),
    .dyn_V_ActivePix (dyn_V_ActivePix),
    .dyn_V_FrontPorch(dyn_V_FrontPorch),
    .dyn_P_Cnt       (dyn_P_Cnt),
    .hdmi_reset      (hdmi_reset),
    .local_ip        (local_ip),
    .gateway_ip      (gateway_ip),
    .dest_ip         (dest_ip),
    .source_port     (source_port),
    .dest_port       (dest_port),
    .mss             (mss),
    .pixel_mode      (pixel_mode)

);

raw2rgb #(
    .MAX_HRES  (3840),
    .MAX_VRES  (2160),
    .MAX_HTOTAL(4400),
    .MAX_VTOTAL(2250)
) inst_raw2rgb (
    .i_pclk(clk_156m),
    .i_rstn(video_156m_rstn),

    .i_vsync(w_frame_buf_vs),
    .i_hsync(w_frame_buf_hs),
    .i_de(w_frame_buf_de),
    .i_valid(w_frame_buf_valid),
    .i_raw(w_frame_buf_data),

    .o_vsync(w_debayer_vs),
    .o_hsync(w_debayer_hs),
    .o_de(w_debayer_de),
    .o_valid(w_debayer_valid),
    .o_x_cnt(w_debayer_x),
    .o_y_cnt(w_debayer_y),
    .o_r(w_debayer_r),
    .o_g(w_debayer_g),
    .o_b(w_debayer_b)
);

gain #(
    .SUBPIXEL_WIDTH(8),
    .PIXEL_CNT(2)
) inst0_rgb_gain (
    .i_pclk      (clk_156m),
    .i_arstn     (video_156m_rstn),
    .red_gain    (w_r_gain),
    .green_gain  (w_g_gain),
    .blue_gain   (w_b_gain),
    .red_offset  (w_r_offset),
    .green_offset(w_g_offset),
    .blue_offset (w_b_offset),

    .i_hs   (w_debayer_hs),
    .i_vs   (w_debayer_vs),
    .i_de   (w_debayer_de),
    .i_valid(w_debayer_valid),
    .i_x    (w_debayer_x),
    .i_y    (w_debayer_y),
    .i_r    (w_debayer_r),
    .i_g    (w_debayer_g),
    .i_b    (w_debayer_b),


    .o_hs   (w_gain_hs),
    .o_vs   (w_gain_vs),
    .o_de   (w_gain_de),
    .o_valid(w_gain_valid),
    .o_x    (w_gain_x),
    .o_y    (w_gain_y),
    .o_r    (w_gain_r),
    .o_g    (w_gain_g),
    .o_b    (w_gain_b)
);

ethernet_core #(
    .PW(32),
    .IN_PCNT(2)
) inst_ethernet_core (
    .clk(clk_156m),
    .clk_100m(clk_100m),
    .rst(!clk_156m_rstn),
    .video_rst(!video_156m_rstn),

    .o_eth_rx_active(o_eth_rx_active),
    .o_eth_tx_active(o_eth_tx_active),

    .local_mac(48'h02_00_00_00_00_00),
    .local_ip(local_ip),
    .gateway_ip(gateway_ip),
    .subnet_mask({8'd255, 8'd255, 8'd255, 8'd0}),
    .udp_ip_dest_ip(dest_ip),
    .udp_source_port(source_port),
    .udp_dest_port(dest_port),
    .mss(mss),
    .pixel_mode(pixel_mode),

    .i_vres(dyn_V_ActivePix),
    .i_hres(dyn_hres),
    .i_vsync(w_gain_vs),
    .i_hsync(w_gain_hs),
    .i_de(w_gain_de),
    .i_valid(w_gain_valid),
    .i_pixel({
        8'b0,
        w_gain_b[8+:8],
        w_gain_g[8+:8],
        w_gain_r[8+:8],
        8'b0,
        w_gain_b[0+:8],
        w_gain_g[0+:8],
        w_gain_r[0+:8]
    }),
    .o_exposure(override_exposure),
    .o_gain_r(override_gain_r),
    .o_gain_g(override_gain_g),
    .o_gain_b(override_gain_b),

    .p1_apb3_prdata(p1_apb3_prdata),
    .p1_apb3_pready(p1_apb3_pready),
    .p1_apb3_paddr(p1_apb3_paddr),
    .p1_apb3_pwdata(p1_apb3_pwdata),
    .p1_apb3_pwrite(p1_apb3_pwrite),
    .p1_apb3_psel(p1_apb3_psel),
    .p1_apb3_penable(p1_apb3_penable),
    .p1_apb3_pslverror(p1_apb3_pslverror),

    .init_rst_n(init_rst_n),
    .PMA_CMN_READY(PMA_CMN_READY),
    .PMA_XCVR_PLLCLK_EN_ACK(PMA_XCVR_PLLCLK_EN_ACK),
    .PMA_XCVR_POWER_STATE_ACK(PMA_XCVR_POWER_STATE_ACK),
    .PMA_RX_SIGNAL_DETECT(PMA_RX_SIGNAL_DETECT),
    .PMA_XCVR_PLLCLK_EN(PMA_XCVR_PLLCLK_EN),
    .PMA_XCVR_POWER_STATE_REQ(PMA_XCVR_POWER_STATE_REQ),
    .sfp0_txd(sfp0_txd),
    .sfp0_txc(sfp0_txc),
    .sfp0_rxd(sfp0_rxd),
    .sfp0_rxc(sfp0_rxc)
);



endmodule
