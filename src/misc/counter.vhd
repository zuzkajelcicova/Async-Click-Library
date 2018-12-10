----------------------------------------------------------------------------------
-- counter
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
  Port (rst : in std_logic;
        clk : in std_logic;
        ch_in_ack : out std_logic;
        switch_in: in std_logic;
        ch_in_req: in std_logic);
end counter;

architecture Behavioral of counter is
signal state : std_logic_vector(2 downto 0);
signal ack_sig : std_logic;

attribute dont_touch : string;
attribute dont_touch of  state: signal is "true";   

begin


clock_regs: process(clk, rst)
begin
    if rst = '1' then
        state <= "000";
    elsif rising_edge(clk) then
        state <= state + '1';
        
    end if;
end process;
    
    ch_in_ack <= ch_in_req when state(2) = '0' else switch_in;

end Behavioral;
