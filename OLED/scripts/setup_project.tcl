# ================================================================
# setup_project.tcl
# Configure Vivado OLED project with xc7a35tcsg324-1 and all source files
# ================================================================
open_project OLED.xpr

# Set Part to Artix-7 xc7a35tcsg324-1 (EGo1)
set_property part xc7a35tcsg324-1 [current_project]
set_property part xc7a35tcsg324-1 [get_runs synth_1]
set_property part xc7a35tcsg324-1 [get_runs impl_1]

# Add RTL Sources
add_files -norecurse -fileset sources_1 {
    rtl/i2c_master.sv
    rtl/ssd1306_ctrl.sv
    rtl/font_rom_8.sv
    rtl/font_rom_16.sv
    rtl/font_rom_32.sv
    rtl/oled_controller.sv
    rtl/oled_particle_display.sv
    rtl/Top_OLED.sv
}

# Set Top Module
set_property top Top_OLED [current_fileset]

# Add Constraints
add_files -norecurse -fileset constrs_1 {constrs/OLED_test.xdc}

# Add Simulation Sources
add_files -norecurse -fileset sim_1 {
    sim/ssd1306_slave_model.sv
    sim/tb_oled_complete.sv
    sim/tb_oled.sv
}
set_property top tb_oled_complete [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "OLED Vivado project updated successfully!"
close_project
