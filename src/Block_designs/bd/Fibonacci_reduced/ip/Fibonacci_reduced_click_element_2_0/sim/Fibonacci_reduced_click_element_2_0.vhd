-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:click_components:click_element:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Fibonacci_reduced_click_element_2_0 IS
  PORT (
    rst : IN STD_LOGIC;
    ack_out : OUT STD_LOGIC;
    req_in : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    req_out : OUT STD_LOGIC;
    data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ack_in : IN STD_LOGIC
  );
END Fibonacci_reduced_click_element_2_0;

ARCHITECTURE Fibonacci_reduced_click_element_2_0_arch OF Fibonacci_reduced_click_element_2_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF Fibonacci_reduced_click_element_2_0_arch: ARCHITECTURE IS "yes";
  COMPONENT click_element IS
    GENERIC (
      DATA_WIDTH_1 : INTEGER;
      VALUE : INTEGER;
      PHASE_INIT : STD_LOGIC
    );
    PORT (
      rst : IN STD_LOGIC;
      ack_out : OUT STD_LOGIC;
      req_in : IN STD_LOGIC;
      data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      req_out : OUT STD_LOGIC;
      data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ack_in : IN STD_LOGIC
    );
  END COMPONENT click_element;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF ack_in: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_out ack";
  ATTRIBUTE X_INTERFACE_INFO OF req_out: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_out req";
  ATTRIBUTE X_INTERFACE_INFO OF req_in: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_in req";
  ATTRIBUTE X_INTERFACE_INFO OF ack_out: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_in ack";
BEGIN
  U0 : click_element
    GENERIC MAP (
      DATA_WIDTH_1 => 32,
      VALUE => 0,
      PHASE_INIT => '0'
    )
    PORT MAP (
      rst => rst,
      ack_out => ack_out,
      req_in => req_in,
      data_in => data_in,
      req_out => req_out,
      data_out => data_out,
      ack_in => ack_in
    );
END Fibonacci_reduced_click_element_2_0_arch;
