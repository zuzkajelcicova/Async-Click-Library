----------------------------------------------------------------------------------
-- MUX
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity mux is
  --generic for initializing the phase registers
  generic(DATA_WIDTH      : natural := DATA_WIDTH;
     PHASE_INIT_C : std_logic := '0';
     PHASE_INIT_A   : std_logic := '0';
     PHASE_INIT_B   : std_logic := '0';
     PHASE_INIT_SEL : std_logic := '0');
  port(
    rst             : in  std_logic; -- rst line
    -- Input from channel 1
    inA_req         : in  std_logic;
    inA_data        : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack         : out std_logic;
    -- Input from channel 2
    inB_req         : in std_logic;
    inB_data        : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inB_ack         : out std_logic;
    -- Output port 
    outC_req        : out std_logic;
    outC_data       : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack        : in  std_logic;
    -- Select port
    inSel_req       : in std_logic;
    inSel_ack       : out std_logic;
    selector        : in std_logic_vector(0 downto 0)
	);
end mux;

architecture arch of mux is
  
  -- the registers
  signal phase_c, phase_sel, inSel_token : std_logic;
  -- register control
  signal phase_a : std_logic;
  signal phase_b : std_logic;
  -- Clock
  signal click_req, click_ack : std_logic;
  signal pulse : std_logic;
  -- control gates
  signal inA_token, inB_token : std_logic;
  signal selected_a, selected_b : std_logic;
  
  attribute dont_touch : string;
  attribute dont_touch of  phase_sel, phase_c, phase_a, phase_b : signal is "true";   
  attribute dont_touch of  click_req, click_ack : signal is "true";  

begin
  -- Control Path
  inSel_ack <= phase_sel;
  outC_req <= phase_c;
  outC_data <= inA_data when selector(0) = '1' else inB_data;
  inA_ack <= phase_a;
  inB_ack <= phase_b;
  
  --input state
  inA_token <= phase_a xor inA_req after XOR_DELAY;
  inB_token <= phase_b xor inB_req after XOR_DELAY;
  inSel_token <= phase_sel xor inSel_req after XOR_DELAY;
  
  --Selector triggered pulse
  click_req <= (inA_token and inSel_token and selector(0)) or (inB_token and inSel_token and not selector(0)) after AND2_DELAY + OR2_DELAY;
  
  --Output state
  click_ack <= phase_c xnor outC_ack after XOR_DELAY;
  
  req_regs : process(click_req, rst)
    begin
      if rst = '1' then
        phase_c <= PHASE_INIT_C;
      elsif rising_edge(click_req) then
        -- Click control register loops back to itself
        phase_c <= not phase_c after REG_CQ_DELAY;
      end if;
    end process;
    
  ack_regs : process(click_ack, rst)
    begin
      if rst = '1' then
        phase_a <= PHASE_INIT_A;
        phase_b <= PHASE_INIT_B;
        phase_sel <= PHASE_INIT_SEL;
      elsif rising_edge(click_ack) then
        phase_a <= phase_a xor selector(0) after REG_CQ_DELAY;
        phase_b <= phase_b xor not(selector(0)) after REG_CQ_DELAY;
        phase_sel <= inSel_req after REG_CQ_DELAY;
      end if;
    end process;

end arch;
