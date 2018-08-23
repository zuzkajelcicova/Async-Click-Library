----------------------------------------------------------------------------------
-- Link_joint
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity link_joint is
  generic ( 
            DATA_WIDTH_1: natural := DATA_WIDTH;
            VALUE: natural := 0;
            PHASE_INIT_UP : std_logic := '0';
            PHASE_INIT_DOWN : std_logic := '0');
  port (    rst : in std_logic;
            -- Input channel
            ack_out : out std_logic;
            req_in : in std_logic;
            data_in : in std_logic_vector(DATA_WIDTH_1-1 downto 0);
            -- Output channel
            req_out : out std_logic;
            data_out : out std_logic_vector(DATA_WIDTH_1-1 downto 0);
            ack_in : in std_logic);
end link_joint;

architecture behavioral of link_joint is

signal phase_up, phase_down : std_logic;
signal data_sig: std_logic_vector(DATA_WIDTH_1-1 downto 0);
signal click : std_logic;

attribute dont_touch : string;
attribute dont_touch of  phase_up, phase_down : signal is "true";   
attribute dont_touch of  data_sig : signal is "true";  
attribute dont_touch of  click : signal is "true";  

begin
req_out <= phase_down;
ack_out <= phase_up;
data_out <= data_sig;

clock_regs: process(click, rst)
begin
    if rst = '1' then
        phase_up <= PHASE_INIT_UP;
        phase_down <= PHASE_INIT_DOWN;
        data_sig <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH_1));
    elsif rising_edge(click) then
        phase_up <= not phase_up after REG_CQ_DELAY;
        phase_down <= not phase_down after REG_CQ_DELAY;
        data_sig <= data_in after REG_CQ_DELAY;
    end if;
end process;

click <= (req_in xor phase_up) and not(ack_in xor phase_down) after AND2_DELAY + XOR_DELAY;


end behavioral;