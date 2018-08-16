----------------------------------------------------------------------------------
-- Merge
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity merge is
generic(PHASE_INIT : std_logic := '0';
       PHASE_INIT_A: std_logic := '0';
       PHASE_INIT_B: std_logic := '0');
  Port (rst: in std_logic;
        --Input channel 1
        a_req_in: in std_logic;
        a_ack_out: out std_logic;
        a_data_in: in std_logic_vector(32-1 downto 0);
        -- Input channel 2
        b_req_in: in std_logic;
        b_ack_out: out std_logic;
        b_data_in: in std_logic_vector(32-1 downto 0);
        -- Output channel
        c_req_out: out std_logic;
        c_data_out: out std_logic_vector(32-1 downto 0);
        c_ack_in: in std_logic
         );
end merge;

architecture Behavioral of merge is

signal a_sel, b_sel, c_ready : std_logic;
signal phase_a, phase_b, phase: std_logic;
signal click : std_logic;
signal data_reg : std_logic_vector(32-1 downto 0);

attribute dont_touch : string;
attribute dont_touch of  phase, phase_a, phase_b, data_reg, a_sel, b_sel : signal is "true";   
attribute dont_touch of  click : signal is "true";  

begin
a_sel <= a_req_in xor phase_a after XOR_DELAY;
b_sel <= b_req_in xor phase_b after XOR_DELAY;
c_ready <= phase xnor c_ack_in after XOR_DELAY;

click <= (a_sel and c_ready) or (b_sel and c_ready) after AND2_DELAY + OR2_DELAY;

	clock_reg : process(click, rst)
    begin
        if rst = '1' then
            phase <= PHASE_INIT;
            phase_a <= PHASE_INIT_A;
            phase_b <= PHASE_INIT_B;
            data_reg <= (others => '0');
        elsif rising_edge(click) then
            if a_sel = '1' then
               data_reg <= a_data_in after REG_CQ_DELAY;
            elsif(b_sel = '1') then
               data_reg <= b_data_in after REG_CQ_DELAY;
            end if;
            -- Phase control registers
            phase <= not phase after REG_CQ_DELAY;
            phase_a <= phase_a xor a_sel after REG_CQ_DELAY;
            phase_b <= phase_b xor b_sel after REG_CQ_DELAY;
           
        end if;
    end process;
    

    c_data_out <= data_reg;
    c_req_out <= phase;
    a_ack_out <= phase_a;
    b_ack_out <= phase_b;

end Behavioral;
