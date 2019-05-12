----------------------------------------------------------------------------------
--GCD Test-Bench
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.defs.all;

entity GCD_top is
    port(AB : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_req: in std_logic;
        i_ack: out std_logic;
        rst: in std_logic;
        RESULT: out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_req: out std_logic;
        o_ack: in std_logic;
        clk: in std_logic;
        req_deb: out std_logic;
        ack_deb: out std_logic;
        rst_deb: out std_logic
         );
end GCD_top;

architecture STRUCTURE of GCD_top is

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
  
component debounce_btn is
    port (
      clk       : in  std_logic;
      rst       : in std_logic;
      i_btn  : in  std_logic;
      o_switch  : out std_logic
      );
    end component debounce_btn;

signal rst_sig, ack_sig, req_sig: std_logic;

begin

reset_Button: entity work.debounce_btn
    generic map (INIT => '1')
    port map (
        clk => clk,
        rst => '0',
        i_btn => rst,
        o_switch => rst_sig);
        
ack_Button: component debounce_btn
    port map (
        clk => clk,
        rst => rst_sig,
        i_btn => o_ack,
        o_switch => ack_sig);
                
req_Button: component debounce_btn
    port map (
        clk => clk,
        rst => rst_sig,
        i_btn => i_req,
        o_switch => req_sig);
        
    rst_deb <= rst_sig;
    req_deb <= req_sig;
    ack_deb <= ack_sig;

GCD_module: component GCD
     port map (
      AB(DATA_WIDTH-1 downto 0) => AB,
      RESULT(DATA_WIDTH-1 downto 0) => RESULT,
      rst => rst_sig,
      i_req => req_sig,
      i_ack => i_ack,
      o_req => o_req,
      o_ack => ack_sig
    );

end STRUCTURE;
