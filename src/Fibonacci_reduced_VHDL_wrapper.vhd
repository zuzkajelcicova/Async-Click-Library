--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
-- Reduced Fibonacci circuit, VHDL wrapper
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Fibonacci_reduced_VHDL_wrapper is
 -- port (
 -- );
end Fibonacci_reduced_VHDL_wrapper;

architecture STRUCTURE of Fibonacci_reduced_VHDL_wrapper is

    signal go, rst: std_logic;
    signal res: std_logic_vector(31 downto 0);

  component Fibonacci_reduced_vhdl is
  port (
    go : in STD_LOGIC;
    rst : in STD_LOGIC;
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Fibonacci_reduced_vhdl;
begin
Fibonacci_reduced_vhdl_i: component Fibonacci_reduced_vhdl
     port map (
      RESULT(31 downto 0) => res,
      go => go,
      rst => rst
    );
    
    go <= '0', '1' after 200 ns;
    rst <= '1', '0' after 100 ns;
end STRUCTURE;
