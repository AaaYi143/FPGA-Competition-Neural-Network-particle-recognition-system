`timescale 1ns/1ps
// Digital reset/scan demonstration. The ADC primitive is a simulation stub.
module tb_powerup;
reg clk=0; always #5 clk=~clk;
reg rst_n=1,eoc=0;wire [6:0] channel_code;wire pc_tx,stm_tx;
Main dut(.ipClk(clk),.ipRst_(rst_n),.ipKey(8'd0),.ipVauxP(4'd0),.ipVauxN(4'd0),
 .ipUartRx(1'b1),.ipUartRx_Wireless(1'b1),.opChooseChannel(channel_code),.opUartTx(pc_tx),.opParticleTx(stm_tx));
integer ch,k;integer samples=0;
always @(posedge clk) if(rst_n && dut.trigOfSelectData) samples=samples+1;
initial begin
 force dut.trigOfEOC=eoc;
 #2;rst_n=0;repeat(20)@(negedge clk);
 for(ch=0;ch<32;ch=ch+1)
  if(dut.cnt2[ch]!==0||dut.sum[ch]!==0||dut.averageOfSum[ch]!==0||dut.average[ch]!==0)
   $fatal(1,"reset did not clear channel %0d",ch);
 if(dut.channelCnt!==0||dut.frameDone!==0||stm_tx!==1'b1)$fatal(1,"reset status wrong");
 rst_n=1;repeat(20)@(negedge clk);
 // Spaced digital conversion events exercise settling, sampling and channel scan.
 for(k=0;k<6*34;k=k+1)begin
  eoc=1;@(negedge clk);eoc=0;repeat(19)@(negedge clk);
 end
 if(samples<32)$fatal(1,"scan did not generate samples");
 // A later reset also clears the partially accumulated frame.
 rst_n=0;repeat(10)@(negedge clk);
 for(ch=0;ch<32;ch=ch+1)if(dut.cnt2[ch]!==0||dut.sum[ch]!==0)$fatal(1,"second reset failed");
 rst_n=1;repeat(20)@(negedge clk);
 $display("POWERUP_ALL_PASS samples=%0d",samples);$finish;
end
initial begin #100000;$fatal(1,"powerup timeout");end
endmodule
