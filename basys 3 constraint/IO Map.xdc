#clock signal
set_property PACKAGE_PIN W5 [get_ports clk_100MHZ]
    set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHZ]
    # period 1.00 = 10 mhz, waveform 0 ns - rise time 5-ns fall time (50% duty cycle) 
    create_clock -period 10.000 -waveform {0 5} [get_ports clk_100MHZ]
    
# push buttons U,D,L,R,M
set_property PACKAGE_PIN U18 [get_ports {pb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb[0]}]

set_property PACKAGE_PIN T17 [get_ports {pb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb[1]}]

set_property PACKAGE_PIN W19 [get_ports {pb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb[2]}]

set_property PACKAGE_PIN U17 [get_ports {pb[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb[3]}]

set_property PACKAGE_PIN T18 [get_ports {pb[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb[4]}]

#7 segment
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

set_property PACKAGE_PIN V7 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]

# anodes
set_property PACKAGE_PIN U2 [get_ports {anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]

set_property PACKAGE_PIN U4 [get_ports {anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]

set_property PACKAGE_PIN V4 [get_ports {anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]

set_property PACKAGE_PIN W4 [get_ports {anode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]

# switches
set_property PACKAGE_PIN V17 [get_ports {switch[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]

set_property PACKAGE_PIN V16 [get_ports {switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]

set_property PACKAGE_PIN W16 [get_ports {switch[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[2]}]

set_property PACKAGE_PIN W17 [get_ports {switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[3]}]

set_property PACKAGE_PIN W15 [get_ports {switch[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[4]}]

set_property PACKAGE_PIN V15 [get_ports {switch[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[5]}]

set_property PACKAGE_PIN W14 [get_ports {switch[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[6]}]

set_property PACKAGE_PIN W13 [get_ports {switch[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[7]}]

set_property PACKAGE_PIN V2 [get_ports {switch[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[8]}]

set_property PACKAGE_PIN T3 [get_ports {switch[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[9]}]

set_property PACKAGE_PIN T2 [get_ports {switch[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[10]}]

set_property PACKAGE_PIN R3 [get_ports {switch[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[11]}]

set_property PACKAGE_PIN W2 [get_ports {switch[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[12]}]

set_property PACKAGE_PIN U1 [get_ports {switch[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[13]}]

set_property PACKAGE_PIN T1 [get_ports {switch[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[14]}]

set_property PACKAGE_PIN R2 [get_ports {switch[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[15]}]

#leds

set_property PACKAGE_PIN U16 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]

set_property PACKAGE_PIN E19 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]

set_property PACKAGE_PIN U19 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]

set_property PACKAGE_PIN V19 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]

set_property PACKAGE_PIN W18 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]

set_property PACKAGE_PIN U15 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]

set_property PACKAGE_PIN U14 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]

set_property PACKAGE_PIN V14 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

set_property PACKAGE_PIN V13 [get_ports {leds[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[8]}]

set_property PACKAGE_PIN V3 [get_ports {leds[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[9]}]

set_property PACKAGE_PIN W3 [get_ports {leds[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[10]}]

set_property PACKAGE_PIN U3 [get_ports {leds[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[11]}]

set_property PACKAGE_PIN P3 [get_ports {leds[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[12]}]

set_property PACKAGE_PIN N3 [get_ports {leds[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[13]}]

set_property PACKAGE_PIN P1 [get_ports {leds[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[14]}]

set_property PACKAGE_PIN L1 [get_ports {leds[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[15]}]