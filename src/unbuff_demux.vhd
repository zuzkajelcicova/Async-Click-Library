----------------------------------------------------------------------------------
-- Demux
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity unbuff_demux is
    generic(
        PHASE_INIT_A : std_logic := '0';
	    PHASE_INIT_B: std_logic := '0';
	    PHASE_INIT_C: std_logic := '0'
	    );
	port(
        rst: in  std_logic;
		-- Input port
		ch_in_a_req : in  std_logic;
		ch_in_a_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_a_ack : out std_logic;

		-- Select port 
		ch_in_sel_req : in  std_logic;
		ch_in_sel_ack : out std_logic;
		selector: in std_logic;

		-- Output channel 1
		ch_out_b_req : out std_logic;
		ch_out_b_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_b_ack : in  std_logic;
		-- Output channel 2
		ch_out_c_req : out std_logic;
		ch_out_c_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_c_ack : in  std_logic
	    );
end unbuff_demux;

architecture Behavioral of unbuff_demux is

	signal phase_a : std_logic;
	signal click_req, click_ack : std_logic;
	
	signal phase_b : std_logic;
	signal phase_c : std_logic;

begin
    
	-- Control Path   
    ch_in_sel_ack <= phase_a;
    ch_in_a_ack <= phase_a;
    ch_out_b_req <= phase_b;
    ch_out_b_data <= ch_in_a_data;
    ch_out_c_req <= phase_c;
    ch_out_c_data <= ch_in_a_data;
    
    -- Request FF clock function
    click_req <= (ch_in_sel_req and not(phase_a) and ch_in_a_req) or (not(ch_in_sel_req) and phase_a and not(ch_in_a_req)) after ANDOR3_DELAY + NOT1_DELAY;
    
    -- Acknowledge FF clock function
    click_ack <= (ch_out_b_ack xnor phase_b) and (ch_out_c_ack xnor phase_c) after AND2_DELAY + XOR_DELAY + NOT1_DELAY;

	req : process(click_req, rst)
        begin
            if rst = '1' then
                phase_b <= PHASE_INIT_B;
                phase_c <= PHASE_INIT_C;
            elsif rising_edge(click_req) then
                phase_b <= phase_b xor selector after REG_CQ_DELAY;
                phase_c <= phase_c xor not(selector) after REG_CQ_DELAY;
            end if;
    end process req;
    
	ack : process(click_ack, rst)
        begin
            if rst = '1' then
                phase_a <= PHASE_INIT_A;
            elsif rising_edge(click_ack) then
                phase_a <= not phase_a after REG_CQ_DELAY;
            end if;
    end process ack;
	
end Behavioral;
