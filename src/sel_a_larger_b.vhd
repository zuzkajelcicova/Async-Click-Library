library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity sel_a_larger_b is
    generic(
        DATA_WIDTH_1: natural := 32;
        PHASE_INIT : std_logic := '0'
	    );
	port(
        rst: in  std_logic;
	    -- Data
		ch_in_data : in  std_logic_vector(DATA_WIDTH_1 -1 downto 0);
		ch_in_req : in  std_logic;
		ch_in_ack : out std_logic;

		-- Selector
		selector : out std_logic;
		ch_out_sel_req : out std_logic;
		ch_out_sel_ack : in  std_logic
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
    click <= ch_in_req xnor ch_out_sel_ack after OR2_DELAY;
    
    a <= ch_in_data(DATA_WIDTH_1 - 1 downto DATA_WIDTH_1/2);
    b <= ch_in_data(DATA_WIDTH_1/2 -1 downto 0);
    
    DELAY_SEL_REQ: entity work.delay_element
        GENERIC MAP(
                    size => ADD_DELAY)
        PORT MAP   (d => ch_in_req,
                    z => a_req_in_sig);

	clock_regs : process(click, rst)
        begin
            if rst = '1' then
                phase <= PHASE_INIT;
            elsif rising_edge(click) then
                phase <= ch_in_req after REG_CQ_DELAY;
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
	ch_out_sel_req <= a_req_in_sig;
	ch_in_ack <= phase;
	
end Behavioral;