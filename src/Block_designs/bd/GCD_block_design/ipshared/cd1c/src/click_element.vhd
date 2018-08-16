----------------------------------------------------------------------------------
-- Click element
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity click_element is
  generic ( 
            DATA_WIDTH_1: natural := DATA_WIDTH;
            VALUE: natural := 0;
            PHASE_INIT : std_logic := '0');
  port (    rst : in std_logic;
            -- Input channel
            ack_out : out std_logic;
            req_in : in std_logic;
            data_in : in std_logic_vector(DATA_WIDTH_1-1 downto 0);
            -- Output channel
            req_out : out std_logic;
            data_out : out std_logic_vector(DATA_WIDTH_1-1 downto 0);
            ack_in : in std_logic);
end click_element;

architecture behavioral of click_element is

signal phase : std_logic;
signal data_sig: std_logic_vector(DATA_WIDTH_1-1 downto 0);
signal click : std_logic;

attribute dont_touch : string;
attribute dont_touch of  phase : signal is "true";   
attribute dont_touch of  data_sig : signal is "true";  
attribute dont_touch of  click : signal is "true";  

begin
req_out <= phase;
ack_out <= phase;
data_out <= data_sig;

clock_regs: process(click, rst)
begin
    if rst = '1' then
        phase <= PHASE_INIT;
        data_sig <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH_1));
    elsif rising_edge(click) then
        phase <= not phase after REG_CQ_DELAY;
        data_sig <= data_in after REG_CQ_DELAY;
    end if;
end process;

click <= (not(req_in) and phase and ack_in) or (not(ack_in) and not(phase) and req_in) after AND3_DELAY + OR2_DELAY;


end behavioral;