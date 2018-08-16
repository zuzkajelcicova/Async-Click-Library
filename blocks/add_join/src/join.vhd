----------------------------------------------------------------------------------
-- Join
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity join is
  generic ( 
      PHASE_INIT : std_logic := '0');
    Port ( 
           rst: in std_logic;
           clk: out std_logic;
           -- Input channel 1
           a_req_in: in std_logic;
           a_ack_out: out std_logic;
           -- Input channel 2
           b_req_in: in std_logic;
           b_ack_out: out std_logic;
           -- Output channel 
           c_req_out: out std_logic;
           c_ack_in: in std_logic
           );
end join;

architecture Behavioral of join is

signal click: std_logic;
signal phase: std_logic := PHASE_INIT;

attribute dont_touch : string;
attribute dont_touch of  phase : signal is "true";   
attribute dont_touch of  click : signal is "true";  

begin

click <= (a_req_in xor c_ack_in) and (b_req_in xor c_ack_in) and (c_ack_in xor not(phase)) after AND3_DELAY + XOR_DELAY;
c_req_out <= phase;
a_ack_out <= phase;
b_ack_out <= phase;
clk <= click;

clock_regs: process(click, rst)
begin
    if rst = '1' then
        phase <= PHASE_INIT;
    elsif rising_edge(click) then
        phase <= not phase after REG_CQ_DELAY;
    end if;
end process;

end Behavioral;
