`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/21 20:32:11
// Design Name: 
// Module Name: Neural_network
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

module Neural_network #(
    parameter IN_FEATURES  = 89,
    parameter OUT_FEATURES = 2,
    parameter BIT_WIDTH    = 8,
    parameter PARREL       = 2,
    //=====新增预处理参数，可切换12/24bit原始采样位宽=====
    parameter RAW_DATA_W   = 24    //原始ADC/自相关输出位宽，改成12就是12bit
)(
    input   wire             i_clk,
    input   wire             i_rst_n,
    output  wire    [3:0]    op_seg_en,
    output  wire    [7:0]    op_seg_data,
    //====新增：外部原始光电采样信号（自相关/粒度/光谱）====
    input  wire signed [RAW_DATA_W-1:0] raw_sig,
    input  wire                         raw_valid
);
wire                                overflow;
wire                                nn_done;
wire [$clog2(OUT_FEATURES)-1:0]     output_y;



//====================================================================
// 【新增模块：帧级预处理链路：raw_sig -> minmax归一化输出0~255】
//====================================================================
wire [7:0] preproc_out_0_255;  //预处理输出：0~255 无符号8bit
wire       preproc_valid;

nn_preprocess #(
    .WIDTH          (RAW_DATA_W),
    .FEATURE_CNT    (IN_FEATURES),
    .ROM_ADDR_W     (8)
)
u_nn_preprocess(
    .clk        (i_clk),
    .rst_n      (i_rst_n),
    .x_raw      (raw_sig),
    .data_valid (raw_valid),
    .norm_8bit  (preproc_out_0_255),
    .valid_out  (preproc_valid)
);

reg [7:0] data_0_255;
reg       data_valid_8b;
always @(*) begin
    data_0_255  = preproc_out_0_255;
    data_valid_8b = preproc_valid;
end

//====和原代码保持一致：0~255 → [-128,127] 有符号8bit，送入NN====
reg signed [BIT_WIDTH-1:0] img_norm;
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        img_norm <= 8'd0;
    end else if (data_valid_8b) begin
        // 0~255 减去128，映射到 -128 ~ +127，和你原有NN输入完全匹配
        img_norm <= $signed({1'b0, data_0_255}) - 8'sd128;
    end
end

reg         valid_img;
always @ (posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n)
        valid_img <= 1'b0;
    else
        valid_img <= data_valid_8b;
end

NN_module #(
    .BIT_WIDTH(BIT_WIDTH),
    .PARALL(PARREL),
    .IN_FEATURES(IN_FEATURES),
    .OUT_FEATURES(OUT_FEATURES)
) nn_module_inst (
    .clk                (i_clk),
    .rst_n              (i_rst_n),
    .rx_done_pos        (valid_img),
    .img_din            (img_norm),
    .output_scaled      (output_y),
    .done               (nn_done),
    .overflow           (overflow)
);


SegLed SegLed_inst(
    .clk        (i_clk),
    .rst_n      (i_rst_n),
    .din        ({3'b000,output_y}),
    .start      (nn_done),
    .op_seg_data(op_seg_data),
    .op_seg_en  (op_seg_en)
);


endmodule

