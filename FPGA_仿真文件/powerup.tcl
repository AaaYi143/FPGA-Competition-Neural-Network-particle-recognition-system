log_wave -r /*
add_wave /tb_powerup/clk
add_wave /tb_powerup/rst_n
add_wave /tb_powerup/eoc
add_wave /tb_powerup/channel_code
add_wave /tb_powerup/pc_tx
add_wave /tb_powerup/stm_tx
add_wave /tb_powerup/dut/channelCnt
add_wave /tb_powerup/dut/conversionCnt
add_wave /tb_powerup/dut/trigOfSelectData
add_wave /tb_powerup/dut/frameDone
add_wave /tb_powerup/dut/averageValid_nn
run all
save_wave_config powerup.wcfg
quit
