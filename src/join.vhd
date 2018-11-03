----------------------------------------------------------------------------------
-- Join component
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.defs.all;

entity join is
  Generic(
          PHASE_INIT: std_logic := '0'
          );
  Port (
        rst: in std_logic;
        --UPSTREAM channels
        ch_in_a_req: in std_logic;
        ch_in_a_ack: out std_logic;
        ch_in_b_req: in std_logic;
        ch_in_b_ack: out std_logic;
        
        --DOWNSTREAM channel
        ch_out_c_req: out std_logic;
        ch_out_c_ack: in std_logic;
        clk_out: out std_logic );
end join;

architecture Behavioral of join is

signal click, phase: std_logic;
signal a_req_sig, b_req_sig: std_logic;

attribute dont_touch : string;
attribute dont_touch of phase : signal is "true";
attribute dont_touch of  click : signal is "true";
attribute dont_touch of  a_req_sig : signal is "true";
attribute dont_touch of  b_req_sig : signal is "true";

begin                       

ch_in_a_ack <= ch_out_c_ack;
ch_in_b_ack <= ch_out_c_ack;

click <= (ch_in_a_req and ch_in_b_req and not(phase)) or (not(ch_in_a_req) and not(ch_in_b_req) and phase) after AND3_DELAY + OR2_DELAY;
                
clock_regs: process(click, rst)
    begin
        if rst = '1' then
            phase <= PHASE_INIT;
        elsif rising_edge(click) then
            phase <= not(phase) after REG_CQ_DELAY;
        end if;
    end process;

ch_out_c_req <= phase;
clk_out <= click;

end Behavioral;
