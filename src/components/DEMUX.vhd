----------------------------------------------------------------------------------
-- Demux
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity demux is
  generic(
    PHASE_INIT_A  : std_logic := '0';
    PHASE_INIT_B  : std_logic := '0';
    PHASE_INIT_C  : std_logic := '0'
  );
  port(
    rst           : in  std_logic;
    -- Input port
    inA_req       : in  std_logic;
    inA_data      : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack       : out std_logic;
    -- Select port 
    inSel_req     : in  std_logic;
    inSel_ack     : out std_logic;
    selector      : in std_logic;
    -- Output channel 1
    outB_req      : out std_logic;
    outB_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outB_ack      : in  std_logic;
    -- Output channel 2
    outC_req      : out std_logic;
    outC_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack      : in  std_logic
    );
end demux;

architecture Behavioral of demux is

  signal phase_a : std_logic;
  signal click_req, click_ack : std_logic;
  
  signal phase_b : std_logic;
  signal phase_c : std_logic;

begin
    
  -- Control Path   
  inSel_ack <= phase_a;
  inA_ack <= phase_a;
  outB_req <= phase_b;
  outB_data <= inA_data;
  outC_req <= phase_c;
  outC_data <= inA_data;
  
  -- Request FF clock function
  click_req <= (inSel_req and not(phase_a) and inA_req) or (not(inSel_req) and phase_a and not(inA_req)) after ANDOR3_DELAY + NOT1_DELAY;
  
  -- Acknowledge FF clock function
  click_ack <= (outB_ack xnor phase_b) and (outC_ack xnor phase_c) after AND2_DELAY + XOR_DELAY + NOT1_DELAY;

  req : process(click_req, rst)
    begin
      if rst = '1' then
        phase_b <= PHASE_INIT_B;
        phase_c <= PHASE_INIT_C;
      elsif rising_edge(click_req) then
        phase_b <= phase_b xor selector after REG_CQ_DELAY;
        phase_c <= phase_c xor not(selector) after REG_CQ_DELAY;
      end if;
    end process req;
    
  ack : process(click_ack, rst)
    begin
      if rst = '1' then
        phase_a <= PHASE_INIT_A;
      elsif rising_edge(click_ack) then
        phase_a <= not phase_a after REG_CQ_DELAY;
      end if;
    end process ack;
	
end Behavioral;
