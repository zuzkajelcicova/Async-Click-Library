--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Mon Jul 30 12:41:39 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target GCD_block_design.bd
--Design      : GCD_block_design
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GCD_block_design is
  port (
    AB : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of GCD_block_design : entity is "GCD_block_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=GCD_block_design,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=16,numReposBlks=16,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of GCD_block_design : entity is "GCD_block_design.hwdef";
end GCD_block_design;

architecture STRUCTURE of GCD_block_design is
  component GCD_block_design_click_element_0_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component GCD_block_design_click_element_0_0;
  component GCD_block_design_click_element_1_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ack_in : in STD_LOGIC
  );
  end component GCD_block_design_click_element_1_0;
  component GCD_block_design_gate_0_0 is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component GCD_block_design_gate_0_0;
  component GCD_block_design_inverter_0_0 is
  port (
    req_in : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_out : out STD_LOGIC;
    ack_in : in STD_LOGIC
  );
  end component GCD_block_design_inverter_0_0;
  component GCD_block_design_Mux_0_0 is
  port (
    reset : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_in : in STD_LOGIC;
    b_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_out : out STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC;
    sel_req_in : in STD_LOGIC;
    sel_ack_out : out STD_LOGIC;
    selector : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component GCD_block_design_Mux_0_0;
  component GCD_block_design_demux_0_0 is
  port (
    reset : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    sel_req_in : in STD_LOGIC;
    sel_ack_out : out STD_LOGIC;
    selector : in STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_demux_0_0;
  component GCD_block_design_demux_1_0 is
  port (
    reset : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    sel_req_in : in STD_LOGIC;
    sel_ack_out : out STD_LOGIC;
    selector : in STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_demux_1_0;
  component GCD_block_design_fork_stage_0_0 is
  port (
    rst : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_fork_stage_0_0;
  component GCD_block_design_fork_stage_1_0 is
  port (
    rst : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_fork_stage_1_0;
  component GCD_block_design_sel_a_larger_b_0_0 is
  port (
    reset : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_in : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    selector : out STD_LOGIC;
    sel_req_out : out STD_LOGIC;
    sel_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_sel_a_larger_b_0_0;
  component GCD_block_design_sel_a_not_b_fork_0_0 is
  port (
    reset : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_req_in : in STD_LOGIC;
    a_ack_out : out STD_LOGIC;
    selector : out STD_LOGIC_VECTOR ( 0 to 0 );
    sel_req_b_out : out STD_LOGIC;
    sel_ack_b_in : in STD_LOGIC;
    sel_req_c_out : out STD_LOGIC;
    sel_ack_c_in : in STD_LOGIC
  );
  end component GCD_block_design_sel_a_not_b_fork_0_0;
  component GCD_block_design_merge_0_0 is
  port (
    rst : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_ack_out : out STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b_req_in : in STD_LOGIC;
    b_ack_out : out STD_LOGIC;
    b_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component GCD_block_design_merge_0_0;
  component GCD_block_design_a_minus_b_0_0 is
  port (
    ab : in STD_LOGIC_VECTOR ( 31 downto 0 );
    result : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component GCD_block_design_a_minus_b_0_0;
  component GCD_block_design_b_minus_a_0_0 is
  port (
    ab : in STD_LOGIC_VECTOR ( 31 downto 0 );
    result : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component GCD_block_design_b_minus_a_0_0;
  component GCD_block_design_delay_element_0_0 is
  port (
    d : in STD_LOGIC;
    z : out STD_LOGIC
  );
  end component GCD_block_design_delay_element_0_0;
  component GCD_block_design_delay_element_1_0 is
  port (
    d : in STD_LOGIC;
    z : out STD_LOGIC
  );
  end component GCD_block_design_delay_element_1_0;
  signal AB_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Mux_0_c_ctrl_out_ack : STD_LOGIC;
  signal Mux_0_c_ctrl_out_req : STD_LOGIC;
  signal Mux_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal a_minus_b_0_result : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal b_minus_a_0_result : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_0_ack_out : STD_LOGIC;
  signal click_element_0_ctrl_out_ack : STD_LOGIC;
  signal click_element_0_ctrl_out_req : STD_LOGIC;
  signal click_element_0_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_1_ctrl_out_ack : STD_LOGIC;
  signal click_element_1_ctrl_out_req : STD_LOGIC;
  signal click_element_1_data_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal delay_element_0_z : STD_LOGIC;
  signal delay_element_1_z : STD_LOGIC;
  signal demux_0_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_0_b_req_out : STD_LOGIC;
  signal demux_0_c_ctrl_out_ack : STD_LOGIC;
  signal demux_0_c_ctrl_out_req : STD_LOGIC;
  signal demux_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_1_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_1_b_req_out : STD_LOGIC;
  signal demux_1_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_1_c_req_out : STD_LOGIC;
  signal fork_stage_0_b_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_0_b_ctrl_out_req : STD_LOGIC;
  signal fork_stage_0_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_stage_0_c_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_0_c_ctrl_out_req : STD_LOGIC;
  signal fork_stage_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_stage_1_b_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_1_b_ctrl_out_req : STD_LOGIC;
  signal fork_stage_1_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_stage_1_c_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_1_c_ctrl_out_req : STD_LOGIC;
  signal fork_stage_1_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal gate_0_ctrl_out_ack : STD_LOGIC;
  signal gate_0_ctrl_out_req : STD_LOGIC;
  signal go_1 : STD_LOGIC;
  signal inverter_0_ctrl_out_ack : STD_LOGIC;
  signal inverter_0_ctrl_out_req : STD_LOGIC;
  signal merge_0_a_ack_out : STD_LOGIC;
  signal merge_0_b_ack_out : STD_LOGIC;
  signal merge_0_c_ctrl_out_ack : STD_LOGIC;
  signal merge_0_c_ctrl_out_req : STD_LOGIC;
  signal merge_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal rst_1 : STD_LOGIC;
  signal sel_a_larger_b_0_sel_ctrl_out_ack : STD_LOGIC;
  signal sel_a_larger_b_0_sel_ctrl_out_req : STD_LOGIC;
  signal sel_a_larger_b_0_selector : STD_LOGIC;
  signal sel_a_not_b_fork_0_ctrl_sel_b_out_ack : STD_LOGIC;
  signal sel_a_not_b_fork_0_ctrl_sel_b_out_req : STD_LOGIC;
  signal sel_a_not_b_fork_0_ctrl_sel_c_out_ack : STD_LOGIC;
  signal sel_a_not_b_fork_0_ctrl_sel_c_out_req : STD_LOGIC;
  signal sel_a_not_b_fork_0_selector : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  AB_1(31 downto 0) <= AB(31 downto 0);
  RESULT(31 downto 0) <= demux_0_b_data_out(31 downto 0);
  go_1 <= go;
  rst_1 <= rst;
Mux_0: component GCD_block_design_Mux_0_0
     port map (
      a_ack_out => gate_0_ctrl_out_ack,
      a_data_in(31 downto 0) => click_element_0_data_out(31 downto 0),
      a_req_in => gate_0_ctrl_out_req,
      b_ack_out => merge_0_c_ctrl_out_ack,
      b_data_in(31 downto 0) => merge_0_c_data_out(31 downto 0),
      b_req_in => merge_0_c_ctrl_out_req,
      c_ack_in => Mux_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => Mux_0_c_data_out(31 downto 0),
      c_req_out => Mux_0_c_ctrl_out_req,
      reset => rst_1,
      sel_ack_out => click_element_1_ctrl_out_ack,
      sel_req_in => click_element_1_ctrl_out_req,
      selector(0) => click_element_1_data_out(0)
    );
a_minus_b_0: component GCD_block_design_a_minus_b_0_0
     port map (
      ab(31 downto 0) => demux_1_b_data_out(31 downto 0),
      result(31 downto 0) => a_minus_b_0_result(31 downto 0)
    );
b_minus_a_0: component GCD_block_design_b_minus_a_0_0
     port map (
      ab(31 downto 0) => demux_1_c_data_out(31 downto 0),
      result(31 downto 0) => b_minus_a_0_result(31 downto 0)
    );
click_element_0: component GCD_block_design_click_element_0_0
     port map (
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => click_element_0_ack_out,
      data_in(31 downto 0) => AB_1(31 downto 0),
      data_out(31 downto 0) => click_element_0_data_out(31 downto 0),
      req_in => click_element_0_ack_out,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
click_element_1: component GCD_block_design_click_element_1_0
     port map (
      ack_in => click_element_1_ctrl_out_ack,
      ack_out => inverter_0_ctrl_out_ack,
      data_in(0) => sel_a_not_b_fork_0_selector(0),
      data_out(0) => click_element_1_data_out(0),
      req_in => inverter_0_ctrl_out_req,
      req_out => click_element_1_ctrl_out_req,
      rst => rst_1
    );
delay_element_0: component GCD_block_design_delay_element_0_0
     port map (
      d => demux_1_c_req_out,
      z => delay_element_0_z
    );
delay_element_1: component GCD_block_design_delay_element_1_0
     port map (
      d => demux_1_b_req_out,
      z => delay_element_1_z
    );
demux_0: component GCD_block_design_demux_0_0
     port map (
      a_ack_out => fork_stage_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_stage_0_c_data_out(31 downto 0),
      a_req_in => fork_stage_0_c_ctrl_out_req,
      b_ack_in => demux_0_b_req_out,
      b_data_out(31 downto 0) => demux_0_b_data_out(31 downto 0),
      b_req_out => demux_0_b_req_out,
      c_ack_in => demux_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => demux_0_c_data_out(31 downto 0),
      c_req_out => demux_0_c_ctrl_out_req,
      reset => rst_1,
      sel_ack_out => sel_a_not_b_fork_0_ctrl_sel_c_out_ack,
      sel_req_in => sel_a_not_b_fork_0_ctrl_sel_c_out_req,
      selector => sel_a_not_b_fork_0_selector(0)
    );
demux_1: component GCD_block_design_demux_1_0
     port map (
      a_ack_out => fork_stage_1_c_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_stage_1_c_data_out(31 downto 0),
      a_req_in => fork_stage_1_c_ctrl_out_req,
      b_ack_in => merge_0_a_ack_out,
      b_data_out(31 downto 0) => demux_1_b_data_out(31 downto 0),
      b_req_out => demux_1_b_req_out,
      c_ack_in => merge_0_b_ack_out,
      c_data_out(31 downto 0) => demux_1_c_data_out(31 downto 0),
      c_req_out => demux_1_c_req_out,
      reset => rst_1,
      sel_ack_out => sel_a_larger_b_0_sel_ctrl_out_ack,
      sel_req_in => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
fork_stage_0: component GCD_block_design_fork_stage_0_0
     port map (
      a_ack_out => Mux_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => Mux_0_c_data_out(31 downto 0),
      a_req_in => Mux_0_c_ctrl_out_req,
      b_ack_in => fork_stage_0_b_ctrl_out_ack,
      b_data_out(31 downto 0) => fork_stage_0_b_data_out(31 downto 0),
      b_req_out => fork_stage_0_b_ctrl_out_req,
      c_ack_in => fork_stage_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => fork_stage_0_c_data_out(31 downto 0),
      c_req_out => fork_stage_0_c_ctrl_out_req,
      rst => rst_1
    );
fork_stage_1: component GCD_block_design_fork_stage_1_0
     port map (
      a_ack_out => demux_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => demux_0_c_data_out(31 downto 0),
      a_req_in => demux_0_c_ctrl_out_req,
      b_ack_in => fork_stage_1_b_ctrl_out_ack,
      b_data_out(31 downto 0) => fork_stage_1_b_data_out(31 downto 0),
      b_req_out => fork_stage_1_b_ctrl_out_req,
      c_ack_in => fork_stage_1_c_ctrl_out_ack,
      c_data_out(31 downto 0) => fork_stage_1_c_data_out(31 downto 0),
      c_req_out => fork_stage_1_c_ctrl_out_req,
      rst => rst_1
    );
gate_0: component GCD_block_design_gate_0_0
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => click_element_0_ctrl_out_ack,
      go => go_1,
      req_in => click_element_0_ctrl_out_req,
      req_out => gate_0_ctrl_out_req
    );
inverter_0: component GCD_block_design_inverter_0_0
     port map (
      ack_in => inverter_0_ctrl_out_ack,
      ack_out => sel_a_not_b_fork_0_ctrl_sel_b_out_ack,
      req_in => sel_a_not_b_fork_0_ctrl_sel_b_out_req,
      req_out => inverter_0_ctrl_out_req
    );
merge_0: component GCD_block_design_merge_0_0
     port map (
      a_ack_out => merge_0_a_ack_out,
      a_data_in(31 downto 0) => a_minus_b_0_result(31 downto 0),
      a_req_in => delay_element_1_z,
      b_ack_out => merge_0_b_ack_out,
      b_data_in(31 downto 0) => b_minus_a_0_result(31 downto 0),
      b_req_in => delay_element_0_z,
      c_ack_in => merge_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => merge_0_c_data_out(31 downto 0),
      c_req_out => merge_0_c_ctrl_out_req,
      rst => rst_1
    );
sel_a_larger_b_0: component GCD_block_design_sel_a_larger_b_0_0
     port map (
      ack_out => fork_stage_1_b_ctrl_out_ack,
      data_in(31 downto 0) => fork_stage_1_b_data_out(31 downto 0),
      req_in => fork_stage_1_b_ctrl_out_req,
      reset => rst_1,
      sel_ack_in => sel_a_larger_b_0_sel_ctrl_out_ack,
      sel_req_out => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
sel_a_not_b_fork_0: component GCD_block_design_sel_a_not_b_fork_0_0
     port map (
      a_ack_out => fork_stage_0_b_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_stage_0_b_data_out(31 downto 0),
      a_req_in => fork_stage_0_b_ctrl_out_req,
      reset => rst_1,
      sel_ack_b_in => sel_a_not_b_fork_0_ctrl_sel_b_out_ack,
      sel_ack_c_in => sel_a_not_b_fork_0_ctrl_sel_c_out_ack,
      sel_req_b_out => sel_a_not_b_fork_0_ctrl_sel_b_out_req,
      sel_req_c_out => sel_a_not_b_fork_0_ctrl_sel_c_out_req,
      selector(0) => sel_a_not_b_fork_0_selector(0)
    );
end STRUCTURE;
