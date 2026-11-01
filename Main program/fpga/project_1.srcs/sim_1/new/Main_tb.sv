`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/10 09:55:55
// Design Name: 
// Module Name: Main_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Main_tsb;
reg     [3:0]   ipVauxP, ipVauxN;
reg             ipRst_;
reg             ipClk;
reg             ipUartRx;
wire            opUartTx;
reg             ipUartRx_Wireless;
wire            opUartTx_Wireless;
wire    [6:0]   opChooseChannel;
reg     [7:0]   op_seg_data;
reg     [1:0]   op_seg_en;
reg     [7:0]   ipKey = 8'b1111_1110;

initial
begin
    # 0 ipClk = 0; ipRst_ = 1;
    #15 ipRst_ = 0;
    #15 ipRst_ = 1;
end
always #(5) ipClk = ~ipClk;
// Instantiate the Unit Under Test (UUT)
Main Main_inst (
.ipClk (ipClk),
.ipRst_ (ipRst_),
.ipKey  (ipKey),
.ipVauxP (ipVauxP),
.ipVauxN (ipVauxN),
.ipUartRx (ipUartRx),
.opUartTx (opUartTx),
.ipUartRx_Wireless (ipUartRx_Wireless), 
.opUartTx_Wireless (opUartTx_Wireless), 
.opChooseChannel (opChooseChannel),
.op_seg_en  (op_seg_en),
.op_seg_data    (op_seg_data)
);

endmodule
