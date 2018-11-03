----------------------------------------------------------------------------------
-- 
-- Module Name: delay_element - Behavioral
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  go  is
generic(
    req_init : std_logic := '0' -- Delay  size
    );
port (
  go : in std_logic;
  ch_in_ack : out std_logic;
  ch_in_req : in std_logic;
  ch_out_ack : in std_logic;
  ch_out_req : out std_logic);
end  go;

architecture  lut of  go  is

begin

    ch_in_ack <= ch_out_ack;
    
    go_comp: if req_init = '1' generate
        ch_out_req <= go and ch_in_req;
    else generate
        ch_out_req <=  not(go) or ch_in_req;
    end generate go_comp;
end  lut;
