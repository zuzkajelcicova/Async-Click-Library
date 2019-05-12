----------------------------------------------------------------------------------
--GCD Test-Bench
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.defs.all;

entity GCD_tb is

end GCD_tb;

architecture STRUCTURE of GCD_tb is

signal AB, res: std_logic_vector(DATA_WIDTH-1 downto 0);
signal A: std_logic_vector(DATA_WIDTH/2-1  downto 0):= std_logic_vector(to_unsigned(210, 8));
signal B: std_logic_vector(DATA_WIDTH/2-1  downto 0):= std_logic_vector(to_unsigned(33, 8));
signal rst: std_logic;
signal i_req, i_ack, o_req, o_ack: std_logic;
signal A_result: std_logic_vector(DATA_WIDTH/2-1 downto 0);
signal B_result: std_logic_vector(DATA_WIDTH/2-1 downto 0);

  component GCD is
  port (
  AB : in std_logic_vector ( DATA_WIDTH-1 downto 0 );
  RESULT : out std_logic_vector ( DATA_WIDTH-1 downto 0 );
  rst : in std_logic;
  i_req:  in std_logic;
  i_ack:  out std_logic;
  o_req: out std_logic;
  o_ack: in std_logic
);
  end component GCD;
begin
AB <= A & B;
A_result <= res(DATA_WIDTH-1 downto DATA_WIDTH/2);
B_result <= res(DATA_WIDTH/2-1 downto 0);
GCD_module: component GCD
     port map (
      AB(DATA_WIDTH-1 downto 0) => AB,
      RESULT(DATA_WIDTH-1 downto 0) => res,
      rst => rst,
      i_req => i_req,
      i_ack => i_ack,
      o_req => o_req,
      o_ack => o_ack
    );
    o_ack <= '0';
    i_req <= '0', '1' after 200 ns;
    rst <= '1', '0' after 100 ns;
end STRUCTURE;
