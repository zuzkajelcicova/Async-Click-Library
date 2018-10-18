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
        a_req_in: in std_logic;
        a_ack_out: out std_logic;
        b_req_in: in std_logic;
        b_ack_out: out std_logic;
        
        --DOWNSTREAM channel
        c_req_out: out std_logic;
        c_ack_in: in std_logic;
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

a_ack_out <= c_ack_in;
b_ack_out <= c_ack_in;

click <= (a_req_in and b_req_in and not(phase)) or (not(a_req_in) and not(b_req_in) and phase) after AND3_DELAY + OR2_DELAY;
                
clock_regs: process(click, rst)
    begin
        if rst = '1' then
            phase <= PHASE_INIT;
        elsif rising_edge(click) then
            phase <= not(phase) after REG_CQ_DELAY;
        end if;
    end process;

c_req_out <= phase;
clk_out <= click;

end Behavioral;
