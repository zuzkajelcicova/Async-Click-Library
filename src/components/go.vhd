----------------------------------------------------------------------------------
-- Go
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity go is
  port (
    go : in std_logic;
    in_ack : out std_logic;
    in_req : in std_logic;
    out_ack : in std_logic;
    out_req : out std_logic);
end  go;

architecture  lut of  go  is
begin

  in_ack <= out_ack;
  out_req <= go and in_req;
  
end  lut;
