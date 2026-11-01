log_wave -r /*
add_wave /tb_pouring/clk
add_wave /tb_pouring/rst_n
add_wave /tb_pouring/scene
add_wave /tb_pouring/f
add_wave /tb_pouring/feature_index
add_wave /tb_pouring/raw
add_wave /tb_pouring/valid
add_wave /tb_pouring/dut/preproc_out_0_255
add_wave /tb_pouring/dut/preproc_valid
add_wave /tb_pouring/dut/nn_module_inst/done_fc1
add_wave /tb_pouring/dut/nn_module_inst/done_fc2
add_wave /tb_pouring/dut/nn_module_inst/done_fc3
add_wave /tb_pouring/result_valid
add_wave /tb_pouring/result_class
add_wave /tb_pouring/result_empty
add_wave /tb_pouring/dut/display_code
run all
save_wave_config pouring.wcfg
quit
