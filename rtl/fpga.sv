
module fpga (
    // -------------------------------------------------------
    // -- clock and PLL
    // -------------------------------------------------------
    input        clk_100m,
    input        sfp0_iface_clk,
    input        pll_locked,
    input       pll_inst2_LOCKED,

    // -------------------------------------------------------
    // -- GPIO
    // -------------------------------------------------------
    input  [1:0] sw,
    output [5:0] led,
    output scl_debug,
    output sda_debug,

    // -------------------------------------------------------
    // -- Camera interface
    // -------------------------------------------------------
    DphyRx4LaneIface.slv dphy_rx1,
    output               cam_en,
    input                cam_sda_IN,
    output               cam_sda_OUT,
    output               cam_sda_OE,
    input                cam_scl_IN,
    output               cam_scl_OUT,
    output               cam_scl_OE,

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

    output               cfg_start,
    output               cfg_reset,
    output               cfg_sel,
    input                cfg_done,

    // -------------------------------------------------------
    // -- RISCV; UART: 115200 bps, 8N1
    // -------------------------------------------------------
    output wire system_spi_0_io_sclk_write,
    output wire system_spi_0_io_data_0_writeEnable,
    input       system_spi_0_io_data_0_read,
    output wire system_spi_0_io_data_0_write,
    output wire system_spi_0_io_data_1_writeEnable,
    input       system_spi_0_io_data_1_read,
    output wire system_spi_0_io_data_1_write,
    output wire system_spi_0_io_ss,

    input       uart_rxd,
    output      uart_txd,

    //input       riscv_tdi,
    //input       riscv_tms,
    //input       riscv_tck,
    //output      riscv_tdo,

    input jtag_inst1_TCK,
    input jtag_inst1_TDI,
    output jtag_inst1_TDO,
    input jtag_inst1_SEL,
    input jtag_inst1_CAPTURE,
    input jtag_inst1_SHIFT,
    input jtag_inst1_UPDATE,
    input jtag_inst1_RESET,

    

    // -------------------------------------------------------
    // -- 10G Ethernet
    // -------------------------------------------------------
    input         cmn_inst1_USER_APB_PREADY,
    input  [31:0] cmn_inst1_USER_APB_PRDATA,
    input         cmn_inst1_USER_APB_PSLVERR,
    output [23:0] cmn_inst1_USER_APB_PADDR,
    output        cmn_inst1_USER_APB_PENABLE,
    output        cmn_inst1_USER_APB_PWRITE,
    output        cmn_inst1_USER_APB_PSEL,
    output [31:0] cmn_inst1_USER_APB_PWDATA,

    input         cmn_inst1_PMA_CMN_READY,

    input         sfp0_IRQ,
    input         sfp0_BLOCK_LOCK,
    input  [63:0] sfp0_RXD,
    input  [ 7:0] sfp0_RXC,
    input         sfp0_HI_BER,
    input  [ 3:0] sfp0_PMA_XCVR_POWER_STATE_ACK,
    input         sfp0_PHY_INTERRUPT,
    input         sfp0_PCS_STATUS,
    input         sfp0_PMA_RX_SIGNAL_DETECT,
    input         sfp0_PMA_XCVR_PLLCLK_EN_ACK,
    output [63:0] sfp0_TXD,
    output [ 3:0] sfp0_PMA_XCVR_POWER_STATE_REQ,
    output [ 7:0] sfp0_TXC,
    output        sfp0_PMA_TX_ELEC_IDLE,
    output        sfp0_PHY_RESET_N,
    output        sfp0_PCS_RST_N_RX,
    output        sfp0_ETH_EEE_ALERT_EN,
    output        sfp0_PCS_RST_N_TX,
    output        sfp0_PMA_XCVR_PLLCLK_EN
    // input         sfp0_KR_FRAME_LOCK,
    // input         sfp0_KR_TRAINING_FAILURE,
    // input         sfp0_KR_TRAINING,
    // input         sfp0_KR_SIGNAL_DETECT,
    // input         sfp0_KR_LOCAL_RX_TRAINED,
    // output        sfp0_KR_RESTART_TRAINING,
    // output        sfp0_KR_TRAINING_ENABLE
);

