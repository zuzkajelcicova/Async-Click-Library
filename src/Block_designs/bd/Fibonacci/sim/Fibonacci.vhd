--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Jul 31 08:24:08 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target Fibonacci.bd
--Design      : Fibonacci
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Fibonacci is
  port (
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of Fibonacci : entity is "Fibonacci,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Fibonacci,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=9,numReposBlks=9,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of Fibonacci : entity is "Fibonacci.hwdef";
end Fibonacci;

architecture STRUCTURE of Fibonacci is
  component Fibonacci_async_add_0_0 is
  port (
    rst : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_in : in STD_LOGIC;
    b_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_out : out STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component Fibonacci_async_add_0_0;
  component Fibonacci_click_element_0_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component Fibonacci_click_element_0_0;
  component Fibonacci_click_element_1_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component Fibonacci_click_element_1_0;
  component Fibonacci_click_element_2_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component Fibonacci_click_element_2_0;
  component Fibonacci_click_element_3_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component Fibonacci_click_element_3_0;
  component Fibonacci_Fork_0_0 is
  port (
    rst : in STD_LOGIC;
    clk : out STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_ack_out : out STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_ack_in : in STD_LOGIC
  );
  end component Fibonacci_Fork_0_0;
  component Fibonacci_Fork_1_0 is
  port (
    rst : in STD_LOGIC;
    clk : out STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_ack_out : out STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_ack_in : in STD_LOGIC
  );
  end component Fibonacci_Fork_1_0;
  component Fibonacci_gate_0_0 is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component Fibonacci_gate_0_0;
  component Fibonacci_click_element_4_0 is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component Fibonacci_click_element_4_0;
  signal Fork_0_b_ctrl_out_ack : STD_LOGIC;
  signal Fork_0_b_ctrl_out_req : STD_LOGIC;
  signal Fork_0_c_ctrl_out_ack : STD_LOGIC;
  signal Fork_0_c_ctrl_out_req : STD_LOGIC;
  signal Fork_1_b_ctrl_out_ack : STD_LOGIC;
  signal Fork_1_b_ctrl_out_req : STD_LOGIC;
  signal Fork_1_c_ctrl_out_ack : STD_LOGIC;
  signal Fork_1_c_ctrl_out_req : STD_LOGIC;
  signal async_add_0_c_ctrl_out_ack : STD_LOGIC;
  signal async_add_0_c_ctrl_out_req : STD_LOGIC;
  signal async_add_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_0_ctrl_out_ack : STD_LOGIC;
  signal click_element_0_ctrl_out_req : STD_LOGIC;
  signal click_element_0_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_1_ctrl_out_ack : STD_LOGIC;
  signal click_element_1_ctrl_out_req : STD_LOGIC;
  signal click_element_1_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_2_ctrl_out_ack : STD_LOGIC;
  signal click_element_2_ctrl_out_req : STD_LOGIC;
  signal click_element_2_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_3_ctrl_out_ack : STD_LOGIC;
  signal click_element_3_ctrl_out_req : STD_LOGIC;
  signal click_element_3_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_4_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_4_req_out : STD_LOGIC;
  signal gate_0_ctrl_out_ack : STD_LOGIC;
  signal gate_0_ctrl_out_req : STD_LOGIC;
  signal go_1 : STD_LOGIC;
  signal rst_1 : STD_LOGIC;
  signal NLW_Fork_0_clk_UNCONNECTED : STD_LOGIC;
  signal NLW_Fork_1_clk_UNCONNECTED : STD_LOGIC;
begin
  RESULT(31 downto 0) <= click_element_4_data_out(31 downto 0);
  go_1 <= go;
  rst_1 <= rst;
Fork_0: component Fibonacci_Fork_0_0
     port map (
      a_ack_out => click_element_1_ctrl_out_ack,
      a_req_in => click_element_1_ctrl_out_req,
      b_ack_in => Fork_0_b_ctrl_out_ack,
      b_req_out => Fork_0_b_ctrl_out_req,
      c_ack_in => Fork_0_c_ctrl_out_ack,
      c_req_out => Fork_0_c_ctrl_out_req,
      clk => NLW_Fork_0_clk_UNCONNECTED,
      rst => rst_1
    );
Fork_1: component Fibonacci_Fork_1_0
     port map (
      a_ack_out => gate_0_ctrl_out_ack,
      a_req_in => gate_0_ctrl_out_req,
      b_ack_in => Fork_1_b_ctrl_out_ack,
      b_req_out => Fork_1_b_ctrl_out_req,
      c_ack_in => Fork_1_c_ctrl_out_ack,
      c_req_out => Fork_1_c_ctrl_out_req,
      clk => NLW_Fork_1_clk_UNCONNECTED,
      rst => rst_1
    );
async_add_0: component Fibonacci_async_add_0_0
     port map (
      a_ack_out => click_element_3_ctrl_out_ack,
      a_data_in(31 downto 0) => click_element_3_data_out(31 downto 0),
      a_req_in => click_element_3_ctrl_out_req,
      b_ack_out => Fork_0_b_ctrl_out_ack,
      b_data_in(31 downto 0) => click_element_1_data_out(31 downto 0),
      b_req_in => Fork_0_b_ctrl_out_req,
      c_ack_in => async_add_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => async_add_0_c_data_out(31 downto 0),
      c_req_out => async_add_0_c_ctrl_out_req,
      rst => rst_1
    );
click_element_0: component Fibonacci_click_element_0_0
     port map (
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => Fork_1_c_ctrl_out_ack,
      data_in(31 downto 0) => async_add_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_0_data_out(31 downto 0),
      req_in => Fork_1_c_ctrl_out_req,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
click_element_1: component Fibonacci_click_element_1_0
     port map (
      ack_in => click_element_1_ctrl_out_ack,
      ack_out => click_element_0_ctrl_out_ack,
      data_in(31 downto 0) => click_element_0_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_1_data_out(31 downto 0),
      req_in => click_element_0_ctrl_out_req,
      req_out => click_element_1_ctrl_out_req,
      rst => rst_1
    );
click_element_2: component Fibonacci_click_element_2_0
     port map (
      ack_in => click_element_2_ctrl_out_ack,
      ack_out => Fork_0_c_ctrl_out_ack,
      data_in(31 downto 0) => click_element_1_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_2_data_out(31 downto 0),
      req_in => Fork_0_c_ctrl_out_req,
      req_out => click_element_2_ctrl_out_req,
      rst => rst_1
    );
click_element_3: component Fibonacci_click_element_3_0
     port map (
      ack_in => click_element_3_ctrl_out_ack,
      ack_out => click_element_2_ctrl_out_ack,
      data_in(31 downto 0) => click_element_2_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_3_data_out(31 downto 0),
      req_in => click_element_2_ctrl_out_req,
      req_out => click_element_3_ctrl_out_req,
      rst => rst_1
    );
click_element_4: component Fibonacci_click_element_4_0
     port map (
      ack_in => click_element_4_req_out,
      ack_out => Fork_1_b_ctrl_out_ack,
      data_in(31 downto 0) => async_add_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_4_data_out(31 downto 0),
      req_in => Fork_1_b_ctrl_out_req,
      req_out => click_element_4_req_out,
      rst => rst_1
    );
gate_0: component Fibonacci_gate_0_0
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => async_add_0_c_ctrl_out_ack,
      go => go_1,
      req_in => async_add_0_c_ctrl_out_req,
      req_out => gate_0_ctrl_out_req
    );
end STRUCTURE;
