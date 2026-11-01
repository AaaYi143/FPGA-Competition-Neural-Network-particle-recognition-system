`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/21 20:40:20
// Design Name: 
// Module Name: ProgrammableGainAmplifiers
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



module ProgrammableGainAmplifiers
(
    input           [ 7:0]          ipKey,
    input           [ 7:0]          iDataFromUart,
    output          [ 7:0]          opEnResistor,
    output          [ 7:0]          opLed  
);

//assign  opEnResistor = ipKey;
//assign  opLed = ipKey;

reg          [ 7:0]          opEnResistor = 8'b0001_1000;
reg          [ 7:0]          opLed;         
always @ (*)
begin
    case(iDataFromUart)
        8'h30: begin opEnResistor = 8'b1000_0001; opLed = ~ 8'b1000_0001; end  // iDataFromUart Ascii码对应的十六进制为 0 
        8'h31: begin opEnResistor = 8'b1000_0010; opLed = ~ 8'b1000_0010; end  // iDataFromUart Ascii码对应的十六进制为 1 
        8'h32: begin opEnResistor = 8'b1000_0100; opLed = ~ 8'b1000_0100; end  // iDataFromUart Ascii码对应的十六进制为 2 
        8'h33: begin opEnResistor = 8'b1000_1000; opLed = ~ 8'b1000_1000; end  // iDataFromUart Ascii码对应的十六进制为 3 
        8'h34: begin opEnResistor = 8'b0100_0001; opLed = ~ 8'b0100_0001; end  // iDataFromUart Ascii码对应的十六进制为 4 
        8'h35: begin opEnResistor = 8'b0100_0010; opLed = ~ 8'b0100_0010; end  // iDataFromUart Ascii码对应的十六进制为 5 
        8'h36: begin opEnResistor = 8'b0100_0100; opLed = ~ 8'b0100_0100; end  // iDataFromUart Ascii码对应的十六进制为 6 
        8'h37: begin opEnResistor = 8'b0100_1000; opLed = ~ 8'b0100_1000; end  // iDataFromUart Ascii码对应的十六进制为 7 
        8'h38: begin opEnResistor = 8'b0010_0001; opLed = ~ 8'b0010_0001; end  // iDataFromUart Ascii码对应的十六进制为 8 
        8'h39: begin opEnResistor = 8'b0010_0010; opLed = ~ 8'b0010_0010; end  // iDataFromUart Ascii码对应的十六进制为 9 
        8'h41: begin opEnResistor = 8'b0010_0100; opLed = ~ 8'b0010_0100; end  // iDataFromUart Ascii码对应的十六进制为 A 
        8'h42: begin opEnResistor = 8'b0010_1000; opLed = ~ 8'b0010_1000; end  // iDataFromUart Ascii码对应的十六进制为 B
        8'h43: begin opEnResistor = 8'b0001_0001; opLed = ~ 8'b0001_0001; end  // iDataFromUart Ascii码对应的十六进制为 C 
        8'h44: begin opEnResistor = 8'b0001_0010; opLed = ~ 8'b0001_0010; end  // iDataFromUart Ascii码对应的十六进制为 D 
        8'h45: begin opEnResistor = 8'b0001_0100; opLed = ~ 8'b0001_0100; end  // iDataFromUart Ascii码对应的十六进制为 E 
        8'h46: begin opEnResistor = 8'b0001_1000; opLed = ~ 8'b0001_1000; end  // iDataFromUart Ascii码对应的十六进制为 F 
        default:begin opEnResistor = 8'b1000_1000; opLed = ~ 8'b0001_1000; end 
    endcase
end

endmodule

