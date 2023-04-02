LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.rgd_mutex;
USE work.merge;

ENTITY arbiter IS
    PORT (
        rst : IN STD_LOGIC;
        -- Channel A
        inA_req   : in  std_logic;
        inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inA_ack   : out std_logic;
        -- Channel B
        inB_req   : in std_logic;
        inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inB_ack   : out std_logic;
        -- Output channel
        outC_req  : out std_logic;
        outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
        outC_ack  : in  std_logic
    );
END ENTITY;

ARCHITECTURE impl OF arbiter IS

    SIGNAL inA_req_mux, inA_done : STD_LOGIC;
    SIGNAL inB_req_mux, inB_done : STD_LOGIC;

BEGIN
    inA_ack <= inA_done;
    inB_ack <= inB_done;
    rgdmx : ENTITY rgd_mutex PORT MAP (
        rst,
        inA_req, inA_req_mux, inA_done,
        inB_req, inB_req_mux, inB_done
        );
    mrg : ENTITY merge PORT MAP (
        rst, 
        inA_req_mux, inA_done, inA_data,
        inB_req_mux, inB_done, inB_data, 
        outC_req, outC_data, outC_ack
        );

END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.rgd_mutex;
USE work.merge;
USE work.arbiter;

entity arbiter_tb is
end entity;

architecture tb of arbiter_tb is
    signal rst : std_logic;
    signal inA_req   :  std_logic;
    signal inA_data  :  std_logic_vector(DATA_WIDTH-1 downto 0);
    signal inA_ack   :  std_logic;
    signal inB_req   :  std_logic;
    signal inB_data  :  std_logic_vector(DATA_WIDTH-1 downto 0);
    signal inB_ack   :  std_logic;
    signal outC_req  :  std_logic;
    signal outC_data :  std_logic_vector(DATA_WIDTH-1 downto 0);
    signal outC_ack  :  std_logic;

begin

    DUT : entity arbiter
        port map (
            rst,
            inA_req,
            inA_data,
            inA_ack,
            inB_req,
            inB_data,
            inB_ack,
            outC_req,
            outC_data,
            outC_ack
        );

    rst <= '1' , '0' after 5 ns, '1' after 500 ns;
    inA_req <= '0', '1' after 25 ns;
    inA_data <= "0000000000000001"; 
    inB_req <= '0', '1' after 55 ns;
    inB_data <= "0000000000000010";  
    outC_ack <= '0', '1' after 80 ns;

end architecture;

