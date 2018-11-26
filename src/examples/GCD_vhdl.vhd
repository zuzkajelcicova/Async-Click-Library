--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Jun 26 14:29:28 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target GCD.bd
--Design      : GCD
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.defs.all;

entity GCD is
  port (
    AB : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of GCD : entity is "GCD,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=GCD,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=14,numReposBlks=14,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of GCD : entity is "GCD.hwdef";
end GCD;

architecture STRUCTURE of GCD is
  component mux is
  port (
    rst : in STD_LOGIC;
    inA_req : in STD_LOGIC;
    inA_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inA_ack : out STD_LOGIC;
    inB_req : in STD_LOGIC;
    inB_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inB_ack : out STD_LOGIC;
    outC_req : out STD_LOGIC;
    outC_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outC_ack : in STD_LOGIC;
    inSel_req : in STD_LOGIC;
    inSel_ack : out STD_LOGIC;
    selector : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component mux;
  component gate is
  port (
    go : in STD_LOGIC;
    in_ack : out STD_LOGIC;
    in_req : in STD_LOGIC;
    out_ack : in STD_LOGIC;
    out_req : out STD_LOGIC
  );
  end component gate;
  component reg_fork is
  port (
    rst : in STD_LOGIC;
    inA_req : in STD_LOGIC;
    inA_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inA_ack : out STD_LOGIC;
    outB_req : out STD_LOGIC;
    outB_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outB_ack : in STD_LOGIC;
    outC_req : out STD_LOGIC;
    outC_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outC_ack : in STD_LOGIC
  );
  end component reg_fork;
  
  component sel_a_larger_b is
      port(
          rst: in  std_logic;
          in_data : in  std_logic_vector(31 downto 0);
          in_req : in  std_logic;
          in_ack : out std_logic;
          selector : out std_logic;
          ch_out_sel_req : out std_logic;
          ch_out_sel_ack : in  std_logic
          );
  end component sel_a_larger_b;
  
  component sel_a_not_b is
  port (
    rst : in STD_LOGIC;
    inA_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inA_req : in STD_LOGIC;
    inA_ack : out STD_LOGIC;
    selector : out STD_LOGIC_VECTOR ( 0 to 0 );
    sel_req_b_out : out STD_LOGIC;
    sel_ack_b_in : in STD_LOGIC;
    sel_req_c_out : out STD_LOGIC;
    sel_ack_c_in : in STD_LOGIC
  );
  end component sel_a_not_b;
  component demux is
  port (
    rst : in STD_LOGIC;
    inA_req : in STD_LOGIC;
    inA_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inA_ack : out STD_LOGIC;
    inSel_req : in STD_LOGIC;
    inSel_ack : out STD_LOGIC;
    selector : in STD_LOGIC;
    outB_req : out STD_LOGIC;
    outB_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outB_ack : in STD_LOGIC;
    outC_req : out STD_LOGIC;
    outC_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outC_ack : in STD_LOGIC
  );
  end component demux;
 
  component inverter is
  port (
    in_req : in STD_LOGIC;
    in_ack : out STD_LOGIC;
    out_req : out STD_LOGIC;
    out_ack : in STD_LOGIC
  );
  end component inverter;
  component click_element is
  generic ( 
    DATA_WIDTH_1: natural := 32;
    PHASE_INIT : std_logic := '0');
  port (
    rst : in STD_LOGIC;
    in_ack : out STD_LOGIC;
    in_req : in STD_LOGIC;
    in_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    out_req : out STD_LOGIC;
    out_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    out_ack : in STD_LOGIC
  );
  end component click_element;
  
  component merge is
  port (
    rst : in STD_LOGIC;
    inA_req : in STD_LOGIC;
    inA_ack : out STD_LOGIC;
    inA_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inB_req : in STD_LOGIC;
    inB_ack : out STD_LOGIC;
    inB_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    outC_req : out STD_LOGIC;
    outC_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outC_ack : in STD_LOGIC
  );
  end component merge;
  
  component a_minus_b is
  port (
    ab : in STD_LOGIC_VECTOR ( 31 downto 0 );
    result : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component a_minus_b;
  
  component b_minus_a is
  port (
    ab : in STD_LOGIC_VECTOR ( 31 downto 0 );
    result : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component b_minus_a;
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
  signal demux_0_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_0_b_req_out : STD_LOGIC;
  signal demux_0_c_ctrl_out_ack : STD_LOGIC;
  signal demux_0_c_ctrl_out_req : STD_LOGIC;
  signal demux_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_1_b_ctrl_out_ack : STD_LOGIC;
  signal demux_1_b_ctrl_out_req, demux_1_b_ctrl_out_req_del : STD_LOGIC;
  signal demux_1_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal demux_1_c_ctrl_out_ack : STD_LOGIC;
  signal demux_1_c_ctrl_out_req, demux_1_c_ctrl_out_req_del: STD_LOGIC;
  signal demux_1_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_top_0_b_ctrl_out_ack : STD_LOGIC;
  signal fork_top_0_b_ctrl_out_req : STD_LOGIC;
  signal fork_top_0_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_top_0_c_ctrl_out_ack : STD_LOGIC;
  signal fork_top_0_c_ctrl_out_req : STD_LOGIC;
  signal fork_top_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_top_1_b_ctrl_out_ack : STD_LOGIC;
  signal fork_top_1_b_ctrl_out_req : STD_LOGIC;
  signal fork_top_1_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_top_1_c_ctrl_out_ack : STD_LOGIC;
  signal fork_top_1_c_ctrl_out_req : STD_LOGIC;
  signal fork_top_1_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal gate_0_ctrl_out_ack : STD_LOGIC;
  signal gate_0_ctrl_out_req : STD_LOGIC;
  signal go_1 : STD_LOGIC;
  signal inverter_0_ctrl_out_ack : STD_LOGIC;
  signal inverter_0_ctrl_out_req : STD_LOGIC;
  signal merge_0_c_ctrl_out_ack : STD_LOGIC;
  signal merge_0_c_ctrl_out_req : STD_LOGIC;
  signal merge_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal rst_1 : STD_LOGIC;
  signal sel_a_larger_b_0_sel_ctrl_out_ack : STD_LOGIC;
  signal sel_a_larger_b_0_sel_ctrl_out_req : STD_LOGIC;
  signal sel_a_larger_b_0_selector : STD_LOGIC;
  signal sel_a_not_b_fork_0_sel_ctrl_b_out_ack : STD_LOGIC;
  signal sel_a_not_b_fork_0_sel_ctrl_b_out_req : STD_LOGIC;
  signal sel_a_not_b_fork_0_sel_ctrl_c_out_ack : STD_LOGIC;
  signal sel_a_not_b_fork_0_sel_ctrl_c_out_req : STD_LOGIC;
  signal sel_a_not_b_fork_0_selector : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of AB : signal is "xilinx.com:signal:data:1.0 DATA.AB DATA";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of AB : signal is "XIL_INTERFACENAME DATA.AB, LAYERED_METADATA undef";
begin
  AB_1(31 downto 0) <= AB(31 downto 0);
  RESULT(31 downto 0) <= demux_0_b_data_out(31 downto 0);
  go_1 <= go;
  rst_1 <= rst;
  
Mux_0: component mux
     port map (
      inA_ack => gate_0_ctrl_out_ack,
      inA_data(31 downto 0) => AB_1(31 downto 0),
      inA_req => gate_0_ctrl_out_req,
      inB_ack => merge_0_c_ctrl_out_ack,
      inB_data(31 downto 0) => merge_0_c_data_out(31 downto 0),
      inB_req => merge_0_c_ctrl_out_req,
      outC_ack => Mux_0_c_ctrl_out_ack,
      outC_data(31 downto 0) => Mux_0_c_data_out(31 downto 0),
      outC_req => Mux_0_c_ctrl_out_req,
      rst => rst_1,
      inSel_ack => click_element_1_ctrl_out_ack,
      inSel_req => click_element_1_ctrl_out_req,
      selector(0) => click_element_1_data_out(0)
    );
a_minus_b_0: component a_minus_b
     port map (
      ab(31 downto 0) => demux_1_b_data_out(31 downto 0),
      result(31 downto 0) => a_minus_b_0_result(31 downto 0)
    );
b_minus_a_0: component b_minus_a
     port map (
      ab(31 downto 0) => demux_1_c_data_out(31 downto 0),
      result(31 downto 0) => b_minus_a_0_result(31 downto 0)
    );
click_element_0: component click_element
     generic map(
       DATA_WIDTH_1 => 32,
       PHASE_INIT => '1'
    )
     port map (
      out_ack => click_element_0_ctrl_out_ack,
      in_ack => click_element_0_ack_out,
      in_data(31 downto 0) => click_element_0_data_out(31 downto 0),
      out_data(31 downto 0) => click_element_0_data_out(31 downto 0),
      in_req => '1',
      out_req => click_element_0_ctrl_out_req,
      rst => rst_1
    );
decoup_hand_1: entity work.decoupled_hs_reg
     generic map(
                 DATA_WIDTH_1=> 1,
                 VALUE => 1,
                 PHASE_INIT_UP => '0',
                 PHASE_INIT_DOWN => '1'
     )
     port map (
      out_ack => click_element_1_ctrl_out_ack,
      in_ack => sel_a_not_b_fork_0_sel_ctrl_b_out_ack,
      in_data => sel_a_not_b_fork_0_selector,
      out_data => click_element_1_data_out,
      in_req => sel_a_not_b_fork_0_sel_ctrl_b_out_req,
      out_req => click_element_1_ctrl_out_req,
      rst => rst_1
    );
demux_0: component demux
     port map (
      inA_ack => fork_top_0_c_ctrl_out_ack,
      inA_data(31 downto 0) => fork_top_0_c_data_out(31 downto 0),
      inA_req => fork_top_0_c_ctrl_out_req,
      outB_ack => demux_0_b_req_out,
      outB_data(31 downto 0) => demux_0_b_data_out(31 downto 0),
      outB_req => demux_0_b_req_out,
      outC_ack => demux_0_c_ctrl_out_ack,
      outC_data(31 downto 0) => demux_0_c_data_out(31 downto 0),
      outC_req => demux_0_c_ctrl_out_req,
      rst => rst_1,
      inSel_ack => sel_a_not_b_fork_0_sel_ctrl_c_out_ack,
      inSel_req => sel_a_not_b_fork_0_sel_ctrl_c_out_req,
      selector => sel_a_not_b_fork_0_selector(0)
    );
demux_1: component demux
     port map (
      inA_ack => fork_top_1_c_ctrl_out_ack,
      inA_data(31 downto 0) => fork_top_1_c_data_out(31 downto 0),
      inA_req => fork_top_1_c_ctrl_out_req,
      outB_ack => demux_1_b_ctrl_out_ack,
      outB_data(31 downto 0) => demux_1_b_data_out(31 downto 0),
      outB_req => demux_1_b_ctrl_out_req,
      outC_ack => demux_1_c_ctrl_out_ack,
      outC_data(31 downto 0) => demux_1_c_data_out(31 downto 0),
      outC_req => demux_1_c_ctrl_out_req,
      rst => rst_1,
      inSel_ack => sel_a_larger_b_0_sel_ctrl_out_ack,
      inSel_req => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
fork_top_0: entity work.reg_fork
     generic map(PHASE_INIT_A => '0',
            PHASE_INIT_B =>'0',
            PHASE_INIT_C => '0')
     port map (
      inA_ack => Mux_0_c_ctrl_out_ack,
      inA_data(31 downto 0) => Mux_0_c_data_out(31 downto 0),
      inA_req => Mux_0_c_ctrl_out_req,
      outB_ack => fork_top_0_b_ctrl_out_ack,
      outB_data(31 downto 0) => fork_top_0_b_data_out(31 downto 0),
      outB_req => fork_top_0_b_ctrl_out_req,
      outC_ack => fork_top_0_c_ctrl_out_ack,
      outC_data(31 downto 0) => fork_top_0_c_data_out(31 downto 0),
      outC_req => fork_top_0_c_ctrl_out_req,
      rst => rst_1
    );
fork_top_1: entity work.reg_fork
     generic map(PHASE_INIT_A => '0',
       PHASE_INIT_B =>'0',
       PHASE_INIT_C => '0')
     port map (
      inA_ack => demux_0_c_ctrl_out_ack,
      inA_data(31 downto 0) => demux_0_c_data_out(31 downto 0),
      inA_req => demux_0_c_ctrl_out_req,
      outB_ack => fork_top_1_b_ctrl_out_ack,
      outB_data(31 downto 0) => fork_top_1_b_data_out(31 downto 0),
      outB_req => fork_top_1_b_ctrl_out_req,
      outC_ack => fork_top_1_c_ctrl_out_ack,
      outC_data(31 downto 0) => fork_top_1_c_data_out(31 downto 0),
      outC_req => fork_top_1_c_ctrl_out_req,
      rst => rst_1
    );
gate_0: entity work.go
     generic map (
       req_init => '1')
     port map (
      out_ack => gate_0_ctrl_out_ack,
      in_ack => click_element_0_ctrl_out_ack,
      go => go_1,
      in_req => click_element_0_ctrl_out_req,
      out_req => gate_0_ctrl_out_req
    );
--inverter_0: component inverter
--     port map (
--      out_ack => inverter_0_ctrl_out_ack,
--      in_ack => sel_a_not_b_fork_0_sel_ctrl_b_out_ack,
--      in_req => sel_a_not_b_fork_0_sel_ctrl_b_out_req,
--      out_req => inverter_0_ctrl_out_req
--    );
merge_0: component merge
     port map (
      inA_ack => demux_1_b_ctrl_out_ack,
      inA_data(31 downto 0) => a_minus_b_0_result(31 downto 0),
      inA_req => demux_1_b_ctrl_out_req_del,
      inB_ack => demux_1_c_ctrl_out_ack,
      inB_data(31 downto 0) => b_minus_a_0_result(31 downto 0),
      inB_req => demux_1_c_ctrl_out_req_del,
      outC_ack => merge_0_c_ctrl_out_ack,
      outC_data(31 downto 0) => merge_0_c_data_out(31 downto 0),
      outC_req => merge_0_c_ctrl_out_req,
      rst => rst_1
    );
sel_a_larger_b_0: component sel_a_larger_b
     port map (
      in_ack => fork_top_1_b_ctrl_out_ack,
      in_data(31 downto 0) => fork_top_1_b_data_out(31 downto 0),
      in_req => fork_top_1_b_ctrl_out_req,
      rst => rst_1,
      ch_out_sel_ack => sel_a_larger_b_0_sel_ctrl_out_ack,
      ch_out_sel_req => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
sel_a_not_b_fork_0: component sel_a_not_b
     port map (
      inA_ack => fork_top_0_b_ctrl_out_ack,
      inA_data(31 downto 0) => fork_top_0_b_data_out(31 downto 0),
      inA_req => fork_top_0_b_ctrl_out_req,
      rst => rst_1,
      sel_ack_b_in => sel_a_not_b_fork_0_sel_ctrl_b_out_ack,
      sel_ack_c_in => sel_a_not_b_fork_0_sel_ctrl_c_out_ack,
      sel_req_b_out => sel_a_not_b_fork_0_sel_ctrl_b_out_req,
      sel_req_c_out => sel_a_not_b_fork_0_sel_ctrl_c_out_req,
      selector(0) => sel_a_not_b_fork_0_selector(0)
    );
    
delay_req_a_minus_b: entity work.delay_element
    generic map(size => 15)--ADD_DELAY
    port map(d => demux_1_b_ctrl_out_req,
             z => demux_1_b_ctrl_out_req_del);
    
delay_req_b_minus_a: entity work.delay_element
        generic map(size => 15)
        port map(d => demux_1_c_ctrl_out_req,
                 z => demux_1_c_ctrl_out_req_del);
    
end STRUCTURE;
