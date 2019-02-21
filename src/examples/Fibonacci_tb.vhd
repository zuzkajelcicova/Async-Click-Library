----------------------------------------------------------------------------------
-- Test bench for fibonacci circuit
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fib_tb is
end Fib_tb;

architecture STRUCTURE of Fib_tb is
  component Fib is
  port (
    rst : in STD_LOGIC;
    start : in STD_LOGIC;
    RESULT : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ack : in STD_LOGIC;
    req : out STD_LOGIC
  );
  end component Fib;
  
  signal start, rst, ack, req: std_logic;
  signal RESULT: std_logic_vector(15 downto 0);
  
  attribute dont_touch : string;
  attribute dont_touch of  ack, req : signal is "true";
  
begin

  ack <= req after 5 ns;
  start <= '0', '1' after 200 ns;
  rst <= '1', '0' after 100 ns;
  
  Fib_module: component Fib
    port map (
      RESULT(15 downto 0) => RESULT(15 downto 0),
      ack => ack,
      start => start,
      req => req,
      rst => rst
    );
       
end STRUCTURE;