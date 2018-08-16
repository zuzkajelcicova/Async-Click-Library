# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "PHASE_INIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PHASE_INIT_A" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PHASE_INIT_B" -parent ${Page_0}


}

proc update_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to update PHASE_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to validate PHASE_INIT
	return true
}

proc update_PARAM_VALUE.PHASE_INIT_A { PARAM_VALUE.PHASE_INIT_A } {
	# Procedure called to update PHASE_INIT_A when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PHASE_INIT_A { PARAM_VALUE.PHASE_INIT_A } {
	# Procedure called to validate PHASE_INIT_A
	return true
}

proc update_PARAM_VALUE.PHASE_INIT_B { PARAM_VALUE.PHASE_INIT_B } {
	# Procedure called to update PHASE_INIT_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PHASE_INIT_B { PARAM_VALUE.PHASE_INIT_B } {
	# Procedure called to validate PHASE_INIT_B
	return true
}


proc update_MODELPARAM_VALUE.PHASE_INIT { MODELPARAM_VALUE.PHASE_INIT PARAM_VALUE.PHASE_INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PHASE_INIT}] ${MODELPARAM_VALUE.PHASE_INIT}
}

proc update_MODELPARAM_VALUE.PHASE_INIT_A { MODELPARAM_VALUE.PHASE_INIT_A PARAM_VALUE.PHASE_INIT_A } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PHASE_INIT_A}] ${MODELPARAM_VALUE.PHASE_INIT_A}
}

proc update_MODELPARAM_VALUE.PHASE_INIT_B { MODELPARAM_VALUE.PHASE_INIT_B PARAM_VALUE.PHASE_INIT_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PHASE_INIT_B}] ${MODELPARAM_VALUE.PHASE_INIT_B}
}

