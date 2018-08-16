----------------------------------------------------------------------------------
-- Channel inverter (ake pseudo-token)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity inverter is
  Port (--Input channel
  		req_in: in std_logic;
        ack_out: out std_logic;
        -- Output channel
        req_out: out std_logic;
        ack_in: in std_logic );
end inverter;

architecture Behavioral of inverter is
signal ack_s, req_s: std_logic;
begin

ack_out <= not ack_in after NOT1_DELAY;
req_out <= not req_in after NOT1_DELAY;

end Behavioral;
