`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/04 21:33:27
// Design Name: 
// Module Name: Bram_Serial2Serial
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


module Bram_Serial2Serial #(
    parameter DATA_W = 8,
    parameter DEPTH  = 32  // 输出特征数 OUT2
)(
    input  wire                     clk,
    input  wire                     rst_n,
    
    // 输入标准：start 与 并行数据 同步
    input  wire                     i_valid,
    input  wire signed [DATA_W-1:0] din_serial,
    
    // 输出标准：done 与 串行数据 同步
    output reg                      o_valid,
    output reg signed [DATA_W-1:0]  dout_serial
);

localparam ADDR_W = $clog2(DEPTH);

// ============================
// 控制信号 当前状态
// ============================
reg [ADDR_W-1:0] waddr;
reg [ADDR_W-1:0] raddr;
reg              rd_en;

// ============================
// 控制信号 下一状态 _n
// ============================
reg [ADDR_W-1:0] waddr_n;
reg [ADDR_W-1:0] raddr_n;
reg              rd_en_n;
reg              o_valid_n;

// ============================
// 组合逻辑：控制信号
// ============================
always @(*) begin
    // 写地址
    if (i_valid == 1'b1 && waddr == DEPTH-1)
        waddr_n = '0;
    else if (i_valid)
        waddr_n = waddr + 1'b1;
    else
        waddr_n = waddr;


    // 读使能：写完立即读
    if (i_valid == 1'b1 && waddr == DEPTH-1)
        rd_en_n = 1'b1;   
    else if (raddr == DEPTH-1)
        rd_en_n = 1'b0;
    else
        rd_en_n = rd_en;

    // 读地址
    if (raddr == DEPTH-1)
        raddr_n = '0;
    else if (rd_en)
        raddr_n = raddr + 1'b1; 
    else
        raddr_n = raddr;

    // done：读完最后一个
    o_valid_n = rd_en;
end

// ============================
// 时序逻辑：只打拍，不运算
// ============================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        waddr <= '0;
        raddr <= '0;
        rd_en <= '0;
        o_valid  <= 1'b0;
    end else begin
        waddr <= waddr_n;
        raddr <= raddr_n;
        rd_en <= rd_en_n;
        o_valid  <= o_valid_n;
    end
end

// ============================
// BRAM 存储
// ============================
(* ram_style = "block" *)
reg [DATA_W-1:0] ram [0:DEPTH-1];

// 写端口
always @(posedge clk) begin
    if (i_valid)
        ram[waddr] <= din_serial;
end

// 读端口（自带1拍延迟）
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout_serial <= '0;
    end else if (rd_en) begin
        dout_serial <= ram[raddr];
    end
end


endmodule