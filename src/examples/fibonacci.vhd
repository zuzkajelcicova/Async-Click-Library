----------------------------------------------------------------------------------
-- Fibonacci circuit implementation
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity Fib is
  port (
    RESULT : out STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
    ack : in STD_LOGIC;
    req : out STD_LOGIC;
    rst : in STD_LOGIC;
    start : in STD_LOGIC
  );
end Fib;

architecture STRUCTURE of Fib is
  
  signal ack_1 : STD_LOGIC;
  signal add_block_0_ctrl_out_ack : STD_LOGIC;
  signal add_block_0_ctrl_out_req : STD_LOGIC;
  signal add_block_0_outC_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal click_element_0_ctrl_out_ack : STD_LOGIC;
  signal click_element_0_ctrl_out_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal click_element_0_ctrl_out_req : STD_LOGIC;
  signal start_component_0_ctrl_out_ack : STD_LOGIC;
  signal start_component_0_ctrl_out_req : STD_LOGIC;
  signal join_0_outC_ack : STD_LOGIC;
  signal join_0_outC_req : STD_LOGIC;
  signal reg_fork_0_outB_ack : STD_LOGIC;
  signal reg_fork_0_outB_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal reg_fork_0_outB_req : STD_LOGIC;
  signal reg_fork_0_outC_ack : STD_LOGIC;
  signal reg_fork_0_outC_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal reg_fork_0_outC_req : STD_LOGIC;
  signal reg_fork_1_outB_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal reg_fork_1_outB_req : STD_LOGIC;
  signal reg_fork_1_outC_ack : STD_LOGIC;
  signal reg_fork_1_outC_data : STD_LOGIC_VECTOR ( DATA_WIDTH-1 downto 0 );
  signal reg_fork_1_outC_req : STD_LOGIC;
  signal rst_1 : STD_LOGIC;
  signal start_1 : STD_LOGIC;

begin

  RESULT(DATA_WIDTH-1 downto 0) <= reg_fork_1_outB_data(DATA_WIDTH-1 downto 0);
  ack_1 <= ack;
  req <= reg_fork_1_outB_req;
  rst_1 <= rst;
  start_1 <= start;

  CL_0: entity work.add_block
    port map (
      inA_data(DATA_WIDTH-1 downto 0) => reg_fork_1_outC_data(DATA_WIDTH-1 downto 0),
      inB_data(DATA_WIDTH-1 downto 0) => reg_fork_0_outC_data(DATA_WIDTH-1 downto 0),
      in_ack => join_0_outC_ack,
      in_req => join_0_outC_req,
      outC_data(DATA_WIDTH-1 downto 0) => add_block_0_outC_data(DATA_WIDTH-1 downto 0),
      out_ack => add_block_0_ctrl_out_ack,
      out_req => add_block_0_ctrl_out_req
    );

  R_0: entity work.decoupled_hs_reg
    generic map(
      DATA_WIDTH    => DATA_WIDTH,
      VALUE         => 0,
      PHASE_INIT_IN => '0',
      PHASE_INIT_OUT=> '0')
    port map (
      in_ack => add_block_0_ctrl_out_ack,
      in_data(DATA_WIDTH-1 downto 0) => add_block_0_outC_data(DATA_WIDTH-1 downto 0),
      in_req => add_block_0_ctrl_out_req,
      out_ack => click_element_0_ctrl_out_ack,
      out_data(DATA_WIDTH-1 downto 0) => click_element_0_ctrl_out_data(DATA_WIDTH-1 downto 0),
      out_req => click_element_0_ctrl_out_req,
      rst => rst_1
    );

  Barrier: entity work.start_component
    port map (
      start => start_1,
      in_ack => reg_fork_1_outC_ack,
      in_req => reg_fork_1_outC_req,
      out_ack => start_component_0_ctrl_out_ack,
      out_req => start_component_0_ctrl_out_req
    );
  J_0: entity work.join
    generic map(
      PHASE_INIT => '0')
    port map (
      inA_ack => start_component_0_ctrl_out_ack,
      inA_req => start_component_0_ctrl_out_req,
      inB_ack => reg_fork_0_outC_ack,
      inB_req => reg_fork_0_outC_req,
      outC_ack => join_0_outC_ack,
      outC_req => join_0_outC_req,
      rst => rst_1
    );

  RF_0: entity work.reg_fork
    generic map(DATA_WIDTH =>DATA_WIDTH,
      VALUE=>1,
      PHASE_INIT_A=>'0',
      PHASE_INIT_B=>'1',
      PHASE_INIT_C=> '1')
    port map (
      inA_ack => click_element_0_ctrl_out_ack,
      inA_data(DATA_WIDTH-1 downto 0) => click_element_0_ctrl_out_data(DATA_WIDTH-1 downto 0),
      inA_req => click_element_0_ctrl_out_req,
      outB_ack => reg_fork_0_outB_ack,
      outB_data(DATA_WIDTH-1 downto 0) => reg_fork_0_outB_data(DATA_WIDTH-1 downto 0),
      outB_req => reg_fork_0_outB_req,
      outC_ack => reg_fork_0_outC_ack,
      outC_data(DATA_WIDTH-1 downto 0) => reg_fork_0_outC_data(DATA_WIDTH-1 downto 0),
      outC_req => reg_fork_0_outC_req,
      rst => rst_1
    );
    
  RF_1: entity work.reg_fork
    generic map(DATA_WIDTH => DATA_WIDTH,
      VALUE=>1,
      PHASE_INIT_A=>'0',
      PHASE_INIT_B=>'1',
      PHASE_INIT_C=> '1')
    port map (
      inA_ack => reg_fork_0_outB_ack,
      inA_data(DATA_WIDTH-1 downto 0) => reg_fork_0_outB_data(DATA_WIDTH-1 downto 0),
      inA_req => reg_fork_0_outB_req,
      outB_ack => ack_1,
      outB_data(DATA_WIDTH-1 downto 0) => reg_fork_1_outB_data(DATA_WIDTH-1 downto 0),
      outB_req => reg_fork_1_outB_req,
      outC_ack => reg_fork_1_outC_ack,
      outC_data(DATA_WIDTH-1 downto 0) => reg_fork_1_outC_data(DATA_WIDTH-1 downto 0),
      outC_req => reg_fork_1_outC_req,
      rst => rst_1
    );
end STRUCTURE;
