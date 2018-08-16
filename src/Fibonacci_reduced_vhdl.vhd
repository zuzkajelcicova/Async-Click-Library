----------------------------------------------------------------------------------
-- Reduced fibonacci circuit, VHDL implementation
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fibonacci_reduced_vhdl is
  port (
    RESULT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    go : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  
end Fibonacci_reduced_vhdl;

architecture STRUCTURE of Fibonacci_reduced_vhdl is

  component adder is
  port (
    reset : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_in : in STD_LOGIC;
    b_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_out : out STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC;
    d_req_out : out STD_LOGIC;
    d_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    d_ack_in : in STD_LOGIC
  );
  end component adder;
  
  component click_element is
  port (
    rst : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    req_out : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ack_in : in STD_LOGIC
  );
  end component click_element;
  
  component fork_top is
  port (
    rst : in STD_LOGIC;
    a_req_in : in STD_LOGIC;
    a_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_ack_out : out STD_LOGIC;
    b_req_out : out STD_LOGIC;
    b_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_ack_in : in STD_LOGIC;
    c_req_out : out STD_LOGIC;
    c_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c_ack_in : in STD_LOGIC
  );
  end component fork_top;
  
  component inverter is
  port (
    req_in : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_out : out STD_LOGIC;
    ack_in : in STD_LOGIC
  );
  end component inverter;
  
  component gate is
  port (
    go : in STD_LOGIC;
    ack_out : out STD_LOGIC;
    req_in : in STD_LOGIC;
    ack_in : in STD_LOGIC;
    req_out : out STD_LOGIC
  );
  end component gate;
  
  signal adder_0_c_ctrl_out_ack : STD_LOGIC;
  signal adder_0_c_ctrl_out_req : STD_LOGIC;
  signal adder_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal adder_0_d_ctrl_out_ack : STD_LOGIC;
  signal adder_0_d_ctrl_out_req : STD_LOGIC;
  signal adder_0_d_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_0_ctrl_out_ack : STD_LOGIC;
  signal click_element_0_ctrl_out_req : STD_LOGIC;
  signal click_element_0_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_1_ctrl_out_ack : STD_LOGIC;
  signal click_element_1_ctrl_out_req : STD_LOGIC;
  signal click_element_1_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_2_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal click_element_2_req_out : STD_LOGIC;
  signal fork_stage_0_b_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_0_b_ctrl_out_req : STD_LOGIC;
  signal fork_stage_0_b_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fork_stage_0_c_ctrl_out_ack : STD_LOGIC;
  signal fork_stage_0_c_ctrl_out_req : STD_LOGIC;
  signal fork_stage_0_c_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal gate_0_ctrl_out_ack : STD_LOGIC;
  signal gate_0_ctrl_out_req : STD_LOGIC;
  signal go_1 : STD_LOGIC;
  signal inverter_0_ctrl_out_ack : STD_LOGIC;
  signal inverter_0_ctrl_out_req : STD_LOGIC;
  signal rst_1 : STD_LOGIC;
begin
  RESULT(31 downto 0) <= click_element_2_data_out(31 downto 0);
  go_1 <= go;
  rst_1 <= rst;
adder_0: component adder
     port map (
      a_ack_out => click_element_1_ctrl_out_ack,
      a_data_in(31 downto 0) => click_element_1_data_out(31 downto 0),
      a_req_in => click_element_1_ctrl_out_req,
      b_ack_out => inverter_0_ctrl_out_ack,
      b_data_in(31 downto 0) => fork_stage_0_b_data_out(31 downto 0),
      b_req_in => inverter_0_ctrl_out_req,
      c_ack_in => adder_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => adder_0_c_data_out(31 downto 0),
      c_req_out => adder_0_c_ctrl_out_req,
      d_ack_in => adder_0_d_ctrl_out_ack,
      d_data_out(31 downto 0) => adder_0_d_data_out(31 downto 0),
      d_req_out => adder_0_d_ctrl_out_req,
      reset => rst_1
    );
click_element_0: entity work.click_element
     generic map(
      DATA_WIDTH_1 => 32,
      VALUE => 1,
      PHASE_INIT => '0')
     port map (
      ack_in => click_element_0_ctrl_out_ack,
      ack_out => adder_0_d_ctrl_out_ack,
      data_in(31 downto 0) => adder_0_d_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_0_data_out(31 downto 0),
      req_in => adder_0_d_ctrl_out_req,
      req_out => click_element_0_ctrl_out_req,
      rst => rst_1
    );
click_element_1: entity work.click_element
     generic map(
      DATA_WIDTH_1 => 32,
      VALUE => 0,
      PHASE_INIT => '1')
     port map (
      ack_in => click_element_1_ctrl_out_ack,
      ack_out => fork_stage_0_c_ctrl_out_ack,
      data_in(31 downto 0) => fork_stage_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_1_data_out(31 downto 0),
      req_in => fork_stage_0_c_ctrl_out_req,
      req_out => click_element_1_ctrl_out_req,
      rst => rst_1
    );
click_element_2: component click_element
     port map (
      ack_in => click_element_2_req_out,
      ack_out => adder_0_c_ctrl_out_ack,
      data_in(31 downto 0) => adder_0_c_data_out(31 downto 0),
      data_out(31 downto 0) => click_element_2_data_out(31 downto 0),
      req_in => adder_0_c_ctrl_out_req,
      req_out => click_element_2_req_out,
      rst => rst_1
    );
fork_stage_0: entity work.fork_top
     generic map(
      DATA_WIDTH => 32,
      VALUE => 0,
      PHASE_INIT => '1')
     port map (
      a_ack_out => gate_0_ctrl_out_ack,
      a_data_in(31 downto 0) => click_element_0_data_out(31 downto 0),
      a_req_in => gate_0_ctrl_out_req,
      b_ack_in => fork_stage_0_b_ctrl_out_ack,
      b_data_out(31 downto 0) => fork_stage_0_b_data_out(31 downto 0),
      b_req_out => fork_stage_0_b_ctrl_out_req,
      c_ack_in => fork_stage_0_c_ctrl_out_ack,
      c_data_out(31 downto 0) => fork_stage_0_c_data_out(31 downto 0),
      c_req_out => fork_stage_0_c_ctrl_out_req,
      rst => rst_1
    );
gate_0: component gate
     port map (
      ack_in => gate_0_ctrl_out_ack,
      ack_out => click_element_0_ctrl_out_ack,
      go => go_1,
      req_in => click_element_0_ctrl_out_req,
      req_out => gate_0_ctrl_out_req
    );
inverter_0: component inverter
     port map (
      ack_in => inverter_0_ctrl_out_ack,
      ack_out => fork_stage_0_b_ctrl_out_ack,
      req_in => fork_stage_0_b_ctrl_out_req,
      req_out => inverter_0_ctrl_out_req
    );
end STRUCTURE;
