
################################################################
# This is a generated script based on design: GCD_block_design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source GCD_block_design_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k70tfbv676-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name GCD_block_design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set AB [ create_bd_port -dir I -from 31 -to 0 AB ]
  set RESULT [ create_bd_port -dir O -from 31 -to 0 RESULT ]
  set go [ create_bd_port -dir I go ]
  set rst [ create_bd_port -dir I rst ]

  # Create instance: Mux_0, and set properties
  set Mux_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:Mux:1.0 Mux_0 ]

  # Create instance: a_minus_b_0, and set properties
  set a_minus_b_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:a_minus_b:1.0 a_minus_b_0 ]

  # Create instance: b_minus_a_0, and set properties
  set b_minus_a_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:b_minus_a:1.0 b_minus_a_0 ]

  # Create instance: click_element_0, and set properties
  set click_element_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_0 ]
  set_property -dict [ list \
   CONFIG.PHASE_INIT {"1"} \
   CONFIG.VALUE {80872186} \
 ] $click_element_0

  # Create instance: click_element_1, and set properties
  set click_element_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_1 ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH_1 {1} \
   CONFIG.PHASE_INIT {"1"} \
   CONFIG.VALUE {1} \
 ] $click_element_1

  # Create instance: delay_element_0, and set properties
  set delay_element_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:delay_element:1.0 delay_element_0 ]
  set_property -dict [ list \
   CONFIG.size {15} \
 ] $delay_element_0

  # Create instance: delay_element_1, and set properties
  set delay_element_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:delay_element:1.0 delay_element_1 ]
  set_property -dict [ list \
   CONFIG.size {15} \
 ] $delay_element_1

  # Create instance: demux_0, and set properties
  set demux_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:demux:1.0 demux_0 ]

  # Create instance: demux_1, and set properties
  set demux_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:demux:1.0 demux_1 ]

  # Create instance: fork_stage_0, and set properties
  set fork_stage_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:fork_stage:1.0 fork_stage_0 ]

  # Create instance: fork_stage_1, and set properties
  set fork_stage_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:fork_stage:1.0 fork_stage_1 ]

  # Create instance: gate_0, and set properties
  set gate_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:gate:1.0 gate_0 ]

  # Create instance: inverter_0, and set properties
  set inverter_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:inverter:1.0 inverter_0 ]

  # Create instance: merge_0, and set properties
  set merge_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:merge:1.0 merge_0 ]

  # Create instance: sel_a_larger_b_0, and set properties
  set sel_a_larger_b_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:sel_a_larger_b:1.0 sel_a_larger_b_0 ]

  # Create instance: sel_a_not_b_fork_0, and set properties
  set sel_a_not_b_fork_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:sel_a_not_b_fork:1.0 sel_a_not_b_fork_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Mux_0_c_ctrl_out [get_bd_intf_pins Mux_0/c_ctrl_out] [get_bd_intf_pins fork_stage_0/a_ctrl_in]
  connect_bd_intf_net -intf_net click_element_0_ctrl_out [get_bd_intf_pins click_element_0/ctrl_out] [get_bd_intf_pins gate_0/ctrl_in]
  connect_bd_intf_net -intf_net click_element_1_ctrl_out [get_bd_intf_pins Mux_0/sel_ctrl_in] [get_bd_intf_pins click_element_1/ctrl_out]
  connect_bd_intf_net -intf_net demux_0_c_ctrl_out [get_bd_intf_pins demux_0/c_ctrl_out] [get_bd_intf_pins fork_stage_1/a_ctrl_in]
  connect_bd_intf_net -intf_net fork_stage_0_b_ctrl_out [get_bd_intf_pins fork_stage_0/b_ctrl_out] [get_bd_intf_pins sel_a_not_b_fork_0/ctrl_a_in]
  connect_bd_intf_net -intf_net fork_stage_0_c_ctrl_out [get_bd_intf_pins demux_0/a_ctrl_in] [get_bd_intf_pins fork_stage_0/c_ctrl_out]
  connect_bd_intf_net -intf_net fork_stage_1_b_ctrl_out [get_bd_intf_pins fork_stage_1/b_ctrl_out] [get_bd_intf_pins sel_a_larger_b_0/ctrl_in]
  connect_bd_intf_net -intf_net fork_stage_1_c_ctrl_out [get_bd_intf_pins demux_1/a_ctrl_in] [get_bd_intf_pins fork_stage_1/c_ctrl_out]
  connect_bd_intf_net -intf_net gate_0_ctrl_out [get_bd_intf_pins Mux_0/a_ctrl_in] [get_bd_intf_pins gate_0/ctrl_out]
  connect_bd_intf_net -intf_net inverter_0_ctrl_out [get_bd_intf_pins click_element_1/ctrl_in] [get_bd_intf_pins inverter_0/ctrl_out]
  connect_bd_intf_net -intf_net merge_0_c_ctrl_out [get_bd_intf_pins Mux_0/b_ctrl_in] [get_bd_intf_pins merge_0/c_ctrl_out]
  connect_bd_intf_net -intf_net sel_a_larger_b_0_sel_ctrl_out [get_bd_intf_pins demux_1/sel_ctrl_in] [get_bd_intf_pins sel_a_larger_b_0/sel_ctrl_out]
  connect_bd_intf_net -intf_net sel_a_not_b_fork_0_ctrl_sel_b_out [get_bd_intf_pins inverter_0/ctrl_in] [get_bd_intf_pins sel_a_not_b_fork_0/ctrl_sel_b_out]
  connect_bd_intf_net -intf_net sel_a_not_b_fork_0_ctrl_sel_c_out [get_bd_intf_pins demux_0/sel_ctrl_in] [get_bd_intf_pins sel_a_not_b_fork_0/ctrl_sel_c_out]

  # Create port connections
  connect_bd_net -net AB_1 [get_bd_ports AB] [get_bd_pins click_element_0/data_in]
  connect_bd_net -net Mux_0_c_data_out [get_bd_pins Mux_0/c_data_out] [get_bd_pins fork_stage_0/a_data_in]
  connect_bd_net -net a_minus_b_0_result [get_bd_pins a_minus_b_0/result] [get_bd_pins merge_0/a_data_in]
  connect_bd_net -net b_minus_a_0_result [get_bd_pins b_minus_a_0/result] [get_bd_pins merge_0/b_data_in]
  connect_bd_net -net click_element_0_ack_out [get_bd_pins click_element_0/ack_out] [get_bd_pins click_element_0/req_in]
  connect_bd_net -net click_element_0_data_out [get_bd_pins Mux_0/a_data_in] [get_bd_pins click_element_0/data_out]
  connect_bd_net -net click_element_1_data_out [get_bd_pins Mux_0/selector] [get_bd_pins click_element_1/data_out]
  connect_bd_net -net delay_element_0_z [get_bd_pins delay_element_0/z] [get_bd_pins merge_0/b_req_in]
  connect_bd_net -net delay_element_1_z [get_bd_pins delay_element_1/z] [get_bd_pins merge_0/a_req_in]
  connect_bd_net -net demux_0_b_data_out [get_bd_ports RESULT] [get_bd_pins demux_0/b_data_out]
  connect_bd_net -net demux_0_b_req_out [get_bd_pins demux_0/b_ack_in] [get_bd_pins demux_0/b_req_out]
  connect_bd_net -net demux_0_c_data_out [get_bd_pins demux_0/c_data_out] [get_bd_pins fork_stage_1/a_data_in]
  connect_bd_net -net demux_1_b_data_out [get_bd_pins a_minus_b_0/ab] [get_bd_pins demux_1/b_data_out]
  connect_bd_net -net demux_1_b_req_out [get_bd_pins delay_element_1/d] [get_bd_pins demux_1/b_req_out]
  connect_bd_net -net demux_1_c_data_out [get_bd_pins b_minus_a_0/ab] [get_bd_pins demux_1/c_data_out]
  connect_bd_net -net demux_1_c_req_out [get_bd_pins delay_element_0/d] [get_bd_pins demux_1/c_req_out]
  connect_bd_net -net fork_stage_0_b_data_out [get_bd_pins fork_stage_0/b_data_out] [get_bd_pins sel_a_not_b_fork_0/a_data_in]
  connect_bd_net -net fork_stage_0_c_data_out [get_bd_pins demux_0/a_data_in] [get_bd_pins fork_stage_0/c_data_out]
  connect_bd_net -net fork_stage_1_b_data_out [get_bd_pins fork_stage_1/b_data_out] [get_bd_pins sel_a_larger_b_0/data_in]
  connect_bd_net -net fork_stage_1_c_data_out [get_bd_pins demux_1/a_data_in] [get_bd_pins fork_stage_1/c_data_out]
  connect_bd_net -net go_1 [get_bd_ports go] [get_bd_pins gate_0/go]
  connect_bd_net -net merge_0_a_ack_out [get_bd_pins demux_1/b_ack_in] [get_bd_pins merge_0/a_ack_out]
  connect_bd_net -net merge_0_b_ack_out [get_bd_pins demux_1/c_ack_in] [get_bd_pins merge_0/b_ack_out]
  connect_bd_net -net merge_0_c_data_out [get_bd_pins Mux_0/b_data_in] [get_bd_pins merge_0/c_data_out]
  connect_bd_net -net rst_1 [get_bd_ports rst] [get_bd_pins Mux_0/reset] [get_bd_pins click_element_0/rst] [get_bd_pins click_element_1/rst] [get_bd_pins demux_0/reset] [get_bd_pins demux_1/reset] [get_bd_pins fork_stage_0/rst] [get_bd_pins fork_stage_1/rst] [get_bd_pins merge_0/rst] [get_bd_pins sel_a_larger_b_0/reset] [get_bd_pins sel_a_not_b_fork_0/reset]
  connect_bd_net -net sel_a_larger_b_0_selector [get_bd_pins demux_1/selector] [get_bd_pins sel_a_larger_b_0/selector]
  connect_bd_net -net sel_a_not_b_fork_0_selector [get_bd_pins click_element_1/data_in] [get_bd_pins demux_0/selector] [get_bd_pins sel_a_not_b_fork_0/selector]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


