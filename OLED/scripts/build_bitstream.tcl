# ================================================================
# build_bitstream.tcl - Run Synthesis, Implementation and Bitstream
# Target Part: xc7a35tcsg324-1 (EGo1)
# ================================================================
open_project OLED.xpr

# Set part and options
set_property part xc7a35tcsg324-1 [current_project]
set_property top Top_OLED [current_fileset]

# Reset previous runs
reset_run synth_1
reset_run impl_1

# Launch implementation and write bitstream
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

# Check result
set impl_run [get_runs impl_1]
puts "Implementation status: [get_property STATUS $impl_run]"
puts "Implementation progress: [get_property PROGRESS $impl_run]"

close_project
