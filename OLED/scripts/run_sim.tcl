# ================================================================
# run_sim.tcl - Launch comprehensive behavioral simulation in Vivado
# ================================================================
open_project OLED.xpr

# Add simulation files if not already present
add_files -norecurse -fileset sim_1 {
    sim/ssd1306_slave_model.sv
    sim/tb_oled_complete.sv
    sim/tb_oled.sv
}

# Set tb_oled_complete as top simulation module
set_property top tb_oled_complete [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

# Launch behavioral simulation
launch_simulation -mode behavioral

# Run simulation until completion
run all

close_sim
close_project
