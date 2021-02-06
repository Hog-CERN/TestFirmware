#vivado

set BIN_FILE 1

### FPGA and Vivado strategies and flows

set FPGA xc7a35tcpg236-1
set SYNTH_STRATEGY "Flow_AreaOptimized_High"
set SYNTH_FLOW "Vivado Synthesis 2017"
set IMPL_STRATEGY "Performance_ExplorePostRoutePhysOpt"
set IMPL_FLOW "Vivado Implementation 2017"
set DESIGN "[file rootname [file tail [info script]]]"
set PATH_REPO "[file normalize [file dirname [info script]]]/../../"
set SIMULATOR "xsim"

source $PATH_REPO/Hog/Tcl/create_project.tcl
