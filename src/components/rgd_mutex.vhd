LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

ENTITY mutex IS
    PORT (
        R1, R2 : IN STD_LOGIC;
        G1, G2 : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE impl OF mutex IS

    SIGNAL O1, O2 : STD_LOGIC;

BEGIN
    O1 <= NOT (R1 AND O2);
    O2 <= NOT (R2 AND O1);

    G1 <= O2 AND NOT (O1);
    G2 <= O1 AND NOT (O2);
END impl;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;
USE work.mutex;

ENTITY rgd_mutex IS
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
END ENTITY;

ARCHITECTURE impl OF rgd_mutex IS

    -- Clock
    SIGNAL pulse_a, pulse_b : STD_LOGIC;

    -- Input state
    SIGNAL a_ready, b_ready : STD_LOGIC;

    -- Clock tick
    SIGNAL click_a, click_b : STD_LOGIC;

    -- Input registers
    SIGNAL phase_in_a : STD_LOGIC;
    SIGNAL phase_in_b : STD_LOGIC;

    -- Output registers
    SIGNAL phase_out_a : STD_LOGIC;
    SIGNAL phase_out_b : STD_LOGIC;
    SIGNAL phase_out_c : STD_LOGIC;
    SIGNAL phase_out_d : STD_LOGIC;

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF phase_in_a : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF phase_in_b : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF phase_out_a : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF phase_out_b : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF phase_out_c : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF phase_out_d : SIGNAL IS "true";

BEGIN

    -- Pulse trigger
    pulse_a <= ((NOT (phase_out_a) AND inA_req) AND NOT (phase_in_a)) OR ((phase_out_a AND NOT (inA_req)) AND phase_in_a) AFTER AND3_DELAY + OR2_DELAY;
    pulse_b <= ((NOT (phase_out_c) AND inB_req) AND NOT (phase_in_b)) OR ((phase_out_c AND NOT (inB_req)) AND phase_in_b) AFTER AND3_DELAY + OR2_DELAY;

    -- Input state
    a_ready <= phase_in_a XOR inA_done;
    b_ready <= phase_in_b XOR inB_done;

    -- Control path
    outA_req <= phase_out_a;
    outB_req <= phase_out_c;

    -- Mutex
    M_0 : ENTITY mutex PORT MAP (
        a_ready, b_ready, click_a, click_b
        );

    t_0 : PROCESS (pulse_a, rst)
    BEGIN
        IF rst = '1' THEN
            phase_in_a <= PHASE_INIT_IN_A;
        ELSIF rising_edge(pulse_a) THEN
            phase_in_a <= NOT phase_in_a AFTER REG_CQ_DELAY;
        END IF;
    END PROCESS;

    t_1 : PROCESS (pulse_b, rst)
    BEGIN
        IF rst = '1' THEN
            phase_in_b <= PHASE_INIT_IN_B;
        ELSIF rising_edge(pulse_b) THEN
            phase_in_b <= NOT phase_in_b AFTER REG_CQ_DELAY;
        END IF;
    END PROCESS;

    t_2 : PROCESS (click_a, rst)
    BEGIN
        IF rst = '1' THEN
            phase_out_a <= PHASE_INIT_OUT_A;
            phase_out_b <= PHASE_INIT_OUT_B;
        -- Loopback reacting to rising edge control
        ELSIF rising_edge(click_a) THEN
            phase_out_a <= NOT phase_out_a AFTER REG_CQ_DELAY;
        -- Output reacting to falling edge 
        ELSIF falling_edge(click_a) THEN
            phase_out_b <= NOT phase_out_b AFTER REG_CQ_DELAY;

        END IF;
    END PROCESS;

    t_3 : PROCESS (click_b, rst)
    BEGIN
        IF rst = '1' THEN
            phase_out_c <= PHASE_INIT_OUT_C;
            phase_out_d <= PHASE_INIT_OUT_D;
        ELSIF rising_edge(click_b) THEN
            phase_out_c <= NOT phase_out_c AFTER REG_CQ_DELAY;
        ELSIF falling_edge(click_b) THEN
            phase_out_d <= NOT phase_out_d AFTER REG_CQ_DELAY;
        END IF;
    END PROCESS;
END impl;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.rgd_mutex;

ENTITY rgd_mutex_tb IS
END ENTITY;

ARCHITECTURE tb OF rgd_mutex_tb IS
    SIGNAL rst : STD_LOGIC;
    SIGNAL aR, bR : STD_LOGIC; --inputs
    SIGNAL aD, bD : STD_LOGIC;
    SIGNAL aG, bG : STD_LOGIC;
BEGIN

    DUT : ENTITY rgd_mutex
        PORT MAP(
            rst,
            aR, aG,
            aD, bR,
            bG, bD
        );
    rst <= '1', '0' AFTER 10 ns;
    aR <= '0', '1' AFTER 20 ns;
    bR <= '0', '1' AFTER 30 ns;

    aD <= '0', '1' AFTER 50 ns;
    bD <= '0', '1' AFTER 60 ns;
    ASSERT false REPORT "end of test" SEVERITY note;
END ARCHITECTURE;