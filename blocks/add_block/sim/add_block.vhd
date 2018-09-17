----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2018 09:17:52 PM
-- Design Name: 
-- Module Name: add_block - Behavioral
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

entity add_block is
    generic ( 
       DATA_WIDTH: natural := DATA_WIDTH);
  Port (
        a_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        b_data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        c_data_out: out std_logic_vector(DATA_WIDTH-1 downto 0));
end add_block;

architecture Behavioral of add_block is

begin
c_data_out <= a_data_in + b_data_in after ADDER_DELAY;

end Behavioral;
