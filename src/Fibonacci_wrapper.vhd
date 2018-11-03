--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Mon Sep 17 19:54:20 2018
--Host        : wehe-bot running 64-bit Debian GNU/Linux 9.5 (stretch)
--Command     : generate_target Fibonacci_wrapper.bd
--Design      : Fibonacci_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fibonacci_wrapper is
    port(clk:   in std_logic;
         i_rst: in std_logic;
         i_ack: in std_logic;
         i_go:  in std_logic;
         o_result: out std_logic_vector(15 downto 0);
         o_req: out std_logic
         );
end Fibonacci_wrapper;

architecture STRUCTURE of Fibonacci_wrapper is
  component fib_vhdl is
  port (
    go : in STD_LOGIC;
    rst : in STD_LOGIC;
    AB_RESULT : out STD_LOGIC_VECTOR ( 15 downto 0 );
   o_req: out std_logic;
   i_ack: in std_logic
  );
  end component fib_vhdl;
  
component debounce_switch is
    port (
      clk    : in  std_logic;
      i_switch : in  std_logic;
      o_switch : out std_logic
      );
  end component debounce_switch;
  
  signal go, rst, ack, req: std_logic;
  signal AB_RESULT: std_logic_vector(15 downto 0);
  
  attribute dont_touch : string;
  attribute dont_touch of  ack, req : signal is "true";
  
  
begin

Fibonacci_i: component fib_vhdl
     port map (
      AB_RESULT(15 downto 0) => AB_RESULT(15 downto 0),
      go => go,
      rst => rst,
      o_req => req,
      i_ack => ack
    );


rst_switch: component debounce_switch
    port map (
        clk => clk,
        i_switch => i_rst,
        o_switch => rst
    );

go_switch: component debounce_switch
    port map (
        clk => clk,
        i_switch => i_go,
        o_switch => go
    );
    
ack_switch: component debounce_switch
        port map (
            clk => clk,
            i_switch => i_ack,
            o_switch => ack
        );
    o_result <= AB_RESULT;
    o_req <= req;
    ---------------------------------------
--    go <= '0', '1' after 200 ns;
--    rst <= '1', '0' after 100 ns;
--    ack <= req after 5 ns;
    

end STRUCTURE;
