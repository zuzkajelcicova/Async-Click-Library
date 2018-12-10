----------------------------------------------------------------------------------
-- Join+Register+Fork
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity join_reg_fork is
  generic ( 
    DATA_WIDTH: natural := DATA_WIDTH;
    VALUE: natural := 0;
    PHASE_INIT_A : std_logic := '0';
    PHASE_INIT_B : std_logic := '0';
    PHASE_INIT_C : std_logic := '0';
    PHASE_INIT_D : std_logic := '0');
  Port (
    rst : in std_logic;
    --Input channel 1 
    inA_req   : in std_logic;
    inA_data  : in std_logic_vector(DATA_WIDTH/2-1 downto 0);
    inA_ack   : out std_logic;
    --Input channel 2
    inB_req   : in std_logic;
    inB_data  : in std_logic_vector(DATA_WIDTH/2-1 downto 0);
    inB_ack   : out std_logic;
    --Output channel 1
    outC_req  : out std_logic;
    outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_ack  : in std_logic;
    --Output channel 2
    outD_req  : out std_logic;
    outD_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    outD_ack  : in std_logic );
  end join_reg_fork;
architecture arch of join_reg_fork is

signal click, bubble: std_logic;
signal outC_bubble, outD_bubble : std_logic;
signal inA_token, inB_token : std_logic;
signal phase_a, phase_b: std_logic;
signal phase_c, phase_d: std_logic;
signal data_reg: std_logic_vector(DATA_WIDTH-1 downto 0);
attribute dont_touch : string;
attribute dont_touch of phase_b, phase_a, phase_c, phase_d : signal is "true";   
attribute dont_touch of data_reg : signal is "true";  
attribute dont_touch of click, bubble : signal is "true";
begin
  inA_token <= inA_req xor phase_a after XOR_DELAY;
  inB_token <= inB_req xor phase_b after XOR_DELAY;
  outC_bubble <= phase_c xnor outC_ack after XOR_DELAY + NOT1_DELAY;
  outD_bubble <= phase_d xnor outD_ack after XOR_DELAY + NOT1_DELAY;
  
  bubble <= outC_bubble and outD_bubble after AND2_DELAY;
  click <= inA_token and inB_token and bubble after AND3_DELAY;

  clock_regs: process(click, rst)
  begin
    if rst = '1' then
      phase_a <= PHASE_INIT_A;
      phase_b <= PHASE_INIT_B;
      phase_c <= PHASE_INIT_C;
      phase_d <= PHASE_INIT_D;
      data_reg <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
    elsif rising_edge(click) then
      phase_a <= not phase_a after REG_CQ_DELAY;
      phase_b <= not phase_b after REG_CQ_DELAY;
      phase_c <= not phase_c after REG_CQ_DELAY;
      phase_d <= not phase_d after REG_CQ_DELAY;
      data_reg <= inA_data & inB_data after REG_CQ_DELAY;
    end if;
  end process clock_regs;

  inA_ack <= phase_a;
  inB_ack <= phase_b;
  outC_req <= phase_c;
  outD_req <= phase_d;
  outC_data <= data_reg;
  outD_data <= data_reg;

end arch;