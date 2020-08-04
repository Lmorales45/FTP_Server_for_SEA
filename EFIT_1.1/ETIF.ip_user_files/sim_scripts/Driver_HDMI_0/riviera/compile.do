vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../ETIF.srcs/sources_1/ip/Driver_HDMI_0/sim/Driver_HDMI.v" \
"../../../../ETIF.srcs/sources_1/ip/Driver_HDMI_0/sim/Driver_HDMI_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

