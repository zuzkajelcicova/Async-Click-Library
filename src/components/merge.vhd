----------------------------------------------------------------------------------
-- Merge
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity merge is
  generic(PHASE_INIT_C  : std_logic := '0';
    PHASE_INIT_A        : std_logic := '0';
    PHASE_INIT_B        : std_logic := '0');
  port (rst   : in std_logic;
    --Input channel 1
    inA_req   : in std_logic;
    inA_ack   : out std_logic;
    inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    -- Input channel 2
    inB_req   : in std_logic;
    inB_ack   : out std_logic;
    inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    -- Output channel
    outC_req  : out std_logic;
    outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack  : in std_logic
    );
end merge;

architecture Behavioral of merge is

  signal inA_token, inB_token, outC_bubble : std_logic;
  signal phase_a, phase_b, phase_c: std_logic;
  signal click : std_logic;
  signal data_reg, data_sig: std_logic_vector(DATA_WIDTH-1 downto 0);
  
  attribute dont_touch : string;
  attribute dont_touch of  phase_c, phase_a, phase_b, inA_token, inB_token : signal is "true";   
  attribute dont_touch of  click : signal is "true";  

begin
  inA_token <= inA_req xor phase_a after XOR_DELAY;
  inB_token <= inB_req xor phase_b after XOR_DELAY;
  outC_bubble <= phase_c xnor outC_ack after XOR_DELAY;
  -- Click function
  click <= inA_token or inB_token after OR2_DELAY;

  clock_req : process(click, rst)
    begin
      if rst = '1' then
        phase_c <= PHASE_INIT_C;
      elsif rising_edge(click) then
        phase_c <= not phase_c after REG_CQ_DELAY;
      end if;
    end process;
    
    
  clock_ack : process(outC_bubble, rst)
    begin
      if rst = '1' then
        phase_a <= PHASE_INIT_A;
        phase_b <= PHASE_INIT_B;
      elsif rising_edge(outC_bubble) then
        phase_a <= inA_req after REG_CQ_DELAY;
        phase_b <= inB_req after REG_CQ_DELAY;
      end if;
    end process;
    
  outC_data <= inA_data when inA_token = '1' else 
               inB_data when inB_token = '1' else 
               (others => '0');
  outC_req <= phase_c;
  inA_ack <= phase_a;
  inB_ack <= phase_b;

end Behavioral;
