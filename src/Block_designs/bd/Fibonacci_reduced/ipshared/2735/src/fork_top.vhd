----------------------------------------------------------------------------------
-- Fork stage
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.defs.all;


entity fork_top is
 generic ( 
            DATA_WIDTH: natural := DATA_WIDTH;
            VALUE: natural := 0;
            PHASE_INIT : std_logic := '0');
  Port (
        rst : in std_logic;
        --Input channel
        a_req_in: in std_logic;
        a_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        a_ack_out: out std_logic;
     
        --Output channel 1
        b_req_out: out std_logic;
        b_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        b_ack_in: in std_logic;
        --Output channel 2
        c_req_out: out std_logic;
        c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        c_ack_in: in std_logic );
end fork_top;

architecture Behavioral of fork_top is

signal clk: std_logic;
signal data: word_t;

attribute dont_touch : string;
attribute dont_touch of  clk, data : signal is "true";

begin
           
FORK: entity work.fork
    generic map( 
            PHASE_INIT => PHASE_INIT
            )
    PORT MAP(   rst => rst,
    	        clk => clk,
                a_req_in => a_req_in,
                b_ack_in => b_ack_in,
                c_ack_in => c_ack_in,
                 
                a_ack_out => a_ack_out,
                b_req_out => b_req_out,
                c_req_out => c_req_out
                );
                
clock_regs: process(clk, rst)
 begin
    if rst = '1' then
        data <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
    else
        if rising_edge(clk) then
            data <= a_data_in after REG_CQ_DELAY;
        end if;
    end if;
 end process;

b_data_out <= data;  
c_data_out <= data;

end Behavioral;