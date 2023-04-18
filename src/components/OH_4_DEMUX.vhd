----------------------------------------------------------------------------------
-- oh_4_demux
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

ENTITY oh_4_demux IS
  GENERIC (
    PHASE_INIT_A : STD_LOGIC := '0';
    PHASE_INIT_B : STD_LOGIC := '0';
    PHASE_INIT_C : STD_LOGIC := '0';
    PHASE_INIT_D : STD_LOGIC := '0';
    PHASE_INIT_E : STD_LOGIC := '0'
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
    selector : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    -- Output channel 1
    outB_req : OUT STD_LOGIC;
    outB_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    outB_ack : IN STD_LOGIC;
    -- Output channel 2
    outC_req : OUT STD_LOGIC;
    outC_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    outC_ack : IN STD_LOGIC;
    -- Output channel 3
    outD_req : OUT STD_LOGIC;
    outD_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    outD_ack : IN STD_LOGIC;
    -- Output channel 4
    outE_req : OUT STD_LOGIC;
    outE_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    outE_ack : IN STD_LOGIC
  );
END oh_4_demux;

ARCHITECTURE Behavioral OF oh_4_demux IS

  SIGNAL phase_a : STD_LOGIC;
  SIGNAL click_req, click_ack : STD_LOGIC;

  SIGNAL phase_b : STD_LOGIC;
  SIGNAL phase_c : STD_LOGIC;
  SIGNAL phase_d : STD_LOGIC;
  SIGNAL phase_e : STD_LOGIC;
BEGIN

  -- Control Path   
  inSel_ack <= phase_a;
  inA_ack <= phase_a;
  outB_req <= phase_b;
  outB_data <= inA_data;
  outC_req <= phase_c;
  outC_data <= inA_data;
  outD_req <= phase_d;
  outD_data <= inA_data;
  outE_req <= phase_e;
  outE_data <= inA_data;

  -- Request FF clock function
  click_req <= (inSel_req AND NOT(phase_a) AND inA_req) OR (NOT(inSel_req) AND phase_a AND NOT(inA_req)) AFTER ANDOR3_DELAY + NOT1_DELAY;

  -- Acknowledge FF clock function
  click_ack <= (outB_ack XNOR phase_b) AND (outC_ack XNOR phase_c) AND (outD_ack XNOR phase_d) AND (outE_ack XNOR phase_e) AFTER AND2_DELAY + XOR_DELAY + NOT1_DELAY;

  req : PROCESS (click_req, rst)
  BEGIN
    IF rst = '1' THEN
      phase_b <= PHASE_INIT_B;
      phase_c <= PHASE_INIT_C;
      phase_d <= PHASE_INIT_D;
      phase_e <= PHASE_INIT_E;
    ELSIF rising_edge(click_req) THEN
      phase_b <= phase_b XOR selector(0) AFTER REG_CQ_DELAY;
      phase_c <= phase_c XOR selector(1) AFTER REG_CQ_DELAY;
      phase_c <= phase_c XOR selector(2) AFTER REG_CQ_DELAY;
      phase_c <= phase_c XOR selector(3) AFTER REG_CQ_DELAY;
    END IF;
  END PROCESS req;

  ack : PROCESS (click_ack, rst)
  BEGIN
    IF rst = '1' THEN
      phase_a <= PHASE_INIT_A;
    ELSIF rising_edge(click_ack) THEN
      phase_a <= NOT phase_a AFTER REG_CQ_DELAY;
    END IF;
  END PROCESS ack;

END Behavioral;