----------------------------------------------------------------------------------
-- MUX
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity unbuff_mux is
	--generic for initializing the phase registers
	generic(PHASE_INIT_C : std_logic := '0';
	       PHASE_INIT_A: std_logic := '0';
	       PHASE_INIT_B: std_logic := '0';
	       PHASE_INIT_SEL: std_logic := '0');
	port(
        rst     : in  std_logic; -- rst line
		-- Input from channel 1
		ch_in_a_req : in  std_logic;
		ch_in_a_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_a_ack : out std_logic;

		-- Input from channel 2
		ch_in_b_req : in std_logic;
		ch_in_b_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_b_ack : out std_logic;

		-- Output port 
		ch_out_c_req : out std_logic;
		ch_out_c_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_c_ack : in  std_logic;
		
        -- Select port
        ch_in_sel_req : in std_logic;
        ch_in_sel_ack: out std_logic;
        selector: in std_logic_vector(0 downto 0)
	);
end unbuff_mux;

architecture arch of unbuff_mux is

	-- the registers
	signal phase_c, phase_sel, sel_token : std_logic;
	signal data_reg : word_t;
	-- register control
	signal phase_a : std_logic;
	signal phase_b : std_logic;
	-- Clock
	signal click_req, click_ack : std_logic;
	signal pulse : std_logic;
	-- control gates
	signal a_token, b_token : std_logic;
	signal selected_a, selected_b : std_logic;
	
	attribute dont_touch : string;
    attribute dont_touch of  phase_sel, phase_c, phase_a, phase_b : signal is "true";   
    attribute dont_touch of  click_req, click_ack : signal is "true";  

begin
	-- Control Path
	ch_in_sel_ack <= phase_sel;
	ch_out_c_req <= phase_c;
	ch_out_c_data <= ch_in_a_data when selector(0) = '1' else ch_in_b_data;
	ch_in_a_ack <= phase_a;
	ch_in_b_ack <= phase_b;
	
	--input state
	a_token <= phase_a xor ch_in_a_req after XOR_DELAY;
	b_token <= phase_b xor ch_in_b_req after XOR_DELAY;
	sel_token <= phase_sel xor ch_in_sel_req after XOR_DELAY;
	
	--Selector triggered pulse
    click_req <= (a_token and sel_token) or (b_token and sel_token) after AND2_DELAY + OR2_DELAY;
    
    --Output state
    click_ack <= phase_c xnor ch_out_c_ack after XOR_DELAY;
	
	req : process(click_req, rst)
    begin
        if rst = '1' then
            phase_c <= PHASE_INIT_C;
        elsif rising_edge(click_req) then
            -- Click control register loops back to itself
            phase_c <= not phase_c after REG_CQ_DELAY;
        end if;
    end process;
    
	ack : process(click_ack, rst)
    begin
        if rst = '1' then
            phase_a <= PHASE_INIT_A;
            phase_b <= PHASE_INIT_B;
            phase_sel <= PHASE_INIT_SEL;
        elsif rising_edge(click_ack) then
            phase_a <= phase_a xor selector(0) after REG_CQ_DELAY;
            phase_b <= phase_b xor not(selector(0)) after REG_CQ_DELAY;
            phase_sel <= ch_in_sel_req after REG_CQ_DELAY;
        end if;
    end process;


end arch;
