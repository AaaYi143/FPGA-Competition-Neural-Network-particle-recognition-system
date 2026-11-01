# ================================================================
# run_synth.tcl - Run Vivado Synthesis on Top_OLED for xc7a35tcsg324-1
# ================================================================
open_project OLED.xpr
set_property top Top_OLED [current_fileset]
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

open_run synth_1
report_utilization -file synth_utilization.rpt
report_timing_summary -file synth_timing.rpt

puts "Synthesis completed successfully!"
close_project
