----------------------------------------------------------------------------------
-- Adder
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.defs.all;

entity adder is
    generic ( 
           DATA_WIDTH: natural := DATA_WIDTH;
           VALUE: natural := 0;
           PHASE_INIT : std_logic := '0');
	port(
	    reset: in  std_logic;
		-- Upstream channels
		a_req_in : in std_logic;
		a_data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
		a_ack_out : out std_logic;
		
		b_req_in : in std_logic;
		b_data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
		b_ack_out : out std_logic;
	
		-- Downstream channels
		c_req_out : out std_logic;
		c_data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
		c_ack_in : in std_logic;
		d_req_out : out std_logic;
        d_data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
        d_ack_in : in std_logic
	    );
end adder;

architecture arch of adder is

	-- Register control	
	signal phase : std_logic;
	signal click : std_logic;

	-- Click circuit
	signal and_reqs_high_in, and_acks_high_in : std_logic;
	signal and_reqs_low_in, and_acks_low_in   : std_logic;
	signal iphase                             : std_logic;
	signal data                               : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal req_sig                            : std_logic;
	
	attribute dont_touch : string;
    attribute dont_touch of  phase, click, and_reqs_high_in, and_acks_high_in, and_reqs_low_in, and_acks_low_in, iphase : signal is "true";

begin

    DELAY_REQ_A: entity work.delay_component
    GENERIC MAP(length => ADD_DELAY,
                size => 1)
    PORT MAP(   d => phase,
                z => req_sig);
                
                
	-- Control Path
	a_ack_out <= req_sig;
	b_ack_out <= req_sig;

	c_req_out <= req_sig;
	d_req_out <= req_sig;

	and_reqs_high_in <= a_req_in and b_req_in after AND2_DELAY;
	and_reqs_low_in  <= (not a_req_in) and (not b_req_in) after AND2_DELAY + NOT1_DELAY;

	and_acks_high_in <= c_ack_in and d_ack_in after AND2_DELAY;
	and_acks_low_in  <= (not c_ack_in) and (not d_ack_in) after AND2_DELAY + NOT1_DELAY;

	iphase <= not phase after NOT1_DELAY;

	click <= (and_reqs_low_in and phase and and_acks_high_in) or (and_reqs_high_in and iphase and and_acks_low_in) after ANDOR3_DELAY + OR2_DELAY;

	data_reg: process(reset, click)
	begin
		if (reset = '1') then          
			phase <= '0';
			data <= (others => '0');
		elsif rising_edge(click) then
			phase <= not phase after REG_CQ_DELAY;
			data <= a_data_in + b_data_in after REG_CQ_DELAY;
		end if;
	end process data_reg;
	
	c_data_out <= data;
    d_data_out <= data;

end arch;
