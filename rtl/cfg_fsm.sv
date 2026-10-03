
module cfg_fsm (
    input        clk,
    input        rstn,
    
    input        cfg_sel_override,
    input        cfg_reset_override,

    output logic cfg_start,
    output logic cfg_reset,
    output logic cfg_sel,
    input        cfg_done,
    output       cfg_ok,
    output logic ddr_ctrl_rstn,
    output logic ddr_phy_rstn,

    output logic [31:0] training_duration = 0,
    output logic [2:0] dbg_cfg_st
);

/////////////////////////////////////////////////////////////////////////////
//////  ddr4 config
/////////////////////////////////////////////////////////////////////////////
typedef enum logic [2:0] {
    IDLE,
    CTRL_RELEASE,
    PHY_RELEASE,
    CFG_RELEASE,
    CFG_START,
    CFG_DONE
} ddr_cfg_state_t;


ddr_cfg_state_t cfg_st = IDLE;
reg [15:0]      cfg_count = 0;
reg             cfg_rstp_r = 1;
reg             phy_rstn_r = 0;
reg             ctrl_rstn_r = 0;
reg             axi_rstn_r = 0;
// assign ddr_phy_rstn = phy_rstn_r && w_phy_rstn;
// assign ddr_ctrl_rstn = ctrl_rstn_r && w_ctrl_rstn;
// assign regARESETn = reg_rstn_r && w_regARESETn;

assign cfg_start    = (cfg_st != IDLE);
assign cfg_ok       = (cfg_st == CFG_DONE);
assign cfg_sel      = cfg_sel_override;
assign cfg_reset    = cfg_rstp_r || cfg_reset_override;
assign dbg_cfg_st = cfg_st;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        training_duration <= '0;
    end else begin
        if (cfg_reset)
            training_duration <= '0;
        else if (cfg_start && !cfg_ok)
            training_duration <= training_duration + 1;
    end
end


always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        cfg_st <= IDLE;
        cfg_count <= 0;
        cfg_rstp_r <= 1;
        axi_rstn_r <= 0;
        ctrl_rstn_r <= 0;
        phy_rstn_r <= 0;
    end else begin
        case(cfg_st)
        IDLE: begin
            if(cfg_count >= 'hff) begin
                cfg_st <= CTRL_RELEASE;
                cfg_count <= 0;
            end else begin
                cfg_count <= cfg_count + 1'b1;
                cfg_rstp_r <= 1;
                axi_rstn_r <= 0;
                ctrl_rstn_r <= 0;
                phy_rstn_r <= 0;
            end
        end

        CTRL_RELEASE: begin
            if(cfg_count >= 'hff) begin
                cfg_st <= PHY_RELEASE;
                cfg_count <= 0;
            end else begin
                cfg_count <= cfg_count + 1'b1;
                ctrl_rstn_r <= 1;
            end
        end
        PHY_RELEASE: begin
            if(cfg_count >= 'hff) begin
                cfg_st <= CFG_RELEASE;
                cfg_count <= 0;
            end else begin
                cfg_count <= cfg_count + 1'b1;
                phy_rstn_r <= 1;
            end
        end

        CFG_RELEASE: begin
            if(cfg_count >= 'hff) begin
                cfg_st <= CFG_START;
                cfg_count <= 0;
            end else begin
                cfg_count <= cfg_count + 1'b1;
                cfg_rstp_r <= 0;
            end
        end

        CFG_START: begin
            if(cfg_done)
                cfg_st <= CFG_DONE;
            else
                cfg_st <= CFG_START;
        end

        CFG_DONE: begin
            axi_rstn_r <= 1;
            cfg_st <= CFG_DONE;
        end

        default: begin
            cfg_count <= 0;
            cfg_st <= IDLE;
        end
        endcase
    end
end


endmodule
