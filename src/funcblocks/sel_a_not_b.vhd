----------------------------------------------------------------------------------
-- A != B selector
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity sel_a_not_b is
  generic(
    DATA_WIDTH  : natural := DATA_WIDTH
    );
  port(
    -- Input channel
    in_data     : in  std_logic_vector(DATA_WIDTH -1 downto 0);
    in_req      : in  std_logic;
    in_ack      : out std_logic;
    -- Output channel
    selector    : out std_logic;
    out_req     : out std_logic;
    out_ack     : in  std_logic
    );
end sel_a_not_b;

architecture Behavioral of sel_a_not_b is
    
  signal a : std_logic_vector(DATA_WIDTH/2 -1 downto 0);
  signal b : std_logic_vector(DATA_WIDTH/2 -1 downto 0);

  attribute dont_touch : string;
  attribute dont_touch of  a, b : signal is "true";
    
begin
  a <= in_data(DATA_WIDTH - 1 downto DATA_WIDTH/2);
  b <= in_data(DATA_WIDTH/2 -1 downto 0);
    
  DELAY_REQ: entity work.delay_element
    generic map(
      size => ADD_DELAY+1)
    port map(d => in_req,
      z => out_req);

  selector <= '0' when a /= b else '1';
  in_ack <= out_ack;

end Behavioral;