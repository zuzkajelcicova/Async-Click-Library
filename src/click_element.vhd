----------------------------------------------------------------------------------
-- Click element
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity click_element is
  generic ( 
    DATA_WIDTH: natural := DATA_WIDTH;
    VALUE     : natural := 0;
    PHASE_INIT: std_logic := '0');
  port (rst   : in std_logic;
    -- Input channel
    in_ack    : out std_logic;
    in_req    : in std_logic;
    in_data   : in std_logic_vector(DATA_WIDTH-1 downto 0);
    -- Output channel
    out_req   : out std_logic;
    out_data  : out std_logic_vector(DATA_WIDTH-1 downto 0);
    out_ack   : in std_logic);
end click_element;

architecture behavioral of click_element is

signal phase : std_logic;
signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0);
signal click : std_logic;

attribute dont_touch : string;
attribute dont_touch of  phase : signal is "true";   
attribute dont_touch of  data_sig : signal is "true";  
attribute dont_touch of  click : signal is "true";  

begin
out_req <= phase;
in_ack <= phase;
out_data <= data_sig;

click <= (not(in_req) and phase and out_ack) or (not(out_ack) and not(phase) and in_req) after AND3_DELAY + OR2_DELAY;

clock_regs: process(click, rst)
begin
  if rst = '1' then
    phase <= PHASE_INIT;
    data_sig <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
  elsif rising_edge(click) then
    phase <= not phase after REG_CQ_DELAY;
    data_sig <= in_data after REG_CQ_DELAY;
  end if;
end process;

end behavioral;