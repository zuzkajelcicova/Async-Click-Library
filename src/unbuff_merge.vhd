----------------------------------------------------------------------------------
-- Merge
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity unbuff_merge is
generic(PHASE_INIT_C : std_logic := '0';
       PHASE_INIT_A: std_logic := '0';
       PHASE_INIT_B: std_logic := '0');
  Port (rst: in std_logic;
        --Input channel 1
        ch_in_a_req: in std_logic;
        ch_in_a_ack: out std_logic;
        ch_in_a_data: in std_logic_vector(32-1 downto 0);
        -- Input channel 2
        ch_in_b_req: in std_logic;
        ch_in_b_ack: out std_logic;
        ch_in_b_data: in std_logic_vector(32-1 downto 0);
        -- Output channel
        ch_out_c_req: out std_logic;
        ch_out_c_data: out std_logic_vector(32-1 downto 0);
        ch_out_c_ack: in std_logic
         );
end unbuff_merge;

architecture Behavioral of unbuff_merge is

signal a_sel, b_sel, c_ready : std_logic;
signal phase_a, phase_b, phase_c: std_logic;
signal click, click_del : std_logic;
signal data_reg : std_logic_vector(32-1 downto 0);

attribute dont_touch : string;
attribute dont_touch of  phase_c, phase_a, phase_b, a_sel, b_sel : signal is "true";   
attribute dont_touch of  click, click_del : signal is "true";  

begin
a_sel <= ch_in_a_req xor phase_a after XOR_DELAY;
b_sel <= ch_in_b_req xor phase_b after XOR_DELAY;
c_ready <= phase_c xnor ch_out_c_ack after XOR_DELAY;

delay: entity work.delay_element
    generic map(size => 3)--ADD_DELAY
    port map(d => click,
             z => click_del);

click <= a_sel or b_sel after OR2_DELAY;

	clock_req : process(click_del, rst)
    begin
        if rst = '1' then
            phase_c <= PHASE_INIT_C;
        elsif rising_edge(click_del) then
            phase_c <= not phase_c after REG_CQ_DELAY;
           
        end if;
    end process;
    
    
	clock_ack : process(c_ready, rst)
    begin
        if rst = '1' then
            phase_a <= PHASE_INIT_A;
            phase_b <= PHASE_INIT_B;
        elsif rising_edge(c_ready) then
            phase_a <= ch_in_a_req after REG_CQ_DELAY;
            phase_b <= ch_in_b_req after REG_CQ_DELAY;
        end if;
    end process;
    

    ch_out_c_data <= ch_in_a_data when a_sel = '1' else 
                     ch_in_b_data when b_sel = '1' else 
                     (others => '-');
    ch_out_c_req <= phase_c;
    ch_in_a_ack <= phase_a;
    ch_in_b_ack <= phase_b;

end Behavioral;
