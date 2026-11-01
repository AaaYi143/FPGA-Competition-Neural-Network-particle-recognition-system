`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/23 14:50:14
// Design Name: 
// Module Name: Hard_modified_sigmoid
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
module Hard_modified_sigmoid #(
    parameter W_IN        = 16,
    parameter W_OUT        = 8,
    parameter N            = 32,
    parameter int THRESH  = 4,
    parameter SHIFT_W     = 1,
    parameter real SCALE  = 127
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    input  wire signed [W_IN-1:0] din [0:N-1],
    output reg done,
    output reg signed [W_OUT-1:0] dout [0:N-1]
);

localparam SHIFT_BITS    = $clog2(THRESH) + SHIFT_W;
localparam THRESH_SCALED = int'(THRESH * SCALE);
localparam MAX_OUT       = (2**(W_OUT-1)) - 1;
localparam MIN_OUT       = -(2**(W_OUT-1)) + 1;


// ======================================================
// 组合逻辑：计算下一状态的值
// ======================================================
reg signed [W_OUT-1:0] dout_n [0:N-1];
reg                     done_n;

// ======================================================
// 时序逻辑：状态更新
// ======================================================
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (int j = 0; j < N; j++) begin
            dout[j] <= '0;
        end
        done <= 1'b0;
    end else begin
        for (int j = 0; j < N; j++) begin
            dout[j] <= dout_n[j];
        end
        done <= done_n;
    end
end


genvar i;
generate
    for (i = 0; i < N; i++) begin : sig_comb
        always_comb begin
            if (din[i] >= THRESH_SCALED)
                dout_n[i] = MAX_OUT;
            else if (din[i] <= -THRESH_SCALED)
                dout_n[i] = MIN_OUT;
            else
                dout_n[i] = din[i] >>> SHIFT_BITS;
        end
    end
endgenerate

always_comb begin
    done_n = start;
end


endmodule