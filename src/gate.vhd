----------------------------------------------------------------------------------
-- Gate
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gate is
port (
          go : in std_logic;
          ack_out : out std_logic;
          req_in : in std_logic;
          ack_in : in std_logic;
          req_out : out std_logic);
end gate;

architecture Behavioral of gate is

begin

    ack_out <= ack_in;
    req_out <= req_in when go = '1' else ack_in;

end Behavioral;
