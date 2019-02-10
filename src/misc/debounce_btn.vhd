 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_btn is
   port(   clk : in std_logic;
               rst : in std_logic;
           i_btn : in std_logic;
           o_switch : out std_logic
       );
end debounce_btn;

architecture behav of debounce_btn is

--the below constants decide the working parameters.
constant COUNT_MAX : integer := 20; 
--set it '1' if the button creates a high pulse when its pressed, otherwise '0'.
constant BTN_ACTIVE : std_logic := '1';

signal count : integer := 0;
type state_type is (idle,wait_time); --state machine
signal state : state_type := idle;

begin
 
process(rst,clk)
begin
   if(rst = '1') then
       state <= idle;
       o_switch <= '0';
  elsif(rising_edge(clk)) then
       case (state) is
           when idle =>
               if(i_btn = BTN_ACTIVE) then  
                   state <= wait_time;
               else
                   state <= idle; --wait until button is pressed.
               end if;
               o_switch <= '0';
           when wait_time =>
               if(count = COUNT_MAX) then
                   count <= 0;
                   if(i_btn = BTN_ACTIVE) then
                       o_switch <= '1';
                   else 
                       state <= idle;
                   end if;
               else
                   count <= count + 1;
               end if; 
       end case;       
   end if;        
end process;                  
                                                                               
end architecture behav;