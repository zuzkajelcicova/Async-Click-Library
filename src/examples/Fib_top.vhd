----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fib_top is
  port(clk:   in std_logic;
    i_rst:    in std_logic;
    i_ack:    in std_logic;
    i_start:  in std_logic;
    o_RESULT: out std_logic_vector(15 downto 0);
    o_req:    out std_logic
    );
end Fib_top;

architecture STRUCTURE of Fib_top is
  component fib is
  port (
    start   : in STD_LOGIC;
    rst     : in STD_LOGIC;
    RESULT  : out STD_LOGIC_VECTOR ( 15 downto 0 );
    req     : out std_logic;
    ack     : in std_logic
  );
  end component fib;
  
component debounce_switch is
  port (
    clk       : in  std_logic;
    i_switch  : in  std_logic;
    o_switch  : out std_logic
    );
  end component debounce_switch;
  
  signal start, rst, ack, req: std_logic;
  signal AB_RESULT: std_logic_vector(15 downto 0);
  
  attribute dont_touch : string;
  attribute dont_touch of  ack, req : signal is "true";
  
  
begin

Fibonacci_i: component fib
  port map (
    RESULT(15 downto 0) => AB_RESULT(15 downto 0),
    start => start,
    rst => rst,
    req => req,
    ack => ack
  );


rst_switch: component debounce_switch
  port map (
    clk => clk,
    i_switch => i_rst,
    o_switch => rst
  );

start_switch: component debounce_switch
  port map (
    clk => clk,
    i_switch => i_start,
    o_switch => start
  );
    
ack_switch: component debounce_switch
  port map (
    clk => clk,
    i_switch => i_ack,
    o_switch => ack
  );
    
    o_RESULT <= AB_RESULT;
    o_req <= req;    

end STRUCTURE;
