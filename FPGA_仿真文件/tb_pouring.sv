`timescale 1ns/1ps
module tb_pouring;
localparam N=30;
reg clk=0; always #5 clk=~clk;
reg rst_n=0,valid=0; reg signed [23:0] raw=0;
wire [7:0] seg0,seg1,en;wire [1:0] result_class;wire result_valid,result_empty;
Neural_network #(.IN_FEATURES(31),.OUT_FEATURES(4),.BIT_WIDTH(8),.PARREL(1),.RAW_DATA_W(24)) dut(
 .i_clk(clk),.i_rst_n(rst_n),.op_seg_en(en),.op_seg_data(seg0),.op_seg_data_bank1(seg1),
 .raw_sig(raw),.raw_valid(valid),.result_class(result_class),.result_valid(result_valid),.result_empty(result_empty));
reg [23:0] inputs[0:N*31-1];reg [7:0] expected_norm[0:N*31-1],expected_class[0:N-1],expected_empty[0:N-1];
reg signed [31:0] fc1[0:N*20-1],fc2[0:N*31-1],fc3[0:N*4-1];
reg signed [7:0] act1[0:N*20-1],act2[0:N*31-1];
reg [7:0] scene=0, feature_index=0;
reg [7:0] scenes[0:N-1];
integer np=0,nc=0,nf1=0,nf2=0,nf3=0,na1=0,na2=0,errors=0,f,i,j;
always @(negedge clk) if(rst_n)begin
 if(dut.preproc_valid)begin if(np>=N*31||dut.preproc_out_0_255!==expected_norm[np])errors=errors+1;np=np+1;end
 if(dut.nn_module_inst.done_fc1)begin for(j=0;j<20;j=j+1)if($signed(dut.nn_module_inst.output_fc1[j])!==fc1[nf1*20+j])errors=errors+1;nf1=nf1+1;end
 if(dut.nn_module_inst.done_act1)begin for(j=0;j<20;j=j+1)if($signed(dut.nn_module_inst.output_act1[j])!==act1[na1*20+j])errors=errors+1;na1=na1+1;end
 if(dut.nn_module_inst.done_fc2)begin for(j=0;j<31;j=j+1)if($signed(dut.nn_module_inst.output_fc2[j])!==fc2[nf2*31+j])errors=errors+1;nf2=nf2+1;end
 if(dut.nn_module_inst.done_act2)begin for(j=0;j<31;j=j+1)if($signed(dut.nn_module_inst.output_act2[j])!==act2[na2*31+j])errors=errors+1;na2=na2+1;end
 if(dut.nn_module_inst.done_fc3)begin for(j=0;j<4;j=j+1)if($signed(dut.nn_module_inst.output_fc3[j])!==fc3[nf3*4+j])errors=errors+1;nf3=nf3+1;end
 if(result_valid)begin
  if(nc>=N||result_class!==expected_class[nc][1:0]||result_empty!==expected_empty[nc][0]||dut.display_code!==((expected_empty[nc]!=0)?8'd0:(expected_class[nc]+8'd1)))errors=errors+1;
  $display("REPLAY frame=%0d scene=%0d class=%0d empty=%0d time_ns=%0d",nc,scene,result_class,result_empty,$time);
  nc=nc+1;
 end
 if(en[7:4]!==0 || seg1!==0)errors=errors+1;
end
initial begin
 $readmemh("scene.mem",scenes);
 $readmemh("raw.mem",inputs);$readmemh("norm.mem",expected_norm);$readmemh("class.mem",expected_class);$readmemh("empty.mem",expected_empty);
 $readmemh("fc1.mem",fc1);$readmemh("fc2.mem",fc2);$readmemh("fc3.mem",fc3);$readmemh("act1.mem",act1);$readmemh("act2.mem",act2);
 repeat(8)@(negedge clk);rst_n=1;repeat(10)@(negedge clk);
 for(f=0;f<N;f=f+1)begin
  scene=scenes[f];
  for(i=0;i<31;i=i+1)begin @(negedge clk);feature_index=i;raw=inputs[f*31+i];valid=1;
   if(i==15)begin @(negedge clk);valid=0;repeat(2)@(negedge clk);end
  end
  @(negedge clk);valid=0;repeat(3000)@(negedge clk);
 end
 $display("NETWORK_COUNTS frames=%0d norm=%0d fc1=%0d act1=%0d fc2=%0d act2=%0d fc3=%0d class=%0d errors=%0d",N,np,nf1,na1,nf2,na2,nf3,nc,errors);
 if(errors||np!=N*31||nc!=N||nf1!=N||nf2!=N||nf3!=N||na1!=N||na2!=N)$fatal(1,"network mismatch");
 $display("POURING_ALL_PASS");$finish;
end
initial begin #40000000;$fatal(1,"timeout");end
endmodule
