----------------------------------------------------------------------------------
-- Generic fork
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity asym_fork_stage is
 generic ( 
            DATA_WIDTH: natural := DATA_WIDTH;
            VALUE: natural := 0;
            PHASE_INIT_A : std_logic := '0';
            PHASE_INIT_B : std_logic := '0';
            PHASE_INIT_C : std_logic := '0');
  Port (
        rst : in std_logic;
        --Input channel
        ch_in_a_req: in std_logic;
        ch_in_a_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
        ch_in_a_ack: out std_logic;
        --Output channel 1
        ch_out_b_req: out std_logic;
        ch_out_b_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
        ch_out_b_ack: in std_logic;
        --Output channel 2
        ch_out_c_req: out std_logic;
        ch_out_c_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
        ch_out_c_ack: in std_logic );
end asym_fork_stage;

architecture Behavioral of asym_fork_stage is

signal click, r_neg_and_chan_c, r_neg_and_chan_b, click_2: std_logic;
signal phase_a: std_logic;
signal phase_b, phase_c, cond, r_pos_and_chan_c, b_chan_xnor, r_pos_and_chan_b, c_chan_xnor, a_chan_xnor, click_1: std_logic;
signal left, right: std_logic;
signal data_reg: std_logic_vector(DATA_WIDTH-1 downto 0);

attribute dont_touch : string;
attribute dont_touch of  phase_b, phase_a, phase_c : signal is "true";   
attribute dont_touch of  data_reg : signal is "true";  
attribute dont_touch of  click : signal is "true";


begin
    a_chan_xnor <= ch_in_a_req xor phase_a after XOR_DELAY + NOT1_DELAY;
    r_pos_and_chan_c <= ch_in_a_req and phase_c and ch_out_c_ack after AND3_DELAY;
    b_chan_xnor <= phase_b xnor ch_out_b_ack after XOR_DELAY + NOT1_DELAY;
    r_pos_and_chan_b <= ch_in_a_req and phase_b and ch_out_b_ack after AND3_DELAY;
    c_chan_xnor <= phase_c xnor ch_out_c_ack after XOR_DELAY + NOT1_DELAY;
    click_1 <= (r_pos_and_chan_c and b_chan_xnor) or (r_pos_and_chan_b and c_chan_xnor) after AND2_DELAY + OR2_DELAY;
    -------------------------------------------------------------
    r_neg_and_chan_c <= not(ch_in_a_req) and phase_c and ch_out_c_ack after AND3_DELAY;
    r_neg_and_chan_b <= not(ch_in_a_req) and phase_b and ch_out_b_ack after AND3_DELAY;
    click_2 <= (r_neg_and_chan_c and b_chan_xnor) or (r_neg_and_chan_b and c_chan_xnor) after AND2_DELAY + OR2_DELAY;
    -------------------------------------------------------
    
    click <= a_chan_xnor and b_chan_xnor and c_chan_xnor after AND3_DELAY;--(click_1 and a_chan_xnor) or (click_2 and a_chan_xnor) after OR2_DELAY;
    
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
                data_reg <= ch_in_a_data after REG_CQ_DELAY;
        end if;
    end process clock_regs;
    
    ch_in_a_ack <= phase_a;
    ch_out_b_req <= phase_b;
    ch_out_c_req <= phase_c;
    ch_out_b_data <= data_reg;
    ch_out_c_data <= data_reg;

end Behavioral;
