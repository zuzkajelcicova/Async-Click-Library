library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity sel_a_larger_b is
    generic(
        DATA_WIDTH_1: natural := 32;
        PHASE_INIT : std_logic := '0'
	    );
	port(
        reset: in  std_logic;
	    -- Data
		data_in : in  std_logic_vector(DATA_WIDTH_1 -1 downto 0);
		req_in : in  std_logic;
		ack_out : out std_logic;

		-- Selector
		selector : out std_logic;
		sel_req_out : out std_logic;
		sel_ack_in : in  std_logic
	    );
end sel_a_larger_b;

architecture Behavioral of sel_a_larger_b is

	signal phase : std_logic;
	signal click : std_logic;
	
	signal a : std_logic_vector(DATA_WIDTH_1/2 -1 downto 0);
	signal b : std_logic_vector(DATA_WIDTH_1/2 -1 downto 0);
	signal data_sel : std_logic := '0';
	signal a_req_in_sig : std_logic;

    attribute dont_touch : string;
    attribute dont_touch of  phase, click : signal is "true";
    attribute dont_touch of  a, b, data_sel, a_req_in_sig : signal is "true";
    
begin
    -- XNOR
    click <= req_in xnor sel_ack_in after OR2_DELAY;
    
    a <= data_in(DATA_WIDTH_1 - 1 downto DATA_WIDTH_1/2);
    b <= data_in(DATA_WIDTH_1/2 -1 downto 0);
    
    DELAY_SEL_REQ: entity work.delay_element
        GENERIC MAP(
                    size => ADD_DELAY)
        PORT MAP   (d => req_in,
                    z => a_req_in_sig);

	clock_regs : process(click, reset)
        begin
            if reset = '1' then
                phase <= PHASE_INIT;
            elsif rising_edge(click) then
                phase <= req_in after REG_CQ_DELAY;
            end if;
    end process clock_regs;
    
    sel : process(a, b)
        begin
            if a > b then
               data_sel <= '1';
            else
               data_sel <= '0';               
            end if;
    end process sel;
	
	selector <= data_sel;
	sel_req_out <= a_req_in_sig;
	ack_out <= phase;
	
end Behavioral;