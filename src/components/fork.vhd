----------------------------------------------------------------------------------
-- Fork
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity fork is
  generic ( 
    PHASE_INIT  : std_logic := '0');
  port(
   rst          : in std_logic;
   -- Input channel
   inA_req      : in std_logic;
   inA_ack      : out std_logic;
   -- Output channel 1
   outB_req     : out std_logic;
   outB_ack     : in std_logic;
   -- Output channel 2
   outC_req     : out std_logic;
   outC_ack     : in std_logic
  );
end fork;

architecture arch of fork is

  signal click: std_logic;
  signal phase: std_logic := PHASE_INIT;
  
  attribute dont_touch : string;
  attribute dont_touch of  phase : signal is "true";   
  attribute dont_touch of  click : signal is "true"; 

begin
  -- Control Path
  outB_req <= inA_req;
  outC_req <= inA_req;
  inA_ack <= phase;

  click <= (outC_ack and outB_ack and not(phase)) or (not(outC_ack) and not(outB_ack) and phase) after AND3_DELAY + OR2_DELAY; 

  clock_regs: process(click, rst)
  begin
    if rst = '1' then
      phase <= PHASE_INIT;
    else
      if rising_edge(click) then
        phase <= not phase after REG_CQ_DELAY;
      end if;
    end if;
  end process clock_regs;
    
end arch;