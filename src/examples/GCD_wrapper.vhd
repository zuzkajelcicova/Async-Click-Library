--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Thu Jun 21 15:40:08 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use ieee.numeric_std.all;

entity GCD_wrapper is
  port (
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_ab : out STD_LOGIC;
    req_ab : in STD_LOGIC
  );
end GCD_wrapper;

architecture STRUCTURE of GCD_wrapper is

signal AB, res: std_logic_vector(32-1 downto 0);
signal A: std_logic_vector(15 downto 0):= std_logic_vector(to_unsigned(1234, 16));
signal B: std_logic_vector(15 downto 0):= std_logic_vector(to_unsigned(762, 16));
signal go, rst: std_logic;
signal A_result: std_logic_vector(15 downto 0);
signal B_result: std_logic_vector(15 downto 0);

  component GCD is
  port (
    AB : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rst : in STD_LOGIC;
    go : in STD_LOGIC
  );
  end component GCD;
begin
AB <= A & B;
A_result <= res(31 downto 16);
B_result <= res(15 downto 0);
RESULT<= res;
GCD_component: component GCD
     port map (
      AB(31 downto 0) => AB,
      RESULT(31 downto 0) => res,
      go => go,
      rst => rst
    );
    
    go <= '0', '1' after 200 ns;
    rst <= '1', '0' after 100 ns;
end STRUCTURE;
