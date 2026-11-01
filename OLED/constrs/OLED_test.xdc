# ================================================================
# OLED_test.xdc - Constraints for EGo1 Board (xc7a35tcsg324-1)
# Standalone OLED Driver Verification
# ================================================================

# System Clock 100MHz
set_property PACKAGE_PIN P17 [get_ports {ipClk}]
set_property IOSTANDARD LVCMOS33 [get_ports {ipClk}]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports {ipClk}]

# Active-low Reset Button S6
set_property PACKAGE_PIN P15 [get_ports {ipRst_}]
set_property IOSTANDARD LVCMOS33 [get_ports {ipRst_}]

# Mode Selection Switches: SW0, SW1
set_property PACKAGE_PIN R1 [get_ports {ipSw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ipSw[0]}]
set_property PACKAGE_PIN N4 [get_ports {ipSw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ipSw[1]}]

# Status LEDs: D2_0 to D2_7
set_property PACKAGE_PIN K2 [get_ports {opLed[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[0]}]
set_property PACKAGE_PIN J2 [get_ports {opLed[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[1]}]
set_property PACKAGE_PIN J3 [get_ports {opLed[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[2]}]
set_property PACKAGE_PIN H4 [get_ports {opLed[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[3]}]
set_property PACKAGE_PIN J4 [get_ports {opLed[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[4]}]
set_property PACKAGE_PIN G3 [get_ports {opLed[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[5]}]
set_property PACKAGE_PIN G4 [get_ports {opLed[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[6]}]
set_property PACKAGE_PIN F6 [get_ports {opLed[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opLed[7]}]

# OLED I2C Dedicated Bus Pins: J5-25 (SCL) and J5-26 (SDA)
set_property PACKAGE_PIN H14 [get_ports {oled_scl}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_scl}]
set_property DRIVE 8 [get_ports {oled_scl}]
set_property SLEW SLOW [get_ports {oled_scl}]
set_property PULLUP true [get_ports {oled_scl}]

set_property PACKAGE_PIN G14 [get_ports {oled_sda}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_sda}]
set_property DRIVE 8 [get_ports {oled_sda}]
set_property SLEW SLOW [get_ports {oled_sda}]
set_property PULLUP true [get_ports {oled_sda}]

# EGo1 3.3-V Configuration & Bitstream Settings
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 16 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR NO [current_design]
