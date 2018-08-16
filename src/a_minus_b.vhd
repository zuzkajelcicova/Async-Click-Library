library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity a_minus_b is
  generic (
        DATA_WIDTH: natural := DATA_WIDTH
  );
  Port (
        ab: in std_logic_vector(DATA_WIDTH-1 downto 0);
        result: out std_logic_vector(DATA_WIDTH - 1 downto 0) );
end a_minus_b;

architecture Behavioral of a_minus_b is

signal a, b : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);
signal res : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);
signal zeros : std_logic_vector(DATA_WIDTH/2 - 1 downto 0):= (others => '0'); 

begin
    a <= ab(DATA_WIDTH - 1 downto DATA_WIDTH/2);
    b <= ab(DATA_WIDTH/2 - 1 downto 0);
    res <= a - b after ADDER_DELAY;   
    result <= res & b;           
end Behavioral;