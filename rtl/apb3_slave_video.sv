/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// Description:
// A simple apb3 slave wrapper example design to interface with soc apb3
// signals
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
// 1.1 Fix APB3 PREADY assignment
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module apb3_slave_video #(
    // user parameter starts here
    //
    parameter  ADDR_WIDTH = 10,
    parameter  DATA_WIDTH = 32,
    localparam NUM_REG    = 32
) (
    // user logic starts here
    input  [31:0] pixel_avg,
    input  [31:0] pixel_cnt,
    input  [31:0] override_exposure,
    input  [31:0] override_gain_r,
    input  [31:0] override_gain_g,
    input  [31:0] override_gain_b,
    output [31:0] gain_r,
    output [31:0] gain_g,
    output [31:0] gain_b,
    output [31:0] offset_r,
    output [31:0] offset_g,
    output [31:0] offset_b,
    input  [31:0] frame_interval,
    // user logic starts here
    output        video_rstn,
    output [15:0] dyn_hres,
    output [15:0] dyn_H_SyncPulse,
    output [15:0] dyn_H_BackPorch,
    output [15:0] dyn_H_ActivePix,
    output [15:0] dyn_H_FrontPorch,
    output [15:0] dyn_V_SyncPulse,
    output [15:0] dyn_V_BackPorch,
    output [15:0] dyn_V_ActivePix,
    output [15:0] dyn_V_FrontPorch,
    output [15:0] dyn_P_Cnt,
    output        hdmi_reset,
    output [31:0] local_ip,
    output [31:0] gateway_ip,
    output [31:0] dest_ip,
    output [15:0] source_port,
    output [15:0] dest_port,
    output [15:0] mss,
    output [ 7:0] pixel_mode,


    input                   clk,
    input                   resetn,
    input  [ADDR_WIDTH-1:0] PADDR,
    input                   PSEL,
    input                   PENABLE,
    output                  PREADY,
    input                   PWRITE,
    input  [DATA_WIDTH-1:0] PWDATA,
    output [DATA_WIDTH-1:0] PRDATA,
    output                  PSLVERROR

);


    ///////////////////////////////////////////////////////////////////////////////

    localparam [1:0] IDLE = 2'b00, 
                     SETUP = 2'b01, 
                     ACCESS = 2'b10;

    reg [1:0] busState, busNext;
    reg     [DATA_WIDTH-1:0] slaveReg    [0:NUM_REG-1];
    reg     [DATA_WIDTH-1:0] slaveRegOut;
    reg                      slaveReady;
    wire                     actWrite;
    wire                     actRead;
    integer                  byteIndex;
    // reg [DATA_WIDTH-1:0]    saveDbgReg;


    ///////////////////////////////////////////////////////////////////////////////

    always @(posedge clk or negedge resetn) begin
        if (!resetn) busState <= IDLE;
        else busState <= busNext;
    end

    always @(*) begin
        busNext = busState;

        case (busState)
            IDLE: begin
                if (PSEL && !PENABLE)
                    busNext = SETUP;
                else
                    busNext = IDLE;
            end
            SETUP: begin
                if (PSEL && PENABLE)
                    busNext = ACCESS;
                else
                    busNext = IDLE;
            end
            ACCESS: begin
                if (PREADY)
                    busNext = IDLE;
                else
                    busNext = ACCESS;
            end
            default: begin
                busNext = IDLE;
            end
        endcase
    end


    assign actWrite = PWRITE & (busState == ACCESS);
    assign actRead = !PWRITE & (busState == ACCESS);
    assign PSLVERROR = 1'b0;  //FIXME
    assign PRDATA = slaveRegOut;
    assign PREADY = slaveReady & &(busState !== IDLE);

    always @(posedge clk) begin
        slaveReady <= actWrite | actRead;
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            for (byteIndex = 0; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
            slaveReg[byteIndex] <= '0;
        else begin
            if (actWrite) begin
                case (PADDR[2+$clog2(NUM_REG)-1 : 2])
                    default: slaveReg[PADDR[2+$clog2(NUM_REG)-1 : 2]] <= PWDATA;
                    endcase
            end

            // below are read only registers
            slaveReg[0]  <= pixel_avg;
            slaveReg[1]  <= pixel_cnt;
            slaveReg[25] <= override_exposure;
            slaveReg[26] <= override_gain_r;
            slaveReg[27] <= override_gain_g;
            slaveReg[28] <= override_gain_b;
            slaveReg[30] <= frame_interval;
        end

    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            slaveRegOut <= '0;
        else begin
            if (actRead)
                slaveRegOut <= slaveReg[PADDR[2+:$clog2(NUM_REG)]];
            else
                slaveRegOut <= slaveRegOut;
        end
    end

    //custom logic starts here
    assign gain_r = slaveReg[2];
    assign gain_g = slaveReg[3];
    assign gain_b = slaveReg[4];
    assign offset_r = slaveReg[5];
    assign offset_g = slaveReg[6];
    assign offset_b = slaveReg[7];
    assign video_rstn = slaveReg[8][0];
    assign dyn_hres = slaveReg[9];
    assign dyn_H_SyncPulse = slaveReg[10];
    assign dyn_H_BackPorch = slaveReg[11];
    assign dyn_H_ActivePix = slaveReg[12];
    assign dyn_H_FrontPorch = slaveReg[13];
    assign dyn_V_SyncPulse = slaveReg[14];
    assign dyn_V_BackPorch = slaveReg[15];
    assign dyn_V_ActivePix = slaveReg[16];
    assign dyn_V_FrontPorch = slaveReg[17];
    assign dyn_P_Cnt = slaveReg[18];
    assign hdmi_reset = slaveReg[19][0];
    assign local_ip = slaveReg[20];
    assign gateway_ip = slaveReg[21];
    assign dest_ip = slaveReg[22];
    assign source_port = slaveReg[23];
    assign dest_port = slaveReg[24];
    assign mss = slaveReg[29];
    assign pixel_mode = slaveReg[31];

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////
