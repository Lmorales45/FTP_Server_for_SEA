vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../ETIF.srcs/sources_1/ip/Driver_HDMI_0/sim/Driver_HDMI.v" \
"../../../../ETIF.srcs/sources_1/ip/Driver_HDMI_0/sim/Driver_HDMI_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

