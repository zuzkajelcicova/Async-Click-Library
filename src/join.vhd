----------------------------------------------------------------------------------
-- Join
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity join is
  generic(
    PHASE_INIT  : std_logic := '0'
    );
  port (
    rst         : in std_logic;
    --UPSTREAM channels
    inA_req     : in std_logic;
    inA_ack     : out std_logic;
    inB_req     : in std_logic;
    inB_ack     : out std_logic;
    --DOWNSTREAM channel
    outC_req    : out std_logic;
    outC_ack    : in std_logic);
end join;

architecture Behavioral of join is

signal click, phase: std_logic;

attribute dont_touch : string;
attribute dont_touch of phase : signal is "true";
attribute dont_touch of  click : signal is "true";

begin                       

  inA_ack <= outC_ack;
  inB_ack <= outC_ack;
  
  click <= (inA_req and inB_req and not(phase)) or (not(inA_req) and not(inB_req) and phase) after AND3_DELAY + OR2_DELAY;
                  
  clock_regs: process(click, rst)
  begin
    if rst = '1' then
      phase <= PHASE_INIT;
    elsif rising_edge(click) then
      phase <= not(phase) after REG_CQ_DELAY;
    end if;
  end process;
  
  outC_req <= phase;

end Behavioral;