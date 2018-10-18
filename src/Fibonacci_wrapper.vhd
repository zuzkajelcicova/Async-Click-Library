--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Mon Sep 17 20:15:22 2018
--Host        : wehe-bot running 64-bit Debian GNU/Linux 9.5 (stretch)
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
    AB_RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
end Fibonacci_wrapper;

architecture STRUCTURE of Fibonacci_wrapper is
  component Fibonacci is
  port (
    go : in STD_LOGIC;
    rst : in STD_LOGIC;
    AB_RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Fibonacci;
begin
Fibonacci_i: component Fibonacci
     port map (
      AB_RESULT(31 downto 0) => AB_RESULT(31 downto 0),
      go => go,
      rst => rst
    );
end STRUCTURE;
