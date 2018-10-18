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
  ack_out : out std_logic;
  req_in : in std_logic;
  ack_in : in std_logic;
  req_out : out std_logic);
end  go;

architecture  lut of  go  is

begin

    ack_out <= ack_in;
    
    go_comp: if req_init = '1' generate
        req_out <= go and req_in;
    else generate
        req_out <= go xnor req_in;
    end generate go_comp;
end  lut;
