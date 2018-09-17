----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2018 08:17:43 PM
-- Design Name: 
-- Module Name: asym_fork_stage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity asym_fork_stage is
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
        a_req_out: out std_logic;
        a_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        a_ack_in: in std_logic;
        --Output channel 2
        c_req_out: out std_logic;
        c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        c_ack_in: in std_logic );
end asym_fork_stage;

architecture Behavioral of asym_fork_stage is

signal click: std_logic;
signal asym_req: std_logic;
signal phase: std_logic;
signal phase_asym: std_logic;
signal nota_c, notc_a: std_logic;
signal data_reg: std_logic_vector(DATA_WIDTH-1 downto 0);


begin

    nota_c <= not(a_ack_in) and c_ack_in after AND2_DELAY + NOT1_DELAY;
    notc_a <= not(c_ack_in) and a_ack_in after AND2_DELAY + NOT1_DELAY;
    
    click <= (nota_c and a_req_in and not(phase)) or (notc_a and not(a_req_in) and phase) after AND3_DELAY + OR2_DELAY;
    
    clock_regs: process(click, rst)
    begin
        if rst = '1' then
           phase <= PHASE_INIT;
           phase_asym <= not(PHASE_INIT);
           data_reg <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH));
        else
            if rising_edge(click) then
                phase <= not phase after REG_CQ_DELAY;
                phase_asym <= not phase_asym after REG_CQ_DELAY;
                data_reg <= a_data_in after REG_CQ_DELAY;
            end if;
        end if;
    end process clock_regs;
    
    a_ack_out <= phase;
    a_req_out <= phase;
    c_req_out <= phase_asym;
    a_data_out <= data_reg;
    c_data_out <= data_reg;

end Behavioral;
