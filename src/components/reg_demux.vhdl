----------------------------------------------------------------------------------
-- Register+Demux
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity reg_demux is
  generic(
    PHASE_INIT    : std_logic := '0';
    PHASE_INIT_B  : std_logic := '0';
    PHASE_INIT_C  : std_logic := '0'
	);
  port(
    rst           : in std_logic;
    -- Input port
    inA_req       : in std_logic;
    inA_data      : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack       : out std_logic;
    -- Select port 
    inSel_req     : in std_logic;
    inSel_ack     : out std_logic;
    selector      : in std_logic;
    -- Output channel 1
    outB_req      : out std_logic;
    outB_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outB_ack      : in std_logic;
    -- Output channel 2
    outC_req      : out std_logic;
    outC_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack      : in std_logic
    );
end reg_demux;

architecture Behavioral of reg_demux is

  signal phase, phase_b, phase_c : std_logic;
  signal click, in_token, outB_bubble, outC_bubble : std_logic;
  signal data_reg : std_logic_vector(DATA_WIDTH-1 downto 0);
  signal b_selected, c_selected : std_logic;

begin  
  -- Control Path   
  inSel_ack <= phase;
  inA_ack <= phase;
  outB_req <= phase_b;
  outB_data <= data_reg;
  outC_req <= phase_c;
  outC_data <= data_reg;
  
  -- Selector trigger
  in_token <= (inSel_req and not(phase) and inA_req) or (not(inSel_req) and phase and not(inA_req)) after ANDOR3_DELAY + NOT1_DELAY;

  outB_bubble <= phase_b xnor outB_ack after XOR_DELAY + NOT1_DELAY;
  outC_bubble <= phase_c xnor outC_ack after XOR_DELAY + NOT1_DELAY;
  
  -- Select an option
  b_selected <= outB_bubble and in_token and selector after AND3_DELAY;
  c_selected <= outC_bubble and in_token and not(selector) after AND3_DELAY;
  
  click <= b_selected or c_selected after OR2_DELAY;

  clock_regs : process(click, rst)
    begin
      if rst = '1' then
        phase <= PHASE_INIT;
        phase_b <= PHASE_INIT_B;
        phase_c <= PHASE_INIT_C;
        data_reg <= (others => '0');
      elsif rising_edge(click) then
        phase <= not phase after REG_CQ_DELAY;
        phase_b <= phase_b xor selector after REG_CQ_DELAY;
        phase_c <= phase_c xor not(selector) after REG_CQ_DELAY;
        data_reg <= inA_data after REG_CQ_DELAY;
      end if;
    end process clock_regs;
	
end Behavioral;
