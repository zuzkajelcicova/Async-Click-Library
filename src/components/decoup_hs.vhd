----------------------------------------------------------------------------------
-- Decoupled handshake register
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity decoupled_hs_reg is
  generic ( 
    DATA_WIDTH      : natural := DATA_WIDTH;
    VALUE           : natural  := 0;
    PHASE_INIT_IN   : std_logic := '0';
    PHASE_INIT_OUT  : std_logic := '0');
  port (rst         : in std_logic;
    -- Input channel
    in_ack          : out std_logic;
    in_req          : in std_logic;
    in_data         : in std_logic_vector(DATA_WIDTH-1 downto 0);
    -- Output channel
    out_req         : out std_logic;
    out_data        : out std_logic_vector(DATA_WIDTH-1 downto 0);
    out_ack         : in std_logic);
end decoupled_hs_reg;

architecture behavioral of decoupled_hs_reg is

  signal phase_in, phase_out : std_logic;
  signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0);
  signal click : std_logic;
  
  attribute dont_touch : string;
  attribute dont_touch of  phase_in, phase_out : signal is "true";   
  attribute dont_touch of  data_sig : signal is "true";  
  attribute dont_touch of  click : signal is "true";  

begin
  out_req <= phase_out;
  in_ack <= phase_in;
  out_data <= data_sig;
  
  clock_regs: process(click, rst)
  begin
    if rst = '1' then
      phase_in <= PHASE_INIT_IN;
      phase_out <= PHASE_INIT_OUT;
      data_sig <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
    elsif rising_edge(click) then
      phase_in <= not phase_in after REG_CQ_DELAY;
      phase_out <= not phase_out after REG_CQ_DELAY;
      data_sig <= in_data after REG_CQ_DELAY;
    end if;
  end process;
  
  click <= (in_req xor phase_in) and (out_ack xnor phase_out) after AND2_DELAY + XOR_DELAY;

end behavioral;