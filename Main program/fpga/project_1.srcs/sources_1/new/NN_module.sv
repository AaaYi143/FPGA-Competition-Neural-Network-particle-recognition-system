`timescale 1ns / 1ps

module NN_module #(
    parameter BIT_WIDTH       = 8,         
    parameter PARALL          = 8,      
    parameter IN_FEATURES     = 784, 
    parameter OUT_FEATURES    = 1          
)(
    input  wire clk,
    input  wire rst_n,
    input  wire rx_done_pos,

    // 鍥惧儚 BRAM 鎺ュ彛锛堜覆琛岃緭鍏ワ級
    input  wire signed [BIT_WIDTH-1:0]  img_din,            
  //  output reg [$clog2(IN_FEATURES)-1:0] img_addr,    

    output wire [$clog2(OUT_FEATURES)-1:0] output_scaled,
 
    output wire done,                                   
    output wire overflow                               
);

`include "scales.vh"


wire done_fc1, done_fc2, done_fc3;
wire done_act1, done_act2;
wire overflow1, overflow2, overflow3;


wire valid_rd1;
wire signed [BIT_WIDTH-1:0] output_bram1;
Bram_Serial2Serial #(.DATA_W(BIT_WIDTH), .DEPTH(IN_FEATURES))
bram1 (.clk(clk), .rst_n(rst_n), .i_valid(rx_done_pos), .din_serial(img_din), .o_valid(valid_rd1), .dout_serial(output_bram1));

localparam OUT1 = 20;
localparam PROD_WIDTH1  = 2 * BIT_WIDTH;
localparam SUM_EXTRA1   = $clog2(IN_FEATURES) + 1;
localparam SUM_WIDTH1   = PROD_WIDTH1 + SUM_EXTRA1;
wire signed  [SUM_WIDTH1-1:0]  output_fc1 [0:OUT1-1];
Full_connect_layer #(.LAYER_INDEX(1), .BIT_WIDTH(BIT_WIDTH), .IN_FEATURES(IN_FEATURES), .OUT_FEATURES(OUT1)) 
fc1 (.clk(clk), .rst_n(rst_n), .i_valid(valid_rd1), .din(output_bram1), .dout(output_fc1), .done(done_fc1));

wire signed  [BIT_WIDTH-1:0]   output_act1 [0:OUT1-1];
Hard_modified_sigmoid #(.W_IN(SUM_WIDTH1), .W_OUT(BIT_WIDTH), .N(OUT1), .THRESH(4), .SHIFT_W(`SHIFT_W1), .SCALE(`SCALE_JOINT1))
act1 (.clk(clk), .rst_n(rst_n), .start(done_fc1), .din(output_fc1), .done(done_act1), .dout(output_act1));

wire valid_rd2;
wire signed [BIT_WIDTH-1:0] output_bram2;
Bram_Parallel2Serial #(.DATA_W(BIT_WIDTH), .DEPTH(OUT1))
bram2 (.clk(clk), .rst_n(rst_n), .wr_start(done_act1), .din_parallel(output_act1), .o_valid(valid_rd2), .dout_serial(output_bram2));

localparam OUT2 = 31;
localparam PROD_WIDTH2  = 2 * BIT_WIDTH;
localparam SUM_EXTRA2   = $clog2(OUT1) + 1;
localparam SUM_WIDTH2   = PROD_WIDTH2 + SUM_EXTRA2;
wire signed  [SUM_WIDTH2-1:0]  output_fc2  [0:OUT2-1];
Full_connect_layer #(.LAYER_INDEX(2), .BIT_WIDTH(BIT_WIDTH), .IN_FEATURES(OUT1), .OUT_FEATURES(OUT2)) 
fc2 (.clk(clk), .rst_n(rst_n), .i_valid(valid_rd2), .din(output_bram2), .dout(output_fc2), .done(done_fc2));

wire signed  [BIT_WIDTH-1:0]   output_act2 [0:OUT2-1];
Hard_modified_sigmoid #(.W_IN(SUM_WIDTH2), .W_OUT(BIT_WIDTH), .N(OUT2), .THRESH(4), .SHIFT_W(`SHIFT_W2), .SCALE(`SCALE_JOINT2)) 
act2 (.clk(clk), .rst_n (rst_n), .start(done_fc2),  .din(output_fc2), .done(done_act2),.dout(output_act2));

wire valid_rd3;
wire signed [BIT_WIDTH-1:0] output_bram3;
Bram_Parallel2Serial #(.DATA_W(BIT_WIDTH), .DEPTH(OUT2))
bram3 (.clk(clk), .rst_n(rst_n), .wr_start(done_act2), .din_parallel(output_act2), .o_valid(valid_rd3), .dout_serial(output_bram3));

localparam OUT3 = OUT_FEATURES;
localparam PROD_WIDTH3  = 2 * BIT_WIDTH;
localparam SUM_EXTRA3   = $clog2(OUT2) + 1;
localparam SUM_WIDTH3   = PROD_WIDTH3 + SUM_EXTRA3;
wire signed   [SUM_WIDTH3-1:0] output_fc3 [0:OUT3-1] ;
Full_connect_layer #(.LAYER_INDEX(3), .BIT_WIDTH(BIT_WIDTH), .IN_FEATURES(OUT2), .OUT_FEATURES(OUT3)) 
fc3 (.clk(clk), .rst_n(rst_n), .i_valid(valid_rd3), .din(output_bram3), .dout(output_fc3), .done(done_fc3));

//================================================================================
// Argmax
//================================================================================
wire [$clog2(OUT3)-1:0] class_idx;
wire done_argm1;
Argmax #(.N(OUT3), .WIDTH(SUM_WIDTH3)) 
argm1 (.clk(clk), .rst_n(rst_n), .start(done_fc3), .in(output_fc3), .done(done_argm1), .index(class_idx));

//================================================================================
// 杈撳嚭
//================================================================================
assign done         = done_argm1;
assign overflow     = overflow1 | overflow2;
assign output_scaled= class_idx;

endmodule