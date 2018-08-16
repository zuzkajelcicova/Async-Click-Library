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


entity Fibonacci_vhdl is
  port (
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );

end Fibonacci_vhdl;

architecture STRUCTURE of Fibonacci_vhdl is
  component async_add is
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
  end component async_add;
  
  component click_element is
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
  
  component Fork is
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
  end component Fork;
  
  component gate is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component gate;
  

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
Fork_0: component Fork
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
Fork_1: component Fork
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
async_add_0: entity work.async_add
     generic map(
      PHASE_INIT => '1',
      DATA_WIDTH => 32,
      VALUE => 0)
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
click_element_0: component click_element
     port map (
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => Fork_1_c_ctrl_out_ack,
      data_in(31 downto 0) => async_add_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_0_data_out(31 downto 0),
      req_in => Fork_1_c_ctrl_out_req,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
click_element_1: entity work.click_element
     generic map(
      DATA_WIDTH_1 => 32,
      VALUE => 1,
      PHASE_INIT => '0')
     port map (
      ack_in => click_element_1_ctrl_out_ack,
      ack_out => click_element_0_ctrl_out_ack,
      data_in(31 downto 0) => click_element_0_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_1_data_out(31 downto 0),
      req_in => click_element_0_ctrl_out_req,
      req_out => click_element_1_ctrl_out_req,
      rst => rst_1
    );
click_element_2: component click_element
     port map (
      ack_in => click_element_2_ctrl_out_ack,
      ack_out => Fork_0_c_ctrl_out_ack,
      data_in(31 downto 0) => click_element_1_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_2_data_out(31 downto 0),
      req_in => Fork_0_c_ctrl_out_req,
      req_out => click_element_2_ctrl_out_req,
      rst => rst_1
    );
click_element_3: component click_element
     port map (
      ack_in => click_element_3_ctrl_out_ack,
      ack_out => click_element_2_ctrl_out_ack,
      data_in(31 downto 0) => click_element_2_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_3_data_out(31 downto 0),
      req_in => click_element_2_ctrl_out_req,
      req_out => click_element_3_ctrl_out_req,
      rst => rst_1
    );
click_element_4: component click_element
     port map (
      ack_in => click_element_4_req_out,
      ack_out => Fork_1_b_ctrl_out_ack,
      data_in(31 downto 0) => async_add_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_4_data_out(31 downto 0),
      req_in => Fork_1_b_ctrl_out_req,
      req_out => click_element_4_req_out,
      rst => rst_1
    );
gate_0: component gate
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => async_add_0_c_ctrl_out_ack,
      go => go_1,
      req_in => async_add_0_c_ctrl_out_req,
      req_out => gate_0_ctrl_out_req
    );
end STRUCTURE;
