
################################################################
# This is a generated script based on design: Fibonacci
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
# source Fibonacci_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k70tfbv676-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name Fibonacci

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
  set RESULT [ create_bd_port -dir O -from 31 -to 0 RESULT ]
  set go [ create_bd_port -dir I go ]
  set rst [ create_bd_port -dir I rst ]

  # Create instance: Fork_0, and set properties
  set Fork_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:Fork:1.0 Fork_0 ]

  # Create instance: Fork_1, and set properties
  set Fork_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:Fork:1.0 Fork_1 ]

  # Create instance: async_add_0, and set properties
  set async_add_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:async_add:1.0 async_add_0 ]
  set_property -dict [ list \
   CONFIG.PHASE_INIT {"1"} \
 ] $async_add_0

  # Create instance: click_element_0, and set properties
  set click_element_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_0 ]

  # Create instance: click_element_1, and set properties
  set click_element_1 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_1 ]
  set_property -dict [ list \
   CONFIG.VALUE {1} \
 ] $click_element_1

  # Create instance: click_element_2, and set properties
  set click_element_2 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_2 ]

  # Create instance: click_element_3, and set properties
  set click_element_3 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_3 ]

  # Create instance: click_element_4, and set properties
  set click_element_4 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:click_element:1.0 click_element_4 ]

  # Create instance: gate_0, and set properties
  set gate_0 [ create_bd_cell -type ip -vlnv xilinx.com:click_components:gate:1.0 gate_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Fork_0_b_ctrl_out [get_bd_intf_pins Fork_0/b_ctrl_out] [get_bd_intf_pins async_add_0/b_ctrl_in]
  connect_bd_intf_net -intf_net Fork_0_c_ctrl_out [get_bd_intf_pins Fork_0/c_ctrl_out] [get_bd_intf_pins click_element_2/ctrl_in]
  connect_bd_intf_net -intf_net Fork_1_b_ctrl_out [get_bd_intf_pins Fork_1/b_ctrl_out] [get_bd_intf_pins click_element_4/ctrl_in]
  connect_bd_intf_net -intf_net Fork_1_c_ctrl_out [get_bd_intf_pins Fork_1/c_ctrl_out] [get_bd_intf_pins click_element_0/ctrl_in]
  connect_bd_intf_net -intf_net async_add_0_c_ctrl_out [get_bd_intf_pins async_add_0/c_ctrl_out] [get_bd_intf_pins gate_0/ctrl_in]
  connect_bd_intf_net -intf_net click_element_0_ctrl_out [get_bd_intf_pins click_element_0/ctrl_out] [get_bd_intf_pins click_element_1/ctrl_in]
  connect_bd_intf_net -intf_net click_element_1_ctrl_out [get_bd_intf_pins Fork_0/a_ctrl_in] [get_bd_intf_pins click_element_1/ctrl_out]
  connect_bd_intf_net -intf_net click_element_2_ctrl_out [get_bd_intf_pins click_element_2/ctrl_out] [get_bd_intf_pins click_element_3/ctrl_in]
  connect_bd_intf_net -intf_net click_element_3_ctrl_out [get_bd_intf_pins async_add_0/a_ctrl_in] [get_bd_intf_pins click_element_3/ctrl_out]
  connect_bd_intf_net -intf_net gate_0_ctrl_out [get_bd_intf_pins Fork_1/a_ctrl_in] [get_bd_intf_pins gate_0/ctrl_out]

  # Create port connections
  connect_bd_net -net async_add_0_c_data_out [get_bd_pins async_add_0/c_data_out] [get_bd_pins click_element_0/data_in] [get_bd_pins click_element_4/data_in]
  connect_bd_net -net click_element_0_data_out [get_bd_pins click_element_0/data_out] [get_bd_pins click_element_1/data_in]
  connect_bd_net -net click_element_1_data_out [get_bd_pins async_add_0/b_data_in] [get_bd_pins click_element_1/data_out] [get_bd_pins click_element_2/data_in]
  connect_bd_net -net click_element_2_data_out [get_bd_pins click_element_2/data_out] [get_bd_pins click_element_3/data_in]
  connect_bd_net -net click_element_3_data_out [get_bd_pins async_add_0/a_data_in] [get_bd_pins click_element_3/data_out]
  connect_bd_net -net click_element_4_data_out [get_bd_ports RESULT] [get_bd_pins click_element_4/data_out]
  connect_bd_net -net click_element_4_req_out [get_bd_pins click_element_4/ack_in] [get_bd_pins click_element_4/req_out]
  connect_bd_net -net go_1 [get_bd_ports go] [get_bd_pins gate_0/go]
  connect_bd_net -net rst_1 [get_bd_ports rst] [get_bd_pins Fork_0/rst] [get_bd_pins Fork_1/rst] [get_bd_pins async_add_0/rst] [get_bd_pins click_element_0/rst] [get_bd_pins click_element_1/rst] [get_bd_pins click_element_2/rst] [get_bd_pins click_element_3/rst] [get_bd_pins click_element_4/rst]

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


