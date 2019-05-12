----------------------------------------------------------------------------------
-- Register+Forq
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity reg_fork is
  generic ( 
    DATA_WIDTH: natural := DATA_WIDTH;
    VALUE: natural := 0;
    PHASE_INIT_A : std_logic := '0';
    PHASE_INIT_B : std_logic := '0';
    PHASE_INIT_C : std_logic := '0');
  Port (
    rst : in std_logic;
    --Input channel
    inA_req     : in std_logic;
    inA_data    : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack     : out std_logic;
    --Output channel 1
    outB_req    : out std_logic;
    outB_data   : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outB_ack    : in std_logic;
    --Output channel 2
    outC_req    : out std_logic;
    outC_data   : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack    : in std_logic );
  end reg_fork;

architecture Behavioral of reg_fork is

signal click: std_logic;
signal phase_a: std_logic;
signal phase_b, phase_c, outB_bubble, outC_bubble, inA_token: std_logic;
signal data_reg: std_logic_vector(DATA_WIDTH-1 downto 0);

attribute dont_touch : string;
attribute dont_touch of  phase_b, phase_a, phase_c : signal is "true";   
attribute dont_touch of  data_reg : signal is "true";  
attribute dont_touch of  click : signal is "true";


begin
  inA_token <= inA_req xor phase_a after XOR_DELAY;
  outB_bubble <= phase_b xnor outB_ack after XOR_DELAY + NOT1_DELAY;
  outC_bubble <= phase_c xnor outC_ack after XOR_DELAY + NOT1_DELAY;
  -------------------------------------------------------

  click <= inA_token and outB_bubble and outC_bubble after AND3_DELAY;

  clock_regs: process(click, rst)
  begin
    if rst = '1' then
      phase_a <= PHASE_INIT_A;
      phase_b <= PHASE_INIT_B;
      phase_c <= PHASE_INIT_C;
      data_reg <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
    elsif rising_edge(click) then
      phase_a <= not phase_a after REG_CQ_DELAY;
      phase_b <= not phase_b after REG_CQ_DELAY;
      phase_c <= not phase_c after REG_CQ_DELAY;
      data_reg <= inA_data after REG_CQ_DELAY;
    end if;
  end process clock_regs;

  inA_ack <= phase_a;
  outB_req <= phase_b;
  outC_req <= phase_c;
  outB_data <= data_reg;
  outC_data <= data_reg;

end Behavioral;