----------------------------------------------------------------------------------
-- Go
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  go  is
  generic(
    req_init : std_logic := '0' -- Delay  size
  );
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
  
  go_comp: if req_init = '1' generate
    out_req <= go and in_req;
  else generate
    out_req <=  not(go) or in_req;
  end generate go_comp;
  
end  lut;
