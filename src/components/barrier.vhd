----------------------------------------------------------------------------------
-- Go
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity start_component is
  port (
    start : in std_logic;
    in_ack : out std_logic;
    in_req : in std_logic;
    out_ack : in std_logic;
    out_req : out std_logic);
end  start_component;

architecture  lut of  start_component  is
begin

  in_ack <= out_ack;
  out_req <= start and in_req;
  
end  lut;
