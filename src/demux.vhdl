----------------------------------------------------------------------------------
-- Demux
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity demux is
    generic(
        PHASE_INIT : std_logic := '0';
	    PHASE_INIT_B: std_logic := '0';
	    PHASE_INIT_C: std_logic := '0'
	    );
	port(
        reset: in  std_logic;
		-- Input port
		a_req_in : in  std_logic;
		a_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
		a_ack_out : out std_logic;

		-- Select port 
		sel_req_in : in  std_logic;
		sel_ack_out : out std_logic;
		selector: in std_logic;

		-- Output channel 1
		b_req_out : out std_logic;
		b_data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
		b_ack_in : in  std_logic;
		-- Output channel 2
		c_req_out : out std_logic;
		c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
		c_ack_in : in  std_logic
	    );
end demux;

architecture Behavioral of demux is

	signal phase : std_logic;
	signal click : std_logic;
	
	signal sel_ready : std_logic;
	signal data_reg : word_t;
	
	signal phase_b : std_logic;
	signal phase_c : std_logic;
	
	-- Choice 
	signal b_ready, b_selected : std_logic;
	signal c_ready, c_selected : std_logic;

begin
    
	-- Control Path   
    sel_ack_out <= phase;
    a_ack_out <= phase;
    b_req_out <= phase_b;
    b_data_out <= data_reg;
    c_req_out <= phase_c;
    c_data_out <= data_reg;
    
    -- Selector trigger
    sel_ready <= (sel_req_in and not(phase) and a_req_in) or (not(sel_req_in) and phase and not(a_req_in)) after ANDOR3_DELAY + NOT1_DELAY;
	
	b_ready <= phase_b xnor b_ack_in after XOR_DELAY + NOT1_DELAY;
    c_ready <= phase_c xnor c_ack_in after XOR_DELAY + NOT1_DELAY;
    
    -- Select an option
    b_selected <= b_ready and sel_ready and selector after AND3_DELAY;
    c_selected <= c_ready and sel_ready and not(selector) after AND3_DELAY;
    
    click <= b_selected or c_selected after OR2_DELAY;

	clock_regs : process(click, reset)
        begin
            if reset = '1' then
                phase <= PHASE_INIT;
                phase_b <= PHASE_INIT_B;
                phase_c <= PHASE_INIT_C;
                data_reg <= (others => '0');
            elsif rising_edge(click) then
                phase <= not phase after REG_CQ_DELAY;
                phase_b <= phase_b xor selector after REG_CQ_DELAY;
                phase_c <= phase_c xor not(selector) after REG_CQ_DELAY;
                data_reg <= a_data_in after REG_CQ_DELAY;
            end if;
    end process clock_regs;
	
end Behavioral;
