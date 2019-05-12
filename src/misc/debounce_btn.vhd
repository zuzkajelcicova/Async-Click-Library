library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_btn is
   generic(INIT : std_logic := '0');
   port(  clk : in std_logic;
    rst : in std_logic;
    i_btn : in std_logic;
    o_switch : out std_logic);
end debounce_btn;

architecture behav of debounce_btn is

--clk counter
constant COUNT_MAX : integer := 10000; 
--set it '1' if the button creates a high pulse when its pressed
constant BTN_ACTIVE : std_logic := '1';

signal o_sig: std_logic;
signal count : integer := 0;
type state_type is (idle, wait_on, wait_off); --state machine
signal state : state_type := idle;

begin
 
  process(rst,clk)
  begin
    if(rst = '1') then
      state <= idle;
      o_switch <= INIT;
      o_sig <= INIT;
    elsif(rising_edge(clk)) then
     case (state) is
      when idle =>
        if(i_btn = BTN_ACTIVE) then  
          if o_sig = '0' then
            state <= wait_on;
          else
            state <= wait_off;
          end if;
        else
          state <= idle; --wait until button is pressed.
        end if;
        o_switch <= o_sig;
      when wait_on =>
        if(count = COUNT_MAX) then
          count <= 0;
            if(i_btn = BTN_ACTIVE) then
              o_sig <= '1';
            else 
              state <= idle;
            end if;
        else
          count <= count + 1;
        end if; 
      when wait_off =>
        if(count = COUNT_MAX) then
          count <= 0;
          if(i_btn = BTN_ACTIVE) then
            o_sig <= '0';
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