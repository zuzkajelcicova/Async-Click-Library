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

signal click: std_logic;
signal phase: std_logic;
signal not_bc, bc: std_logic;
signal data_reg: std_logic_vector(DATA_WIDTH-1 downto 0);

begin
           
not_bc <= not(b_ack_in) and not(c_ack_in) after AND2_DELAY + NOT1_DELAY;
bc <= c_ack_in and b_ack_in after AND2_DELAY + NOT1_DELAY;

click <= (not_bc and a_req_in and not(phase)) or (bc and not(a_req_in) and phase) after AND3_DELAY + OR2_DELAY;

clock_regs: process(click, rst)
begin
    if rst = '1' then
       phase <= PHASE_INIT;
       data_reg <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
    else
        if rising_edge(click) then
            phase <= not phase after REG_CQ_DELAY;
            data_reg <= a_data_in after REG_CQ_DELAY;
        end if;
    end if;
end process clock_regs;

a_ack_out <= phase;
b_req_out <= phase;
c_req_out <= phase;
b_data_out <= data_reg;
c_data_out <= data_reg;

end Behavioral;