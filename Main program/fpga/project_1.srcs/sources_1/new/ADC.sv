`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/24 13:12:17
// Design Name: 
// Module Name: ADC
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


module ADC(
    input                       i_clk,
    input                       i_rst_,     
    input           [ 3:0]      i_vauxP, // Auxiliary analog channel inputs
    input           [ 3:0]      i_vauxN,
    output          [15:0]      outputDataOfAD,
    output                      trigOfEOC                   
    );

//xadc
wire                [ 4:0]      channel;
wire                            endOfConversion;
           
reg                             endOfConversionReg;

xadc_wiz_0      Xadc_inst
 (
        .daddr_in               ({2'b00, channel}),            // Address bus for the dynamic reconfiguration port 
        .dclk_in                (i_clk),             // Clock input for the dynamic reconfiguration port
        .den_in                 (endOfConversion),              // Enable Signal for the dynamic reconfiguration port
        .di_in                  (),               // Input data bus for the dynamic reconfiguration port 16'b0
        .dwe_in                 (),              // Write Enable for the dynamic reconfiguration port 1'b0
        .reset_in               (~i_rst_),            // Reset signal for the System Monitor control logic
        .vauxp0                 (i_vauxP),              // Auxiliary channel 0
        .vauxn0                 (i_vauxN),
        .busy_out               (),            // ADC Busy signal
        .channel_out            (channel),         // Channel Selection Outputs
        .do_out                 (outputDataOfAD),              // Output data bus for dynamic reconfiguration port
        .drdy_out               (),            // Data ready signal for the dynamic reconfiguration port
        .eoc_out                (endOfConversion),             // End of Conversion Signal
        .eos_out                (),             // End of Sequence Signal
        .ot_out                 (),              // Over-Temperature alarm output
        .vccaux_alarm_out       (),    // VCCAUX-sensor alarm output
        .vccint_alarm_out       (),    //  VCCINT-sensor alarm output
        .user_temp_alarm_out    (), // Temperature-sensor alarm output
        .alarm_out              (),           // OR'ed output of all the Alarms    
        .vp_in                  (),               // Dedicated Analog Input Pair
        .vn_in                  ()
);

// 获取AD采集转换结束的边沿
always @ (posedge i_clk or negedge i_rst_)
begin
    if (!i_rst_)
        endOfConversionReg <= 1'd0;
    else
        endOfConversionReg <= endOfConversion;
end
assign trigOfEOC = (endOfConversionReg == 1'b0 && endOfConversion == 1'b1) ? 1'b1 : 1'b0;

endmodule
