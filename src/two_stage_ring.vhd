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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity two_stage_ring is
  
end two_stage_ring;

architecture STRUCTURE of two_stage_ring is

  component gate is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component gate;

  component click_element is
  generic ( 
    DATA_WIDTH_1: natural := 32;
    PHASE_INIT : std_logic := '1');
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR;
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR;
    ack_in : in STD_LOGIC
  );
  end component click_element;
  
  component link_joint is
  generic ( 
    DATA_WIDTH_1: natural := 32;
    VALUE: natural := 0;
    PHASE_INIT_UP : std_logic := '1';
    PHASE_INIT_DOWN: std_logic := '0');
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR;
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR;
    ack_in : in STD_LOGIC
  );
  end component link_joint;
  
signal req1_2, req2_1, ack1_2, ack2_1, go, rst, req_gate, ack_gate: std_logic;
signal data1_2, data2_1, data_sig: std_logic_vector(31 downto 0);


begin

data2_1 <= data_sig + 2;

click_element_0: entity work.click_element
     generic map(
       DATA_WIDTH_1 => 32,
       PHASE_INIT => '1'
    )
     port map (
      ack_in => ack_gate,
      ack_out => ack2_1,
      data_in(31 downto 0) => data2_1,
      data_out(31 downto 0) => data1_2,
      req_in => req1_2,
      req_out => req2_1,
      rst => rst
    );
    
link_joint_1: entity work.link_joint
     generic map(
        DATA_WIDTH_1 => 32,
        VALUE => 1,
        PHASE_INIT_UP => '0',
        PHASE_INIT_DOWN => '1'
     )
     port map (
      ack_in => ack2_1,
      ack_out => ack1_2,
      data_in => data1_2,
      data_out => data_sig,
      req_in => req_gate,
      req_out => req1_2,
      rst => rst
    );
    
gate_0: entity work.gate
     port map (
      ack_in => ack1_2,
      ack_out => ack_gate,
      go => go,
      req_in => req2_1,
      req_out => req_gate
    );
    
    go <= '0', '1' after 200 ns;
    rst <= '1', '0' after 100 ns;
end STRUCTURE;