wire rstn_100mhz_int;
wire clk_156m;
wire rst_156mhz_int;
wire i_arstn;
wire sw_rstn;

assign sfp0_PCS_RST_N_RX = rstn_100mhz_int;
assign sfp0_PCS_RST_N_TX = rstn_100mhz_int;
assign sfp0_PHY_RESET_N = rstn_100mhz_int;
assign i_arstn = sw[0];

assign scl_debug = cam_sda_IN;
assign sda_debug = cam_scl_IN;

wire kr_restart_training;
wire w_KR_RESTART_TRAINING;
wire [31:0] serdes_addr_base;

wire        sfp0_tx_clk_int;
wire        sfp0_tx_rst_int;
wire        sfp0_rx_clk_int;
wire        sfp0_rx_rst_int;

wire        apb_rom_end_o;
wire        apb_done_o;
wire [15:0] HW_APB_PADDR;
wire        HW_USER_APB_PSEL;
wire        HW_USER_APB_PENABLE;
wire        HW_USER_APB_PREADY;
wire        HW_USER_APB_PWRITE;
wire [31:0] HW_USER_APB_PWDATA;
wire [31:0] HW_USER_APB_PRDATA;
wire        HW_USER_APB_PSLVERROR;

wire [31:0] p2_apb3_prdata;
wire        p2_apb3_pready;
wire [19:0] p2_apb3_paddr;
wire [31:0] p2_apb3_pwdata;
wire        p2_apb3_pwrite;
wire        p2_apb3_psel;
wire        p2_apb3_penable;

wire [31:0] p3_apb3_prdata;
wire        p3_apb3_pready;
wire [19:0] p3_apb3_paddr;
wire [31:0] p3_apb3_pwdata;
wire        p3_apb3_pwrite;
wire        p3_apb3_psel;
wire        p3_apb3_penable;
wire        p3_apb3_pslverror;

wire        sfp0_reset_done;
wire        sfp1_reset_done;

assign clk_156m = sfp0_iface_clk;
// assign rst_156mhz_int = !init_done;
assign sfp0_tx_clk_int = sfp0_iface_clk;
assign sfp0_rx_clk_int = sfp0_iface_clk;

reset #(
    .IN_RST_ACTIVE("LOW"),
    .OUT_RST_ACTIVE("LOW"),
    .CYCLE(2)
) u_reset (
    .i_arst(pll_locked && pll_inst2_LOCKED && i_arstn),
    .i_clk (clk_100m),
    .o_srst(rstn_100mhz_int)
);

// GPIO
wire btnu_int;
wire btnl_int;
wire btnd_int;
wire btnr_int;
wire btnc_int;
wire [1:0] sw_int;

debounce_switch #(
    .WIDTH(2),
    .N(8),
    .RATE(156000)
) debounce_switch_inst (
    .clk(clk_100m),
    .rst(!rstn_100mhz_int),
    .in ({sw}),
    .out({sw_int})
);

reset #(
    .IN_RST_ACTIVE("LOW"),
    .OUT_RST_ACTIVE("HIGH"),
    .CYCLE(4)
) tx_reset_sync_inst (
    .i_arst(apb_done_o),
    .i_clk (sfp0_tx_clk_int),
    .o_srst(sfp0_tx_rst_int)
);

reset #(
    .IN_RST_ACTIVE("LOW"),
    .OUT_RST_ACTIVE("HIGH"),
    .CYCLE(4)
) rx_reset_sync_inst (
    .i_arst(apb_done_o),
    .i_clk (sfp0_rx_clk_int),
    .o_srst(sfp0_rx_rst_int)
);

