----------------------------------------------------------------------------------
-- Delay component
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity  delay_component  is
    generic(
        length : integer; -- number of delay_elements
        size : natural range 1 to 30); -- number of LUTs per delay_element        
    port (
         d : in   std_logic := '0'; -- Data in
         z : out  std_logic := '0'); -- Data out
end  delay_component;

architecture behavioral of delay_component  is  
    signal delay_sig: std_logic_vector(length downto 0);
  
   component delay_element
      generic(
            size : natural range 1 to 30 := size); -- number of LUTs        
          port (
            d : in   std_logic := '0'; -- Data in
            z : out  std_logic := '0'); -- Data out
      end  component;
  
  attribute dont_touch : string;
  attribute dont_touch of delay_sig : signal is "true";  
  
  begin 
  
  delay_gen : for i in 0 to (length-1) generate
     delay_i : delay_element
     port map(
             d => delay_sig(i),
             z => delay_sig(i+1));     
  end generate;
        
    delay_sig(0) <= d;
    z <= delay_sig(length);
        
end behavioral;