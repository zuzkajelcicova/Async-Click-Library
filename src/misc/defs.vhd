library IEEE;
use IEEE.std_logic_1164.all;

package defs is
	constant DATA_WIDTH : Integer := 16;

	--Delay size
	constant ADD_DELAY : integer := 15;
	constant LUT_CHAIN_SIZE : integer := 10;
	constant AND2_DELAY : time := 2 ns; -- 2 input AND gate
	constant AND3_DELAY : time := 3 ns; -- 3 input AND gate
	constant NOT1_DELAY : time := 1 ns; -- 1 input NOT gate
	constant ANDOR3_DELAY : time := 4 ns; -- Complex AND_OR gate
	constant REG_CQ_DELAY : time := 1 ns; -- Clk to Q delay
	constant ADDER_DELAY : time := 15 ns; -- Adder delay
	
	constant OR2_DELAY  : time := 2 ns; -- 2 input OR gate
	constant XOR_DELAY	  : time := 3 ns; --2 input XOR gate

end package;
