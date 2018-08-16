--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Jul 31 08:24:08 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target Fibonacci_wrapper.bd
--Design      : Fibonacci_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Fibonacci_wrapper is
  port (
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
end Fibonacci_wrapper;

architecture STRUCTURE of Fibonacci_wrapper is
  component Fibonacci is
  port (
    rst : in STD_LOGIC;
    go : in STD_LOGIC;
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Fibonacci;
begin
Fibonacci_i: component Fibonacci
     port map (
      RESULT(31 downto 0) => RESULT(31 downto 0),
      go => go,
      rst => rst
    );
end STRUCTURE;
