`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/21 20:41:39
// Design Name: 
// Module Name: UartDataReady
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



module UartDataReady(
    input                       i_clk,
    input                       i_rst_,
    input                       i_trig_uart,
    input                       i_tx_done,
    input         [15:0]        i_data,
    input         [ 7:0]        i_rx_data,
    input                       i_uart_en,
    output                      o_tx_trig,
    output reg    [ 7:0]        o_tx_data,
    output                      o_end_of_tx_block_character
); 
  
reg     [15:0]      input_data_reg;
reg     [15:0]      input_data_reg_n; 
reg     [ 3:0]      step;
reg     [ 3:0]      step_n;
reg     [ 7:0]      o_tx_data_n;

assign o_tx_trig = ((i_trig_uart == 1'b1 || i_tx_done == 1'b1) && i_uart_en == 1'b1);

always @ (posedge i_clk or negedge i_rst_)
begin
    if (i_rst_ == 1'b0) begin
        input_data_reg <= 64'd0;
        step <= 4'd0;
        o_tx_data <= 8'h00;
    end else begin
        input_data_reg <=  input_data_reg_n;
        step <= step_n;
        o_tx_data <= o_tx_data_n;
    end
end

always @ (*)
begin
    if (o_tx_trig == 1'b1)
        input_data_reg_n = i_data;
    else
        input_data_reg_n = input_data_reg;
end

   
always @ (*)
begin
    if (i_trig_uart == 1'b1 || (i_tx_done == 1'b1 && step == 4'd1))
        step_n = 4'd0;
    else if (i_tx_done == 1'b1 && step != 4'd1)
        step_n = step + 4'd1;
    else
        step_n = step;
end

always @ (*)
begin
    case (step)					
        4'd0: o_tx_data_n = input_data_reg[7:0];                 // 低12位是采集到的数据
        4'd1: o_tx_data_n = input_data_reg[15:8];                // 低12位是采集到的数据
        default: o_tx_data_n = 8'h00;
    endcase
end

assign o_end_of_tx_block_character = (i_tx_done == 1'b1 && step == 4'd1);
   
endmodule
