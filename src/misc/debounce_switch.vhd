library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity debounce_switch is
  port (
    clk    : in  std_logic;
    i_switch : in  std_logic;
    o_switch : out std_logic
    );
end entity debounce_switch;
 
architecture arch of debounce_switch is
  -- Set for 1,000,000 clock ticks of 100 MHz clock (10 ms)
  constant tick_no : integer := 1000000;
 
  signal count : integer range 0 to tick_no := 0;
  signal state : std_logic := '0';
 
begin
 
  debounce : process (clk) is
  begin
    if rising_edge(clk) then
      -- count 10 ms if states are different
      if (i_switch /= state and count < tick_no) then
        count <= count + 1;
      -- switch state after tick_no ticks (10 ms)
      elsif count = tick_no then
        state <= i_switch;
        count <= 0;
      -- keep counter at 0
      else
        count <= 0;
      end if;
    end if;
  end process debounce;
 
  o_switch <= state;
 
end architecture arch;