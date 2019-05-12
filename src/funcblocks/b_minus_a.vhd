----------------------------------------------------------------------------------
-- (B - A)
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity b_minus_a is
  generic (
    DATA_WIDTH: natural := DATA_WIDTH
  );
  port (-- Input channel
    in_req      : in std_logic;
    in_ack      : out std_logic;
    ab: in std_logic_vector(DATA_WIDTH - 1 downto 0);
    -- Output channel
    out_req     : out std_logic;
    out_ack     : in std_logic;
    result      : out std_logic_vector(DATA_WIDTH - 1 downto 0));
end b_minus_a;

architecture Behavioral of b_minus_a is

  signal a, b : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);
  signal res : std_logic_vector(DATA_WIDTH/2 - 1 downto 0);

begin
  in_ack <= out_ack;

  delay_req: entity work.delay_element
    generic map(
      size => ADD_DELAY-- Delay  size
    )
    port map (
      d => in_req,
      z => out_req
    );

  a <= ab(DATA_WIDTH - 1 downto DATA_WIDTH/2);
  b <= ab(DATA_WIDTH/2 - 1 downto 0);
  res <= b - a after ADDER_DELAY; 
  result <= a & res;

end Behavioral;