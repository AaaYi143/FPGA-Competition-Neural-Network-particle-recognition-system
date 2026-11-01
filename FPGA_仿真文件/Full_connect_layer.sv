`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/04 09:50:01
// Design Name: 
// Module Name: Full_connect_layer
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

module Full_connect_layer #(
    parameter LAYER_INDEX = 1,
    parameter BIT_WIDTH    = 8,
    parameter IN_FEATURES  = 784,
    parameter OUT_FEATURES = 64
)(
    input  wire clk,
    input  wire rst_n,
    input  wire i_valid,

    input  wire signed [BIT_WIDTH-1:0] din,

    output reg signed [2*BIT_WIDTH + $clog2(IN_FEATURES) + 1 - 1 : 0]  dout [0:OUT_FEATURES-1],
    output reg  done
);

localparam PROD_WIDTH = 2 * BIT_WIDTH;
localparam SUM_EXTRA1 = $clog2(IN_FEATURES) + 1;
localparam SUM_WIDTH  = PROD_WIDTH + SUM_EXTRA1;
reg         valid_delay;
reg signed [BIT_WIDTH-1:0] din_delay;

`include "weights.vh"

wire signed [BIT_WIDTH-1:0] weight [0:OUT_FEATURES-1][0:IN_FEATURES-1];
wire signed [PROD_WIDTH-1:0] bias   [0:OUT_FEATURES-1];

generate
    if (LAYER_INDEX == 1) begin
        assign weight = weight_1;
        assign bias   = bias_1;
    end else if (LAYER_INDEX == 2) begin
        assign weight = weight_2;
        assign bias   = bias_2;
    end else if (LAYER_INDEX == 3) begin
        assign weight = weight_3;
        assign bias   = bias_3;
    end
endgenerate

// ======================
// 当前态寄存器
// ======================
reg [$clog2(IN_FEATURES)-1:0] cnt;
reg                           sum_en;
wire                          sum_en_n; 

(* use_dsp48="yes" *) reg signed [PROD_WIDTH-1:0]   prod [0:OUT_FEATURES-1];
reg signed [SUM_WIDTH-1:0]    sum  [0:OUT_FEATURES-1];
// ======================
// 下一状态 _n
// ======================
reg [$clog2(IN_FEATURES)-1:0] cnt_n;

(* use_dsp48="yes" *) reg signed [PROD_WIDTH-1:0]   prod_n [0:OUT_FEATURES-1];
reg signed [SUM_WIDTH-1:0]    sum_n  [0:OUT_FEATURES-1];
reg                           done_n;





// ======================
// 组合：cnt / run_en 逻辑
// ======================
always @(*) begin
    if(valid_delay == 1'b1 && cnt == IN_FEATURES - 1) begin
        cnt_n = '0;
    end else if(valid_delay) begin
        cnt_n = cnt + 1'b1;
    end else begin
        cnt_n = cnt;
    end
end

//求和使能比求积使能晚一拍
assign  sum_en_n = valid_delay;

genvar n;
generate
for (n = 0; n < OUT_FEATURES; n = n + 1) begin : neuron_loop_comb
    always @(*) begin
        if (valid_delay) begin
            prod_n[n] = din_delay * weight[n][cnt];           
        end else begin
            prod_n[n] = '0;
        end
    end

    always @(*) begin
        if(valid_delay == 1'b1 && cnt == '0) begin
            sum_n[n]  = bias[n];
        end else if(sum_en) begin
            sum_n[n]  = sum[n] + prod[n];
        end else begin
            sum_n[n]  = sum[n];
        end
    end
end

endgenerate

// ======================
// 组合：done 生成
// ======================
always @(*) begin
    // 也要顺延一拍对齐累加结束
    done_n = (sum_en == 1'b1 && cnt == '0);
end

// ======================
// 时序：只打拍，不运算
// ======================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        valid_delay <= '0;
        din_delay <= '0;
        cnt      <= '0;
        sum_en   <= '0;
        done     <= '0;
    end else begin
        valid_delay <= i_valid;
        din_delay <= din;
        cnt      <= cnt_n;
        sum_en   <= sum_en_n;
        done     <= done_n;
    end
end

genvar j;
generate
for (j = 0; j < OUT_FEATURES; j = j + 1) begin : neuron_loop_seq
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            prod[j] <= '0;
            sum[j]  <= '0;
            dout[j] <= '0;
        end else begin
            prod[j] <= prod_n[j];
            sum[j]  <= sum_n[j];
            dout[j] <= sum_n[j];
        end
    end
end
endgenerate

endmodule
