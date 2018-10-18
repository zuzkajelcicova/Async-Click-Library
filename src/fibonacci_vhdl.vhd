--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Mon Sep 17 20:15:22 2018
--Host        : wehe-bot running 64-bit Debian GNU/Linux 9.5 (stretch)
--Command     : generate_target Fibonacci.bd
--Design      : Fibonacci
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;


entity fib_vhdl is
  port (
    AB_RESULT : out STD_LOGIC_VECTOR ( 14 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC;
    o_req: out std_logic;
    i_ack: in std_logic
  );

end fib_vhdl;

architecture STRUCTURE of fib_vhdl is  
  
  signal add_block_0_c_data_out : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal asym_fork_stage_0_ctrl_b_ack : STD_LOGIC;
  signal asym_fork_stage_0_ctrl_b_data : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal asym_fork_stage_0_ctrl_b_req : STD_LOGIC;
  signal asym_fork_stage_0_data_out_c : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal asym_fork_stage_0_req_out_c : STD_LOGIC;
  signal asym_fork_stage_1_data_out_b : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal asym_fork_stage_1_data_out_c : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal asym_fork_stage_1_req_out_b : STD_LOGIC;
  signal asym_fork_stage_1_req_out_c : STD_LOGIC;
  signal click_element_0_ack_out : STD_LOGIC;
  signal click_element_0_ctrl_out_ack : STD_LOGIC;
  signal click_element_0_ctrl_out_data : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal click_element_0_ctrl_out_req : STD_LOGIC;
  signal delay_element_0_z : STD_LOGIC;
  signal gate_0_ack_out : STD_LOGIC;
  signal gate_0_ctrl_out_ack : STD_LOGIC;
  signal gate_0_ctrl_out_req : STD_LOGIC;
  signal go_1 : STD_LOGIC;
  signal join_0_b_ack_out : STD_LOGIC;
  signal join_0_c_req_out : STD_LOGIC;
  signal rst_1 : STD_LOGIC;
  signal req_out: std_logic;
  signal ack_in, clk_sig: std_logic;
 
  attribute dont_touch : string;
  attribute dont_touch of  add_block_0_c_data_out, asym_fork_stage_0_ctrl_b_ack, asym_fork_stage_0_ctrl_b_data : signal is "true";
  attribute dont_touch of  asym_fork_stage_0_ctrl_b_req, asym_fork_stage_0_data_out_c, asym_fork_stage_0_req_out_c : signal is "true";
  attribute dont_touch of  asym_fork_stage_1_data_out_b, asym_fork_stage_1_req_out_b : signal is "true";
  attribute dont_touch of  asym_fork_stage_1_data_out_c, asym_fork_stage_1_req_out_c : signal is "true";
  attribute dont_touch of  click_element_0_ack_out, click_element_0_ctrl_out_ack : signal is "true";
  attribute dont_touch of  click_element_0_ctrl_out_data, click_element_0_ctrl_out_req : signal is "true";
  attribute dont_touch of  delay_element_0_z, gate_0_ack_out : signal is "true";
  attribute dont_touch of  gate_0_ctrl_out_ack, gate_0_ctrl_out_req : signal is "true";
  attribute dont_touch of  go_1, join_0_b_ack_out : signal is "true";
  attribute dont_touch of  join_0_c_req_out, rst_1 : signal is "true";
  attribute dont_touch of  req_out, ack_in, clk_sig : signal is "true";
  
    
begin
  AB_RESULT(14 downto 0) <= asym_fork_stage_1_data_out_b(14 downto 0);
  go_1 <= go;
  rst_1 <= rst;
  o_req <= req_out;
  
add_block_0: entity work.add_block
     port map (
      a_data_in(14 downto 0) => asym_fork_stage_1_data_out_c(14 downto 0),
      b_data_in(14 downto 0) => asym_fork_stage_0_data_out_c(14 downto 0),
      c_data_out(14 downto 0) => add_block_0_c_data_out(14 downto 0)
    );
    
asym_fork_stage_0: entity work.asym_fork_stage
     generic map ( 
      VALUE => 1,
      PHASE_INIT_A => '0',
      PHASE_INIT_B => '0',
      PHASE_INIT_C =>'1')
     port map (
      ack_in_b => asym_fork_stage_0_ctrl_b_ack,
      ack_in_c => join_0_b_ack_out,
      ack_out_a => click_element_0_ctrl_out_ack,
      data_in_a(14 downto 0) => click_element_0_ctrl_out_data(14 downto 0),
      data_out_b(14 downto 0) => asym_fork_stage_0_ctrl_b_data(14 downto 0),
      data_out_c(14 downto 0) => asym_fork_stage_0_data_out_c(14 downto 0),
      req_in_a => click_element_0_ctrl_out_req,
      req_out_b => asym_fork_stage_0_ctrl_b_req,
      req_out_c => asym_fork_stage_0_req_out_c,
      rst => rst_1
    );
    
asym_fork_stage_1: entity work.asym_fork_stage
     generic map ( 
      VALUE => 1,
      PHASE_INIT_A => '1',
      PHASE_INIT_B => '1',
      PHASE_INIT_C =>'0')
     port map (
      ack_in_b => gate_0_ack_out,
      ack_in_c => ack_in,
      ack_out_a => asym_fork_stage_0_ctrl_b_ack,
      data_in_a(14 downto 0) => asym_fork_stage_0_ctrl_b_data(14 downto 0),
      data_out_b(14 downto 0) => asym_fork_stage_1_data_out_b(14 downto 0),
      data_out_c(14 downto 0) => asym_fork_stage_1_data_out_c(14 downto 0),
      req_in_a => asym_fork_stage_0_ctrl_b_req,
      req_out_b => asym_fork_stage_1_req_out_b,
      req_out_c => req_out,
      rst => rst_1
    );
    
click_element_0: entity work.click_element
     generic map ( 
      VALUE => 0,
      PHASE_INIT => '0')
     port map (
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => click_element_0_ack_out,
      data_in(14 downto 0) => add_block_0_c_data_out(14 downto 0),
      data_out(14 downto 0) => click_element_0_ctrl_out_data(14 downto 0),
      req_in => delay_element_0_z,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
    
delay_element_0: entity work.delay_element
    generic map(
      size => 16-- Delay  size
    )
     port map (
      d => join_0_c_req_out,
      z => delay_element_0_z
    );
    
gate_0: entity work.go
     generic map (req_init => '1')
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => gate_0_ack_out,
      go => go_1,
      req_in => asym_fork_stage_1_req_out_b,
      req_out => gate_0_ctrl_out_req
    );
    
join_0: entity work.join
     generic map(
      PHASE_INIT => '0'
     )
     port map (
      a_ack_out => gate_0_ctrl_out_ack,
      a_req_in => gate_0_ctrl_out_req,
      b_ack_out => join_0_b_ack_out,
      b_req_in => asym_fork_stage_0_req_out_c,
      c_ack_in => click_element_0_ack_out,
      c_req_out => join_0_c_req_out,
      rst => rst_1,
      clk_out => clk_sig
    );
    
counter_0: entity work.counter
      Port map(rst => rst_1,
            clk => clk_sig,
            ack_out => ack_in,
            switch_in => i_ack,
            req_in => req_out
       );
            
            
end STRUCTURE;