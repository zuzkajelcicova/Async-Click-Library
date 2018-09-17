# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_WIDTH_A" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH_C" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PHASE_INIT" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA_WIDTH_A { PARAM_VALUE.DATA_WIDTH_A } {
	# Procedure called to update DATA_WIDTH_A when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_A { PARAM_VALUE.DATA_WIDTH_A } {
	# Procedure called to validate DATA_WIDTH_A
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH_B { PARAM_VALUE.DATA_WIDTH_B } {
	# Procedure called to update DATA_WIDTH_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_B { PARAM_VALUE.DATA_WIDTH_B } {
	# Procedure called to validate DATA_WIDTH_B
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH_C { PARAM_VALUE.DATA_WIDTH_C } {
	# Procedure called to update DATA_WIDTH_C when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_C { PARAM_VALUE.DATA_WIDTH_C } {
	# Procedure called to validate DATA_WIDTH_C
	return true
}

proc update_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to update PHASE_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to validate PHASE_INIT
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH_A { MODELPARAM_VALUE.DATA_WIDTH_A PARAM_VALUE.DATA_WIDTH_A } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_A}] ${MODELPARAM_VALUE.DATA_WIDTH_A}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH_B { MODELPARAM_VALUE.DATA_WIDTH_B PARAM_VALUE.DATA_WIDTH_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_B}] ${MODELPARAM_VALUE.DATA_WIDTH_B}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH_C { MODELPARAM_VALUE.DATA_WIDTH_C PARAM_VALUE.DATA_WIDTH_C } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_C}] ${MODELPARAM_VALUE.DATA_WIDTH_C}
}

proc update_MODELPARAM_VALUE.PHASE_INIT { MODELPARAM_VALUE.PHASE_INIT PARAM_VALUE.PHASE_INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PHASE_INIT}] ${MODELPARAM_VALUE.PHASE_INIT}
}

