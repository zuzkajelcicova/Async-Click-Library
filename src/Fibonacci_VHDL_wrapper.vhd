--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Jul 31 08:12:00 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target Fibonacci_wrapper.bd
--Design      : Fibonacci_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Fibonacci_VHDL_wrapper is
 -- port (
 -- );
end Fibonacci_VHDL_wrapper;

architecture STRUCTURE of Fibonacci_VHDL_wrapper is

signal go, rst: std_logic;
signal res: std_logic_vector(31 downto 0);

  component Fibonacci_vhdl is
  port (
    rst : in STD_LOGIC;
    go : in STD_LOGIC;
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Fibonacci_vhdl;
begin
Fibonacci_i: component Fibonacci_vhdl
     port map (
      RESULT(31 downto 0) => res,
      go => go,
      rst => rst
    );
    
    go <= '0', '1' after 200 ns;
    rst <= '1', '0' after 100 ns;
end STRUCTURE;
