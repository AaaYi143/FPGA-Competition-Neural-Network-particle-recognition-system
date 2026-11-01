
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/10 10:03:08
// Design Name: 
// Module Name: Bram
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



module Bram #(
    parameter WIDTH = 8,
    parameter DEPTH = 64
)(
    input clk,
    input we,
    input [$clog2(DEPTH)-1:0] addr,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout
);
(* ram_style = "block" *) reg [WIDTH-1:0] mem [0:DEPTH-1];

always @(posedge clk) begin
    if (we) mem[addr] <= din;
    dout <= mem[addr];
end

endmodule
