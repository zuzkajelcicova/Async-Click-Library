library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity b_minus_a is
  generic (
      DATA_WIDTH: natural := DATA_WIDTH
  );
  Port (
        ab: in std_logic_vector(DATA_WIDTH-1 downto 0);
        result: out std_logic_vector(DATA_WIDTH - 1 downto 0) );
end b_minus_a;

architecture Behavioral of b_minus_a is

signal a, b : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);
signal res : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);
signal zeros : std_logic_vector(DATA_WIDTH/2 - 1 downto 0):= (others => '0');

begin
    a <= ab(DATA_WIDTH - 1 downto DATA_WIDTH/2);
    b <= ab(DATA_WIDTH/2 - 1 downto 0);
    res <= b - a after ADDER_DELAY; 
    result <= a & res;       
end Behavioral;