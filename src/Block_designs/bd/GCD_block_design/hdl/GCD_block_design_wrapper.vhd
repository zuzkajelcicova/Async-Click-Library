--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Mon Jul 30 12:41:39 2018
--Host        : DESKTOP-21BPEF6 running 64-bit major release  (build 9200)
--Command     : generate_target GCD_block_design_wrapper.bd
--Design      : GCD_block_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GCD_block_design_wrapper is
  port (
    AB : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
end GCD_block_design_wrapper;

architecture STRUCTURE of GCD_block_design_wrapper is
  component GCD_block_design is
  port (
    rst : in STD_LOGIC;
    go : in STD_LOGIC;
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    AB : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component GCD_block_design;
begin
GCD_block_design_i: component GCD_block_design
     port map (
      AB(31 downto 0) => AB(31 downto 0),
      RESULT(31 downto 0) => RESULT(31 downto 0),
      go => go,
      rst => rst
    );
end STRUCTURE;
