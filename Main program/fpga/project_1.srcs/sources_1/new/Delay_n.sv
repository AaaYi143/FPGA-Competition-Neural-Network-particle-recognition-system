`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/13 20:15:33
// Design Name: 
// Module Name: Delay_n
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


// 通用 N 级寄存器打拍延迟模块
// 参数：DELAY_CNT = 打拍级数（默认1拍，可修改为任意正整数 1/2/3...）
module Delay_n #(
    parameter DELAY_CNT = 1  // 配置打拍数量，修改这里即可
)(
    input  wire clk,        // 时钟
    input  wire rst_n,      // 低电平复位
    input  wire din,        // 输入信号
    output  wire dout       // 延迟 N 拍后的输出信号
);

// 定义移位寄存器数组，长度 = 打拍级数
reg [DELAY_CNT-1 : 0] delay_reg;

// 核心：N 级移位打拍逻辑
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        delay_reg <= {DELAY_CNT{1'b0}};  // 复位：所有寄存器清零
    end
    else begin
        // 左移打拍：新数据进最低位，旧数据依次左移
        delay_reg <= {delay_reg[DELAY_CNT-2 : 0], din};
    end
end

// 输出：最高位 = 延迟 N 拍后的信号
assign dout = delay_reg[DELAY_CNT-1];

endmodule
