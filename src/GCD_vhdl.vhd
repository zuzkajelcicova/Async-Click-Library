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
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
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
  end component mux;
  component gate is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component gate;
  component fork_top is
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
  end component fork_top;
  
  component sel_a_larger_b is
      port(
          reset: in  std_logic;
          data_in : in  std_logic_vector(31 downto 0);
          req_in : in  std_logic;
          ack_out : out std_logic;
          selector : out std_logic;
          sel_req_out : out std_logic;
          sel_ack_in : in  std_logic
          );
  end component sel_a_larger_b;
  
  component sel_a_not_b_fork is
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
  end component sel_a_not_b_fork;
  component demux is
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
  end component demux;
 
  component inverter is
  port (
    req_in : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_out : out STD_LOGIC;
    ack_in : in STD_LOGIC
  );
  end component inverter;
  component click_element is
  generic ( 
    DATA_WIDTH_1: natural := 32;
    PHASE_INIT : std_logic := '0');
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component click_element;
  
  component merge is
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
      a_ack_out => gate_0_ctrl_out_ack,
      a_data_in(31 downto 0) => AB_1(31 downto 0),
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
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => click_element_0_ack_out,
      data_in(31 downto 0) => click_element_0_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_0_data_out(31 downto 0),
      req_in => click_element_0_ack_out,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
click_element_1: entity work.click_element
     generic map(
        DATA_WIDTH_1 => 1,
        VALUE => 1,
        PHASE_INIT => '1'
     )
     port map (
      ack_in => click_element_1_ctrl_out_ack,
      ack_out => inverter_0_ctrl_out_ack,
      data_in => sel_a_not_b_fork_0_selector,
      data_out => click_element_1_data_out,
      req_in => inverter_0_ctrl_out_req,
      req_out => click_element_1_ctrl_out_req,
      rst => rst_1
    );
demux_0: component demux
     port map (
      a_ack_out => fork_top_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_top_0_c_data_out(31 downto 0),
      a_req_in => fork_top_0_c_ctrl_out_req,
      b_ack_in => demux_0_b_req_out,
      b_data_out(31 downto 0) => demux_0_b_data_out(31 downto 0),
      b_req_out => demux_0_b_req_out,
      c_ack_in => demux_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => demux_0_c_data_out(31 downto 0),
      c_req_out => demux_0_c_ctrl_out_req,
      reset => rst_1,
      sel_ack_out => sel_a_not_b_fork_0_sel_ctrl_c_out_ack,
      sel_req_in => sel_a_not_b_fork_0_sel_ctrl_c_out_req,
      selector => sel_a_not_b_fork_0_selector(0)
    );
demux_1: component demux
     port map (
      a_ack_out => fork_top_1_c_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_top_1_c_data_out(31 downto 0),
      a_req_in => fork_top_1_c_ctrl_out_req,
      b_ack_in => demux_1_b_ctrl_out_ack,
      b_data_out(31 downto 0) => demux_1_b_data_out(31 downto 0),
      b_req_out => demux_1_b_ctrl_out_req,
      c_ack_in => demux_1_c_ctrl_out_ack,
      c_data_out(31 downto 0) => demux_1_c_data_out(31 downto 0),
      c_req_out => demux_1_c_ctrl_out_req,
      reset => rst_1,
      sel_ack_out => sel_a_larger_b_0_sel_ctrl_out_ack,
      sel_req_in => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
fork_top_0: component fork_top
     port map (
      a_ack_out => Mux_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => Mux_0_c_data_out(31 downto 0),
      a_req_in => Mux_0_c_ctrl_out_req,
      b_ack_in => fork_top_0_b_ctrl_out_ack,
      b_data_out(31 downto 0) => fork_top_0_b_data_out(31 downto 0),
      b_req_out => fork_top_0_b_ctrl_out_req,
      c_ack_in => fork_top_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => fork_top_0_c_data_out(31 downto 0),
      c_req_out => fork_top_0_c_ctrl_out_req,
      rst => rst_1
    );
fork_top_1: component fork_top
     port map (
      a_ack_out => demux_0_c_ctrl_out_ack,
      a_data_in(31 downto 0) => demux_0_c_data_out(31 downto 0),
      a_req_in => demux_0_c_ctrl_out_req,
      b_ack_in => fork_top_1_b_ctrl_out_ack,
      b_data_out(31 downto 0) => fork_top_1_b_data_out(31 downto 0),
      b_req_out => fork_top_1_b_ctrl_out_req,
      c_ack_in => fork_top_1_c_ctrl_out_ack,
      c_data_out(31 downto 0) => fork_top_1_c_data_out(31 downto 0),
      c_req_out => fork_top_1_c_ctrl_out_req,
      rst => rst_1
    );
gate_0: component gate
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => click_element_0_ctrl_out_ack,
      go => go_1,
      req_in => click_element_0_ctrl_out_req,
      req_out => gate_0_ctrl_out_req
    );
inverter_0: component inverter
     port map (
      ack_in => inverter_0_ctrl_out_ack,
      ack_out => sel_a_not_b_fork_0_sel_ctrl_b_out_ack,
      req_in => sel_a_not_b_fork_0_sel_ctrl_b_out_req,
      req_out => inverter_0_ctrl_out_req
    );
merge_0: component merge
     port map (
      a_ack_out => demux_1_b_ctrl_out_ack,
      a_data_in(31 downto 0) => a_minus_b_0_result(31 downto 0),
      a_req_in => demux_1_b_ctrl_out_req_del,
      b_ack_out => demux_1_c_ctrl_out_ack,
      b_data_in(31 downto 0) => b_minus_a_0_result(31 downto 0),
      b_req_in => demux_1_c_ctrl_out_req_del,
      c_ack_in => merge_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => merge_0_c_data_out(31 downto 0),
      c_req_out => merge_0_c_ctrl_out_req,
      rst => rst_1
    );
sel_a_larger_b_0: component sel_a_larger_b
     port map (
      ack_out => fork_top_1_b_ctrl_out_ack,
      data_in(31 downto 0) => fork_top_1_b_data_out(31 downto 0),
      req_in => fork_top_1_b_ctrl_out_req,
      reset => rst_1,
      sel_ack_in => sel_a_larger_b_0_sel_ctrl_out_ack,
      sel_req_out => sel_a_larger_b_0_sel_ctrl_out_req,
      selector => sel_a_larger_b_0_selector
    );
sel_a_not_b_fork_0: component sel_a_not_b_fork
     port map (
      a_ack_out => fork_top_0_b_ctrl_out_ack,
      a_data_in(31 downto 0) => fork_top_0_b_data_out(31 downto 0),
      a_req_in => fork_top_0_b_ctrl_out_req,
      reset => rst_1,
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
