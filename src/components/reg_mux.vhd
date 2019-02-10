----------------------------------------------------------------------------------
-- Register+MUX
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity reg_mux is
  --generic for initializing the phase registers
  generic(PHASE_INIT_C  : std_logic := '0';
   PHASE_INIT_A       : std_logic := '0';
   PHASE_INIT_B       : std_logic := '0');
  port(
    rst       : in  std_logic; -- rst line
    -- Input from channel 1
    inA_req   : in  std_logic;
    inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack   : out std_logic;
    -- Input from channel 2
    inB_req   : in std_logic;
    inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inB_ack   : out std_logic;
    -- Output port 
    outC_req  : out std_logic;
    outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack  : in  std_logic;
    -- Select port
    inSel_req : in std_logic;
    inSel_ack : out std_logic;
    selector  : in std_logic
  );
end reg_mux;

architecture arch of reg_mux is

  -- the registers
  signal phase_c, phase_a, phase_b : std_logic;
  signal data_reg, data_sig : std_logic_vector(DATA_WIDTH-1 downto 0);
  -- Clock
  signal click : std_logic;
  signal pulse : std_logic;
  -- control gates
  signal a_ready, b_ready : std_logic;
  signal selected_a, selected_b : std_logic;
  
  attribute dont_touch : string;
  attribute dont_touch of  phase_c, phase_a, phase_b, data_reg, pulse : signal is "true";   
  attribute dont_touch of  click : signal is "true";

begin
  -- Control Path
  inSel_ack <= phase_c;
  outC_req <= phase_c;
  outC_data <= data_reg;
  inA_ack <= phase_a;
  inB_ack <= phase_b;
  data_sig <= inA_data when selector = '1' else inB_data;
  
  --input state
  a_ready <= phase_a xor inA_req after XOR_DELAY;
  b_ready <= phase_b xor inB_req after XOR_DELAY;

  --Selector triggered pulse
  pulse <= (inSel_req and not(phase_c) and not(outC_ack)) or (not(inSel_req) and phase_c and outC_ack) after AND3_DELAY + OR2_DELAY;

  --check if selected
  selected_a <= a_ready and pulse after AND3_DELAY;
  selected_b <= b_ready and pulse after AND3_DELAY;

  --Generate clock tick
  click <= selected_a or selected_b after OR2_DELAY;

  reg : process(click, rst)
  begin
    if rst = '1' then
      phase_c <= PHASE_INIT_C;
      phase_a <= PHASE_INIT_A;
      phase_b <= PHASE_INIT_B;
      data_reg <= (others => '0');
    elsif rising_edge(click) then
      -- Click control register loops back to itself
      phase_c <= not phase_c after REG_CQ_DELAY;
      phase_a <= phase_a xor selector after REG_CQ_DELAY;
      phase_b <= phase_b xor not(selector) after REG_CQ_DELAY;
      data_reg <= data_sig;
    end if;
  end process;

end arch;
