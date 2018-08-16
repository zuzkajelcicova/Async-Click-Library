----------------------------------------------------------------------------------
-- Async_add
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.defs.all;

entity async_add is
    generic ( 
       PHASE_INIT : std_logic := '0';
       DATA_WIDTH: natural := DATA_WIDTH;
       VALUE: natural := 0);
  Port (
        rst:    in std_logic;
        -- Input channel 1
        a_req_in: in std_logic;
        a_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        a_ack_out: out std_logic;
        -- Input channel 2
        b_req_in: in std_logic;
        b_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        b_ack_out: out std_logic;
        -- Output channel
        c_req_out: out std_logic;
        c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        c_ack_in: in std_logic );
end async_add;

architecture Behavioral of async_add is

signal clk: std_logic;
signal data: word_t:= (others => '0');
signal  a_ack_delay, b_ack_delay, c_req_delay: std_logic;
signal a_ack_sig, b_ack_sig, c_req_sig: std_logic;

attribute dont_touch : string;
attribute dont_touch of  clk : signal is "true";
attribute dont_touch of  a_ack_delay, b_ack_delay, c_req_delay : signal is "true";

begin

    DELAY_ACK_A: entity work.delay_component
    GENERIC MAP(length => ADD_DELAY,
                size => 1)
    PORT MAP(   d => a_ack_sig,
                z => a_ack_delay);
                
    DELAY_ACK_B: entity work.delay_component
    GENERIC MAP(length => ADD_DELAY,
                size => 1)
    PORT MAP(   d => b_ack_sig,
                z => b_ack_delay);

    DELAY_REQ_C: entity work.delay_component
    GENERIC MAP(length => ADD_DELAY,
                size => 1)
    PORT MAP(   d => c_req_sig,
                z => c_req_delay);
            
JOIN: entity work.join
    generic map( 
       PHASE_INIT => PHASE_INIT)
    PORT MAP(  
           rst => rst,
           clk => clk,
           -- Input channel 1
           a_req_in => a_req_in,
           a_ack_out => a_ack_sig,
           -- Input channel 2
           b_req_in => b_req_in,
           b_ack_out => b_ack_sig,
           -- Output channel 
           c_req_out => c_req_sig,
           c_ack_in => c_ack_in);
           
a_ack_out <= a_ack_delay;
b_ack_out <= b_ack_delay;
c_req_out <= c_req_delay;
                
clock_regs: process(clk, rst)
    begin
        if rst = '1' then
            data <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
        elsif rising_edge(clk) then
            data <= a_data_in + b_data_in after REG_CQ_DELAY;
        end if;
    end process;
    
c_data_out <= data;

end Behavioral;
