`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/20 06:33:49
// Design Name: 
// Module Name: lzc
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
module lzc #(
    parameter WIDTH = 24
)(
    input  wire [WIDTH-1:0] din,
    output reg  [$clog2(WIDTH)-1:0] cnt
);

integer i;
always @(*) begin
    cnt = $clog2(WIDTH)'(WIDTH); // 默认全0，输出WIDTH
    for(i = WIDTH-1; i >= 0; i = i - 1) begin
        if(din[i]) begin
            cnt = $clog2(WIDTH)'( (WIDTH - 1) - i );
            break;
        end
    end
end

endmodule

