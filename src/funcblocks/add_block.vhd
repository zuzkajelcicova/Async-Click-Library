----------------------------------------------------------------------------------
-- Add-block
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity add_block is
  generic ( 
    DATA_WIDTH: natural := DATA_WIDTH);
  port (-- Input channel
    in_req    : in std_logic;
    in_ack    : out std_logic;
    -- Output channel
    out_req   : out std_logic;
    out_ack   : in std_logic;
    inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end add_block;

architecture Behavioral of add_block is
signal connect: std_logic := '0'; -- signal for constraining i/o (needed only for post-timing simulation)

attribute dont_touch : string;
attribute dont_touch of  connect : signal is "true";   
begin

delay_req: entity work.delay_element
  generic map(
    size => ADD_DELAY-- Delay  size
  )
  port map (
    d => in_req,
    z => out_req
  );

outC_data <= inA_data + inB_data after ADDER_DELAY;
in_ack <= connect;
connect <= out_ack;

end Behavioral;