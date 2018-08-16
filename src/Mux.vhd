----------------------------------------------------------------------------------
-- MUX
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity Mux is
	--generic for initializing the phase registers
	generic(PHASE_INIT : std_logic := '0';
	       PHASE_INIT_A: std_logic := '0';
	       PHASE_INIT_B: std_logic := '0');
	port(
        reset     : in  std_logic; -- reset line
		-- Input from channel 1
		a_req_in : in  std_logic;
		a_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
		a_ack_out : out std_logic;

		-- Input from channel 2
		b_req_in : in std_logic;
		b_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
		b_ack_out : out std_logic;

		-- Output port 
		c_req_out : out std_logic;
		c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
		c_ack_in : in  std_logic;
		
        -- Select port
        sel_req_in : in std_logic;
        sel_ack_out: out std_logic;
        selector: in std_logic_vector(0 downto 0)
	);
end Mux;

architecture arch of Mux is

	-- the registers
	signal phase : std_logic;
	signal data_reg : word_t;
	-- register control
	signal phase_a : std_logic;
	signal phase_b : std_logic;
	-- Clock
	signal click : std_logic;
	signal pulse : std_logic;
	-- control gates
	signal a_ready, b_ready : std_logic;
	signal selected_a, selected_b : std_logic;
	
	attribute dont_touch : string;
    attribute dont_touch of  phase, phase_a, phase_b, data_reg, pulse : signal is "true";   
    attribute dont_touch of  click : signal is "true";  

begin
	-- Control Path
	sel_ack_out <= phase;
	c_req_out <= phase;
	c_data_out <= data_reg;
	a_ack_out <= phase_a;
	b_ack_out <= phase_b;
	
	--input state
	a_ready <= phase_a xor a_req_in after XOR_DELAY;
	b_ready <= phase_b xor b_req_in after XOR_DELAY;
	
	--Selector triggered pulse
    pulse <= (sel_req_in and not(phase) and not(c_ack_in)) or (not(sel_req_in) and phase and c_ack_in) after AND3_DELAY + OR2_DELAY;
	
	--check if selected
	selected_a <= selector(0) and a_ready and pulse after AND3_DELAY;
	selected_b <= not(selector(0)) and b_ready and pulse after AND3_DELAY;
	
	--Generate clock tick
	click <= selected_a or selected_b after OR2_DELAY;

	
	reg : process(click, reset)
    begin
        if reset = '1' then
            phase <= PHASE_INIT;
            phase_a <= PHASE_INIT_A;
            phase_b <= PHASE_INIT_B;
            data_reg <= (others => '0');
        elsif rising_edge(click) then
            -- Click control register loops back to itself
            phase <= not phase after REG_CQ_DELAY;
            phase_a <= phase_a xor selector(0) after REG_CQ_DELAY;
            phase_b <= phase_b xor not(selector(0)) after REG_CQ_DELAY;
            if selector(0) = '1' then
                data_reg <= a_data_in after REG_CQ_DELAY;
            else
                data_reg <= b_data_in after REG_CQ_DELAY;
            end if;
        end if;
    end process;


end arch;