reset #(
    .IN_RST_ACTIVE("LOW"),
    .OUT_RST_ACTIVE("HIGH"),
    .CYCLE(4)
) rst_156mhz_reset_sync_inst (
    .i_arst(apb_done_o && sw_rstn),
    .i_clk (clk_156m),
    .o_srst(rst_156mhz_int)
);

assign HW_USER_APB_PREADY = cmn_inst1_USER_APB_PREADY;
assign HW_USER_APB_PRDATA = cmn_inst1_USER_APB_PRDATA;
assign p2_apb3_pready = cmn_inst1_USER_APB_PREADY;
assign p2_apb3_prdata = cmn_inst1_USER_APB_PRDATA;

assign cmn_inst1_USER_APB_PSEL = (apb_done_o == 1'b0) ? HW_USER_APB_PSEL : p2_apb3_psel;
assign cmn_inst1_USER_APB_PWRITE = (apb_done_o == 1'b0) ? HW_USER_APB_PWRITE : p2_apb3_pwrite;
assign cmn_inst1_USER_APB_PENABLE   = (apb_done_o == 1'b0) ? HW_USER_APB_PENABLE  :  p2_apb3_penable;
assign cmn_inst1_USER_APB_PWDATA = (apb_done_o == 1'b0) ? HW_USER_APB_PWDATA : p2_apb3_pwdata;
assign cmn_inst1_USER_APB_PADDR     = (apb_done_o == 1'b0) ? {3'b110, 10'b0, HW_APB_PADDR[10:0]}:{{serdes_addr_base[0 +: 6], p2_apb3_paddr[2 +: 18]}};


localparam RAM_ADDR_W = 5;
localparam ROM_DEPTH = 20;
localparam PADDR_WIDTH = 19;
localparam PDATA_WIDTH = 32;
apb_master #(
    .ROM_MIF    ("efx_rom_mif.mem"),
    .ROM_DEPTH  (ROM_DEPTH),
    .RAM_ADDR_W (RAM_ADDR_W),
    .PADDR_WIDTH(PADDR_WIDTH),
    .PDATA_WIDTH(PDATA_WIDTH)
) q1_apb_master (
    .apb_halt_i   (0),
    .apb_rom_end_o(apb_rom_end_o),
    .apb_done_o   (apb_done_o),

    .ram_usr_wren_i(),
    .ram_usr_addr_i(),
    .ram_dout_d_o  (),
    .ram_dout_a_o  (),

    .usr_apb_start_i (),
    .usr_apb_write_i (),
    .usr_apb_addr_i  (),
    .usr_apb_pwdata_i(),

    .PCLK   (clk_100m),
    .PRESETn(rstn_100mhz_int),
    .PSEL   (HW_USER_APB_PSEL),
    .PWRITE (HW_USER_APB_PWRITE),
    .PENABLE(HW_USER_APB_PENABLE),
    .PADDR  (HW_APB_PADDR),
    .PWDATA (HW_USER_APB_PWDATA),
    .PRDATA (HW_USER_APB_PRDATA),
    .PREADY (HW_USER_APB_PREADY),
    .PSLVERR(0)
);


wire        cam_scl_write;
wire        cam_sda_write;
//APB3 Interface from SoC
wire [19:0] p0_apb3_paddr;
wire        p0_apb3_psel;
wire        p0_apb3_penable;
wire        p0_apb3_pready;
wire        p0_apb3_pwrite;
wire [31:0] p0_apb3_pwdata;
wire [31:0] p0_apb3_prdata;
wire        p0_apb3_pslverror;

//APB3 Interface from SoC
wire [19:0] p1_apb3_paddr;
wire        p1_apb3_psel;
wire        p1_apb3_penable;
wire        p1_apb3_pready;
wire        p1_apb3_pwrite;
wire [31:0] p1_apb3_pwdata;
wire [31:0] p1_apb3_prdata;
wire        p1_apb3_pslverror;
//APB3 Interface from SoC
wire [19:0] p2_apb3_paddr;
wire        p2_apb3_psel;
wire        p2_apb3_penable;
wire        p2_apb3_pready;
wire        p2_apb3_pwrite;
wire [31:0] p2_apb3_pwdata;
wire [31:0] p2_apb3_prdata;
wire        p2_apb3_pslverror;

apb3_slave #(
    .ADDR_WIDTH(20),
    .DATA_WIDTH(32)
) inst_mipi_abp (
    .clk   (clk_100m),
    .resetn(rstn_100mhz_int),

    .serdes_addr_base(serdes_addr_base),
    .restart_over(kr_restart_training),

    .training_failure(sfp0_KR_TRAINING_FAILURE),
    .init_done(0),
    .block_lock(sfp0_BLOCK_LOCK),
    .frame_lock(sfp0_KR_FRAME_LOCK),
    .sw_rstn(sw_rstn),

    .PADDR    (p1_apb3_paddr),
    .PSEL     (p1_apb3_psel),
    .PENABLE  (p1_apb3_penable),
    .PREADY   (p1_apb3_pready),
    .PWRITE   (p1_apb3_pwrite),
    .PWDATA   (p1_apb3_pwdata),
    .PRDATA   (p1_apb3_prdata),
    .PSLVERROR()
);

sapphire_gen inst_sapphire (
    //user custom ports
    //SOC
    .io_systemClk                      (clk_100m),
    .io_asyncReset                     (!rstn_100mhz_int),
    .io_systemReset                    (),
    .system_uart_0_io_txd              (uart_txd),
    .system_uart_0_io_rxd              (uart_rxd),
    .system_spi_0_io_sclk_write        (system_spi_0_io_sclk_write),
    .system_spi_0_io_data_0_writeEnable(system_spi_0_io_data_0_writeEnable),
    .system_spi_0_io_data_0_read       (system_spi_0_io_data_0_read),
    .system_spi_0_io_data_0_write      (system_spi_0_io_data_0_write),
    .system_spi_0_io_data_1_writeEnable(system_spi_0_io_data_1_writeEnable),
    .system_spi_0_io_data_1_read       (system_spi_0_io_data_1_read),
    .system_spi_0_io_data_1_write      (system_spi_0_io_data_1_write),
    .system_spi_0_io_ss                (system_spi_0_io_ss),
    //.io_jtag_tdi                       (riscv_tdi),
    //.io_jtag_tms                       (riscv_tms),
    //.io_jtag_tck                       (riscv_tck),
    //.io_jtag_tdo                       (riscv_tdo),
     .jtagCtrl_tck                      (jtag_inst1_TCK),
     .jtagCtrl_tdi                      (jtag_inst1_TDI),
     .jtagCtrl_tdo                      (jtag_inst1_TDO),
     .jtagCtrl_enable                   (jtag_inst1_SEL),
     .jtagCtrl_capture                  (jtag_inst1_CAPTURE),
     .jtagCtrl_shift                    (jtag_inst1_SHIFT),
     .jtagCtrl_update                   (jtag_inst1_UPDATE),
     .jtagCtrl_reset                    (jtag_inst1_RESET),
    //APB3 Master Interface
    .io_apbSlave_0_PADDR               (p0_apb3_paddr),
    .io_apbSlave_0_PSEL                (p0_apb3_psel),
    .io_apbSlave_0_PENABLE             (p0_apb3_penable),
    .io_apbSlave_0_PREADY              (p0_apb3_pready),
    .io_apbSlave_0_PWRITE              (p0_apb3_pwrite),
    .io_apbSlave_0_PWDATA              (p0_apb3_pwdata),
    .io_apbSlave_0_PRDATA              (p0_apb3_prdata),
    .io_apbSlave_0_PSLVERROR           (p0_apb3_pslverror),

    .io_apbSlave_1_PADDR    (p1_apb3_paddr),
    .io_apbSlave_1_PSEL     (p1_apb3_psel),
    .io_apbSlave_1_PENABLE  (p1_apb3_penable),
    .io_apbSlave_1_PREADY   (p1_apb3_pready),
    .io_apbSlave_1_PWRITE   (p1_apb3_pwrite),
    .io_apbSlave_1_PWDATA   (p1_apb3_pwdata),
    .io_apbSlave_1_PRDATA   (p1_apb3_prdata),
    .io_apbSlave_1_PSLVERROR(p1_apb3_pslverror),

    .io_apbSlave_2_PADDR    (p2_apb3_paddr),
    .io_apbSlave_2_PSEL     (p2_apb3_psel),
    .io_apbSlave_2_PENABLE  (p2_apb3_penable),
    .io_apbSlave_2_PREADY   (p2_apb3_pready),
    .io_apbSlave_2_PWRITE   (p2_apb3_pwrite),
    .io_apbSlave_2_PWDATA   (p2_apb3_pwdata),
    .io_apbSlave_2_PRDATA   (p2_apb3_prdata),
    .io_apbSlave_2_PSLVERROR(p2_apb3_pslverror),

    .io_apbSlave_3_PADDR    (p3_apb3_paddr),
    .io_apbSlave_3_PSEL     (p3_apb3_psel),
    .io_apbSlave_3_PENABLE  (p3_apb3_penable),
    .io_apbSlave_3_PREADY   (p3_apb3_pready),
    .io_apbSlave_3_PWRITE   (p3_apb3_pwrite),
    .io_apbSlave_3_PWDATA   (p3_apb3_pwdata),
    .io_apbSlave_3_PRDATA   (p3_apb3_prdata),
    .io_apbSlave_3_PSLVERROR(p3_apb3_pslverror),

    .system_i2c_0_io_scl_read (cam_scl_IN),
    .system_i2c_0_io_scl_write(cam_scl_write),
    .system_i2c_0_io_sda_read (cam_sda_IN),
    .system_i2c_0_io_sda_write(cam_sda_write)
);

wire w_cfg_done;
wire w_cam_active;
wire w_fb_active;
wire w_eth_tx_active;
wire w_eth_rx_active;
assign led[0] = w_cfg_done;
assign led[1] = w_cam_active;
assign led[2] = w_fb_active;
assign led[3] = w_eth_tx_active;
assign led[4] = w_eth_rx_active;
assign led[5] = '0;
assign cam_scl_OE = !cam_scl_write;
assign cam_sda_OE = !cam_sda_write;
assign cam_scl_OUT = 0;
assign cam_sda_OUT = 0;

udp_video_generator inst_udp_video_generator (
    .clk_100m(clk_100m),
    .clk_156m(clk_156m),
    .clk_100m_rstn(rstn_100mhz_int),
    .clk_156m_rstn(!rst_156mhz_int),
    .mipi_clk(clk_100m),

    .o_cfg_done(w_cfg_done),
    .o_cam_active(w_cam_active),
    .o_fb_active(w_fb_active),
    .o_eth_rx_active(w_eth_rx_active),
    .o_eth_tx_active(w_eth_tx_active),

    .p0_apb3_paddr(p0_apb3_paddr),
    .p0_apb3_psel(p0_apb3_psel),
    .p0_apb3_penable(p0_apb3_penable),
    .p0_apb3_pready(p0_apb3_pready),
    .p0_apb3_pwrite(p0_apb3_pwrite),
    .p0_apb3_pwdata(p0_apb3_pwdata),
    .p0_apb3_prdata(p0_apb3_prdata),
    .p0_apb3_pslverror(p0_apb3_pslverror),

    .p1_apb3_prdata(p3_apb3_prdata),
    .p1_apb3_pready(p3_apb3_pready),
    .p1_apb3_paddr(p3_apb3_paddr),
    .p1_apb3_pwdata(p3_apb3_pwdata),
    .p1_apb3_pwrite(p3_apb3_pwrite),
    .p1_apb3_psel(p3_apb3_psel),
    .p1_apb3_penable(p3_apb3_penable),
    .p1_apb3_pslverror(p3_apb3_pslverror),

    .dphy_rx(dphy_rx1),
    .cam_en (cam_en),

    .ddr_ARSTN_0(ddr_ARSTN_0),
    .ddr_ARQOS_0(ddr_ARQOS_0),
    .ddr_AWQOS_0(ddr_AWQOS_0),
    .ddr_AWID_0(ddr_AWID_0),
    .ddr_AWADDR_0(ddr_AWADDR_0),
    .ddr_AWLEN_0(ddr_AWLEN_0),
    .ddr_AWSIZE_0(ddr_AWSIZE_0),
    .ddr_AWBURST_0(ddr_AWBURST_0),
    .ddr_AWVALID_0(ddr_AWVALID_0),
    .ddr_AWCACHE_0(ddr_AWCACHE_0),
    .ddr_AWCOBUF_0(ddr_AWCOBUF_0),
    .ddr_AWLOCK_0(ddr_AWLOCK_0),
    .ddr_AWAPCMD_0(ddr_AWAPCMD_0),
    .ddr_AWALLSTRB_0(ddr_AWALLSTRB_0),
    .ddr_ARID_0(ddr_ARID_0),
    .ddr_ARADDR_0(ddr_ARADDR_0),
    .ddr_ARLEN_0(ddr_ARLEN_0),
    .ddr_ARSIZE_0(ddr_ARSIZE_0),
    .ddr_ARBURST_0(ddr_ARBURST_0),
    .ddr_ARVALID_0(ddr_ARVALID_0),
    .ddr_ARLOCK_0(ddr_ARLOCK_0),
    .ddr_ARAPCMD_0(ddr_ARAPCMD_0),
    .ddr_WLAST_0(ddr_WLAST_0),
    .ddr_WVALID_0(ddr_WVALID_0),
    .ddr_WDATA_0(ddr_WDATA_0),
    .ddr_WSTRB_0(ddr_WSTRB_0),
    .ddr_BREADY_0(ddr_BREADY_0),
    .ddr_RREADY_0(ddr_RREADY_0),
    .ddr_AWREADY_0(ddr_AWREADY_0),
    .ddr_ARREADY_0(ddr_ARREADY_0),
    .ddr_WREADY_0(ddr_WREADY_0),
    .ddr_BID_0(ddr_BID_0),
    .ddr_BRESP_0(ddr_BRESP_0),
    .ddr_BVALID_0(ddr_BVALID_0),
    .ddr_RID_0(ddr_RID_0),
    .ddr_RLAST_0(ddr_RLAST_0),
    .ddr_RVALID_0(ddr_RVALID_0),
    .ddr_RDATA_0(ddr_RDATA_0),
    .ddr_RRESP_0(ddr_RRESP_0),

    .cfg_start(cfg_start),
    .cfg_reset(cfg_reset),
    .cfg_sel  (cfg_sel),
    .cfg_done (cfg_done),

    .init_rst_n(apb_done_o),
    .PMA_CMN_READY(cmn_inst1_PMA_CMN_READY),
    .PMA_XCVR_PLLCLK_EN_ACK(sfp0_PMA_XCVR_PLLCLK_EN_ACK),
    .PMA_XCVR_POWER_STATE_ACK(sfp0_PMA_XCVR_POWER_STATE_ACK),
    .PMA_RX_SIGNAL_DETECT(sfp0_PMA_RX_SIGNAL_DETECT),
    .PMA_XCVR_PLLCLK_EN(sfp0_PMA_XCVR_PLLCLK_EN),
    .PMA_XCVR_POWER_STATE_REQ(sfp0_PMA_XCVR_POWER_STATE_REQ),

    .sfp0_txd(sfp0_TXD),
    .sfp0_txc(sfp0_TXC),
    .sfp0_rxd(sfp0_RXD),
    .sfp0_rxc(sfp0_RXC)
);

endmodule
