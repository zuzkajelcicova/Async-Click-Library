----------------------------------------------------------------------------------
-- Join component with data storage
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.defs.all;

entity join_top is
  Generic(DATA_WIDTH_A: natural := DATA_WIDTH;
          DATA_WIDTH_B: natural := DATA_WIDTH;
          DATA_WIDTH_C: natural := DATA_WIDTH;
          PHASE_INIT: std_logic := '0'
          );
  Port (
        --UPSTREAM channels
        a_req_in: in std_logic;
        a_data_in: in std_logic_vector(DATA_WIDTH_A-1 downto 0);
        a_ack_out: out std_logic;
        b_req_in: in std_logic;
        b_data_in: in std_logic_vector(DATA_WIDTH_B-1 downto 0);
        b_ack_out: out std_logic;
        
        --DOWNSTREAM channel
        c_req_out: out std_logic;
        c_data_out: out std_logic_vector(DATA_WIDTH_C-1 downto 0);
        c_down_in: in std_logic );
end join_top;

architecture Behavioral of join_top is

signal clk: std_logic;
signal a_req_sig, b_req_sig: std_logic;
signal data: word_t;

attribute dont_touch : string;
attribute dont_touch of  clk, data : signal is "true";
attribute dont_touch of  a_req_sig : signal is "true";
attribute dont_touch of  b_req_sig : signal is "true";

begin                       

JOIN: entity work.join
    GENERIC MAP(
        PHASE_INIT => PHASE_INIT)
    PORT MAP(   
                clk => clk,
                -- UPSTREAM channels
                a_req_in => a_req_sig,
                a_ack_out => a_ack_out,
                b_req_in => b_req_sig,
                b_ack_out => b_ack_out,
                -- DOWNSTREAM channel
                c_req_out => c_req_out,
                c_ack_in => c_down_in);
                
clock_regs: process(clk)
    begin
        if rising_edge(clk) then
        	--INSERT LOGIC HERE e.g. ADDING
            data <= a_data_in + b_data_in;
        end if;
    end process;
    
c_data_out <= data;

end Behavioral;
