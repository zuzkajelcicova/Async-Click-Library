----------------------------------------------------------------------------------
-- A != B selector fork
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;


entity sel_a_not_b_fork is
    generic(
    DATA_WIDTH: natural := DATA_WIDTH;
    PHASE_INIT : std_logic := '0'
    );
port(
    rst: in  std_logic;
    -- Data
    ch_in_a_data : in  std_logic_vector(DATA_WIDTH -1 downto 0);
    ch_in_a_req : in  std_logic;
    ch_in_a_ack : out std_logic;

    -- Selector
    selector : out std_logic_vector(0 downto 0);
    sel_req_b_out : out std_logic;
    sel_ack_b_in : in  std_logic;
    
    sel_req_c_out : out std_logic;
    sel_ack_c_in: in std_logic
    );
end sel_a_not_b_fork;

architecture Behavioral of sel_a_not_b_fork is


	signal phase : std_logic;
	signal click : std_logic;
	
	signal a : std_logic_vector(DATA_WIDTH/2 -1 downto 0);
	signal b : std_logic_vector(DATA_WIDTH/2 -1 downto 0);
	signal data_sel, a_req_in_sig : std_logic;
	signal sel_ack_high, sel_ack_low : std_logic;

    attribute dont_touch : string;
    attribute dont_touch of  phase, click : signal is "true";
    attribute dont_touch of  a, b, data_sel, a_req_in_sig : signal is "true";
    
begin
        --data
        a <= ch_in_a_data(DATA_WIDTH - 1 downto DATA_WIDTH/2);
        b <= ch_in_a_data(DATA_WIDTH/2 -1 downto 0);
        
        --fork logic
        sel_ack_high <= sel_ack_b_in and sel_ack_c_in after AND2_DELAY;
        sel_ack_low <= not(sel_ack_b_in) and not(sel_ack_c_in) after AND2_DELAY;
        
        click <= (phase and sel_ack_low) or (not(phase) and sel_ack_high) after OR2_DELAY;
    
    DELAY_SEL_REQ: entity work.delay_element
        GENERIC MAP(
                    size => 18)
        PORT MAP   (d => ch_in_a_req,
                    z => a_req_in_sig);

	clock_regs : process(click, rst)
        begin
            if rst = '1' then
                phase <= PHASE_INIT;
            elsif rising_edge(click) then
                phase <= not phase after REG_CQ_DELAY;
            end if;
    end process clock_regs;
    
    sel : process(a, b)
        begin
            if a /= b then
               data_sel <= '0' after ADDER_DELAY;
            else
               data_sel <= '1' after ADDER_DELAY;               
            end if;
    end process sel;
	
	selector(0) <= data_sel;
	sel_req_b_out <= a_req_in_sig;
	sel_req_c_out <= a_req_in_sig;
	ch_in_a_ack <= phase;

end Behavioral;
