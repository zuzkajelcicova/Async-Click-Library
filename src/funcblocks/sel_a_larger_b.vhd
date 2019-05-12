----------------------------------------------------------------------------------
-- (A > B)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity sel_a_larger_b is
  generic(
    DATA_WIDTH    : natural := DATA_WIDTH
  );
  port(
    -- Data
    in_data       : in  std_logic_vector(DATA_WIDTH -1 downto 0);
    in_req        : in  std_logic;
    in_ack        : out std_logic;
    -- Selector
    selector      : out std_logic;
    out_req       : out std_logic;
    out_ack       : in  std_logic
      );
end sel_a_larger_b;

architecture Behavioral of sel_a_larger_b is
    
    signal a : std_logic_vector(DATA_WIDTH/2 -1 downto 0);
    signal b : std_logic_vector(DATA_WIDTH/2 -1 downto 0);

  attribute dont_touch : string;
  attribute dont_touch of  a, b: signal is "true";
    
begin

  a <= in_data(DATA_WIDTH - 1 downto DATA_WIDTH/2);
  b <= in_data(DATA_WIDTH/2 -1 downto 0);
    
  delay_req: entity work.delay_element
    generic map(
      size => ADD_DELAY)
    port map(d => in_req,
      z => out_req);

  in_ack <= out_ack;
  selector <= '1' when a > b else '0';
    
end Behavioral;