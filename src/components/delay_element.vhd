----------------------------------------------------------------------------------
-- Delay element
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library  unisim;
use  unisim.vcomponents.lut1;

entity  delay_element  is
  generic(
    size  : natural range 1 to 30 := 10); -- Delay  size
  port (
    d     : in std_logic; -- Data  in
    z     : out std_logic);
end  delay_element;

architecture  lut of  delay_element  is
  component  lut1
    generic (
      init  : bit_vector  := "10");
    port (
      I0    : in   std_ulogic;
      O     : out  std_ulogic
    );
  end  component;
  -- Internal  signals.
  signal  s_connect : std_logic_vector(size  downto  0);
  -- signal constraints
  attribute  DONT_TOUCH : string;
  attribute  DONT_TOUCH of  s_connect : signal  is "true";
  attribute  rloc : string;

begin
  s_connect(0)  <= d;
  -- Create  a riple-chain  of  luts (and  gates).
  lut_chain : for  index  in 0 to (size -1)  generate
    signal o : std_logic;
    type  y_placement  is  array (integer  range 0 to 29) of  integer;
    -- y coordinates for relative location
    constant  y_val : y_placement := (0,1,0,1,0,1,0,1,2,3,2,3,2,3,2,3,4,5,4,5,4,5,4,5,6,7,6,7,6,7);
    
    attribute  rloc of  delay_lut : label  is "X0Y" & integer 'image(y_val(index) );
    
    begin
      delay_lut: lut1
        generic  map(
          init => "10") --truth table
        port  map(
          I0 => s_connect(index),
          O  => o
        );
        
    s_connect(index +1)  <= o after 1 ns;
  end  generate  lut_chain;
  -- Connect  the  output  of  delay  element
  z  <= s_connect(size);

end  lut;