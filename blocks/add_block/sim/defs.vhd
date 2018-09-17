library IEEE;
use IEEE.std_logic_1164.all;

package defs is
	constant DATA_WIDTH : Integer := 32;
	subtype word_t is std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	constant VALID_BIT   : integer := 34;
	constant HEADER_BIT  : integer := 33;
	constant END_BIT  : integer := DATA_WIDTH-3;
	constant TAIL_BIT    : integer := 32;
	constant ROUTE_WIDTH : integer := 16; -- We only use 16 bits for the route
	

	--constant path : string := "D:\Users\Dean\Dropbox\DTU\2013 E\NoCPaper\DistributedClick\sim/Environment/";
	--constant path : string := "/home/lestat/Dropbox/DTU/Semester3/NoCPaper/DistributedClick/sim/Environment/";
	constant path : string := "/home/vlsi06b/router/DistributedClick/sim/Environment/";

	type channel_forward is record
		req  : std_logic;
		data : word_t;
	end record;

	type channel_backward is record
		ack : std_logic;
	end record;

	type channel is record
		forward  : channel_forward;
		backward : channel_backward;
	end record;

	type ch_wire is record
		n, e, s, w, r : std_logic;
	end record;

	type sel is record
		n, e, s, w : std_logic;
	end record;
	type selects is array (0 to 4) of sel;
	type entry is record
		input_mask          : ch_wire;
		n_sel, e_sel, s_sel, w_sel, r_sel : sel;
	end record;
	
	type sel1_channel_forward is record
		req  : std_logic;
		data : std_logic;
	end record;
	
	type sel4_channel_forward is record
		req  : std_logic;
		data : sel;
	end record;
	
	type sel4_combined_channel_forward is record
		req  : std_logic;
		data : selects;
	end record;
	
	type table_entry_channel_forward is record
		req  : std_logic;
		data : entry;
	end record;
	
	type sel1_channel is record
		forward  : sel1_channel_forward;
		backward : channel_backward;
	end record;
	
	type sel4_channel is record
		forward  : sel4_channel_forward;
		backward : channel_backward;
	end record;
	
	type sel4_combined_channel is record
		forward  : sel4_combined_channel_forward;
		backward : channel_backward;
	end record;
	
	type table_entry_channel is record
		forward  : table_entry_channel_forward;
		backward : channel_backward;
	end record;

	-- global clock wait time
	constant GLOABL_WAIT_TIME : time := 50 ns;
	
	constant DYNAMIC_CLICK_DELAY : time := 2 ns;
	
	-- Table size
	constant INDEX_WIDTH : integer := 6; -- Index width, allowing 2^X elements
	constant MAX_INDEX   : integer := 59;

	--Delay size
	constant ADD_DELAY : integer := 15;
	constant LUT_CHAIN_SIZE : integer := 10;
	constant AND2_DELAY : time := 2 ns; -- 2 input AND gate
	constant AND3_DELAY : time := 3 ns; -- 3 input AND gate
	constant NOT1_DELAY : time := 1 ns; -- 1 input NOT gate
	constant ANDOR3_DELAY : time := 4 ns; -- Complex AND_OR gate
	constant REG_CQ_DELAY : time := 1 ns; -- Clk to Q delay
	constant ADDER_DELAY : time := 15 ns; -- Clk to Q delay
	
	constant OR2_DELAY  : time := 2 ns; -- 2 input OR gate
	constant XOR_DELAY	  : time := 3 ns;

end package;
