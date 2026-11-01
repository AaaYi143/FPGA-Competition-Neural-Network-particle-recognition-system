`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/19 23:39:08
// Design Name: 
// Module Name: norm_inv
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
`timescale 1ns / 1ps
module norm_inv #(
    parameter WIDTH = 24,
    parameter ROM_INDEX_BIT = 8
)(
    input  wire         clk,
    input  wire         rst_n,
    input  wire [WIDTH-1:0] B,
    input  wire [WIDTH-1:0] x_minus,
    output reg  [7:0]   y_out
);

//==================== 流水线第1级寄存器 ====================
reg [WIDTH-1:0] B_r;
reg [WIDTH-1:0] x_minus_r;
reg [$clog2(WIDTH)-1:0] k_r;
reg [15:0] rom_q_r;

wire [$clog2(WIDTH)-1:0] k;
wire [WIDTH-1:0] M;
wire [ROM_INDEX_BIT-1:0] rom_addr;
wire [15:0] rom_q;

lzc #(.WIDTH(WIDTH)) u_lzc(.din(B_r), .cnt(k));
barrel_shifter_left #(.WIDTH(WIDTH)) u_bs(
    .din(B_r), .shift(k), .dout(M)
);
assign rom_addr = M[WIDTH-2 : WIDTH-1 - ROM_INDEX_BIT];
rom_255_over_s u_rom(.addr(rom_addr), .q(rom_q));

// stage1 寄存
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        B_r <= 0;
        x_minus_r <= 0;
        k_r <= 0;
        rom_q_r <= 0;
    end else begin
        B_r <= B;
        x_minus_r <= x_minus;
        k_r <= k;
        rom_q_r <= rom_q;
    end
end

//==================== 流水线第2级：乘法 + 动态右移 ====================
wire [WIDTH + 16 - 1 :0] mul_result;
assign mul_result = x_minus_r * rom_q_r;
wire [$clog2(WIDTH)-1:0] exp;
assign exp = (WIDTH - 1) - k_r;
wire [7:0] y_calc;
assign y_calc = mul_result >> (exp + 8);

// B=0保护逻辑：B=0直接输出0
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        y_out <= 8'd0;
    end else begin
        if(B_r == 0) begin
            y_out <= 8'd0;
        end else begin
            y_out <= y_calc;
        end
    end
end

endmodule

