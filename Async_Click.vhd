LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

PACKAGE Async_Click IS
    CONSTANT DATA_WIDTH : INTEGER := 16;
    COMPONENT arbiter IS
        PORT (
            rst : IN STD_LOGIC;
            -- Channel A
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            -- Channel B
            inB_req : IN STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inB_ack : OUT STD_LOGIC;
            -- Output channel
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT start_component IS
        PORT (
            start : IN STD_LOGIC;
            in_ack : OUT STD_LOGIC;
            in_req : IN STD_LOGIC;
            out_ack : IN STD_LOGIC;
            out_req : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT click_element IS
        GENERIC (
            DATA_WIDTH : NATURAL := DATA_WIDTH;
            VALUE : NATURAL := 0;
            PHASE_INIT : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC;
            -- Input channel
            in_ack : OUT STD_LOGIC;
            in_req : IN STD_LOGIC;
            in_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            -- Output channel
            out_req : OUT STD_LOGIC;
            out_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            out_ack : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT decoupled_hs_reg IS
        GENERIC (
            DATA_WIDTH : NATURAL := DATA_WIDTH;
            VALUE : NATURAL := 0;
            PHASE_INIT_IN : STD_LOGIC := '0';
            PHASE_INIT_OUT : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC;
            -- Input channel
            in_ack : OUT STD_LOGIC;
            in_req : IN STD_LOGIC;
            in_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            -- Output channel
            out_req : OUT STD_LOGIC;
            out_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            out_ack : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT delay_element IS
        GENERIC (
            size : NATURAL RANGE 1 TO 30 := 10); -- Delay  size
        PORT (
            d : IN STD_LOGIC; -- Data  in
            z : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT demux IS
        PORT (
            rst : IN STD_LOGIC;
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            inSel_req : IN STD_LOGIC;
            inSel_ack : OUT STD_LOGIC;
            selector : IN STD_LOGIC;
            outB_req : OUT STD_LOGIC;
            outB_data : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            outB_ack : IN STD_LOGIC;
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT demux;

    COMPONENT merge IS
        PORT (
            rst : IN STD_LOGIC;
            inA_req : IN STD_LOGIC;
            inA_ack : OUT STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            inB_req : IN STD_LOGIC;
            inB_ack : OUT STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT merge;

    COMPONENT fork IS
        PORT (
            rst : IN STD_LOGIC;
            -- Input channel
            inA_req : IN STD_LOGIC;
            inA_ack : OUT STD_LOGIC;
            -- Output channel 1
            outB_req : OUT STD_LOGIC;
            outB_ack : IN STD_LOGIC;
            -- Output channel 2
            outC_req : OUT STD_LOGIC;
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT fork;

    COMPONENT join_reg_fork IS
        GENERIC (
            DATA_WIDTH : NATURAL := DATA_WIDTH;
            VALUE : NATURAL := 0;
            PHASE_INIT_A : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0';
            PHASE_INIT_C : STD_LOGIC := '0';
            PHASE_INIT_D : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC;
            --Input channel 1 
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH/2 - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            --Input channel 2
            inB_req : IN STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR(DATA_WIDTH/2 - 1 DOWNTO 0);
            inB_ack : OUT STD_LOGIC;
            --Output channel 1
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC;
            --Output channel 2
            outD_req : OUT STD_LOGIC;
            outD_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outD_ack : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT join IS
        GENERIC (
            PHASE_INIT : STD_LOGIC := '0'
        );
        PORT (
            rst : IN STD_LOGIC;
            --UPSTREAM channels
            inA_req : IN STD_LOGIC;
            inA_ack : OUT STD_LOGIC;
            inB_req : IN STD_LOGIC;
            inB_ack : OUT STD_LOGIC;
            --DOWNSTREAM channel
            outC_req : OUT STD_LOGIC;
            outC_ack : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT mux IS
        GENERIC (DATA_WIDTH : NATURAL := DATA_WIDTH);
        PORT (
            rst : IN STD_LOGIC;
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            inB_req : IN STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            inB_ack : OUT STD_LOGIC;
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC;
            inSel_req : IN STD_LOGIC;
            inSel_ack : OUT STD_LOGIC;
            selector : IN STD_LOGIC_VECTOR (0 TO 0)
        );
    END COMPONENT mux;

    COMPONENT reg_demux IS
        GENERIC (
            PHASE_INIT : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0';
            PHASE_INIT_C : STD_LOGIC := '0'
        );
        PORT (
            rst : IN STD_LOGIC;
            -- Input port
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            -- Select port 
            inSel_req : IN STD_LOGIC;
            inSel_ack : OUT STD_LOGIC;
            selector : IN STD_LOGIC;
            -- Output channel 1
            outB_req : OUT STD_LOGIC;
            outB_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outB_ack : IN STD_LOGIC;
            -- Output channel 2
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT reg_fork IS
        GENERIC (
            DATA_WIDTH : NATURAL := DATA_WIDTH;
            VALUE : NATURAL := 0;
            PHASE_INIT_A : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0';
            PHASE_INIT_C : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC;
            --Input channel
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            --Output channel 1
            outB_req : OUT STD_LOGIC;
            outB_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outB_ack : IN STD_LOGIC;
            --Output channel 2
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT reg_merge IS
        GENERIC (
            PHASE_INIT_C : STD_LOGIC := '0';
            PHASE_INIT_A : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC;
            --Input channel 1
            inA_req : IN STD_LOGIC;
            inA_ack : OUT STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            -- Input channel 2
            inB_req : IN STD_LOGIC;
            inB_ack : OUT STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            -- Output channel
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT reg_mux IS
        --generic for initializing the phase registers
        GENERIC (
            PHASE_INIT_C : STD_LOGIC := '0';
            PHASE_INIT_A : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0');
        PORT (
            rst : IN STD_LOGIC; -- rst line
            -- Input from channel 1
            inA_req : IN STD_LOGIC;
            inA_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inA_ack : OUT STD_LOGIC;
            -- Input from channel 2
            inB_req : IN STD_LOGIC;
            inB_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            inB_ack : OUT STD_LOGIC;
            -- Output port 
            outC_req : OUT STD_LOGIC;
            outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            outC_ack : IN STD_LOGIC;
            -- Select port
            inSel_req : IN STD_LOGIC;
            inSel_ack : OUT STD_LOGIC;
            selector : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT rgd_mutex IS
        --generic for initializing the phase registers
        GENERIC (
            PHASE_INIT_IN_A : STD_LOGIC := '0';
            PHASE_INIT_IN_B : STD_LOGIC := '0';
            PHASE_INIT_OUT_A : STD_LOGIC := '0';
            PHASE_INIT_OUT_B : STD_LOGIC := '0';
            PHASE_INIT_OUT_C : STD_LOGIC := '0';
            PHASE_INIT_OUT_D : STD_LOGIC := '0'

        );
        PORT (
            rst : IN STD_LOGIC; -- rst line

            -- Channel A
            inA_req : IN STD_LOGIC;
            outA_req : OUT STD_LOGIC;
            inA_done : IN STD_LOGIC;

            -- Channel B
            inB_req : IN STD_LOGIC;
            outB_req : OUT STD_LOGIC;
            inB_done : IN STD_LOGIC
        );
    END COMPONENT;
END PACKAGE;