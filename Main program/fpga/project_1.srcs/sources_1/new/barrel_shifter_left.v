`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/20 06:34:37
// Design Name: 
// Module Name: barrel_shifter_left
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
module barrel_shifter_left #(
    parameter WIDTH = 24
)(
    input  wire [WIDTH-1:0] din,
    input  wire [$clog2(WIDTH)-1:0] shift,
    output reg  [WIDTH-1:0] dout
);

always @(*) begin
    dout = din << shift;
end

endmodule

