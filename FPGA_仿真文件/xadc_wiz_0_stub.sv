// Simulation-only ADC primitive stub. Averaging inputs are driven explicitly by the test.
module xadc_wiz_0(input [6:0] daddr_in,input dclk_in,den_in,input[15:0] di_in,
 input dwe_in,reset_in,vauxp0,vauxn0,vp_in,vn_in,
 output busy_out,output[4:0] channel_out,output[15:0] do_out,
 output drdy_out,eoc_out,eos_out,ot_out,vccaux_alarm_out,vccint_alarm_out,user_temp_alarm_out,alarm_out);
 assign {busy_out,channel_out,do_out,drdy_out,eoc_out,eos_out,ot_out,vccaux_alarm_out,vccint_alarm_out,user_temp_alarm_out,alarm_out}=0;
endmodule
