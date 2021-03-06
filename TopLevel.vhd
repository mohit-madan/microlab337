library std;
library ieee;
use ieee.std_logic_1164.all;


entity TopLevel is
  port (
    clk, reset : in std_logic;
	 clk_50		: in std_logic
   );
end entity TopLevel;

architecture Struct of TopLevel is

	component FSM_new is
  		port
		(
			clk		 				: in  std_logic;
			opcode					: in  std_logic_vector(3 downto 0);
			op_type 					: in  std_logic_vector(1 downto 0);
			reset	 					: in  std_logic;
			carry,zero,valid,cmp	: in  std_logic;
			IR_3_5					: in  std_logic;
			IR_6_8				   : in STD_LOGIC;--these two have been added
			IR_9_11					: in STD_LOGIC;
			IR_7						: in  std_logic;
			control_store 			: out std_logic_vector (19 downto 0));
	end component;

	component datapath is
Port(
	C     	 		 : in  STD_LOGIC_VECTOR(19 downto 0); --control signals 
	clk,reset   	 : in  STD_LOGIC; 
	valid 	 		 : out STD_LOGIC;
	carry,zeroflag  : out STD_LOGIC;
	op_code  		 : out STD_LOGIC_VECTOR(3 downto 0);
	IR_3_5 			 : out STD_LOGIC;
	IR_6_8			 : out STD_LOGIC;--these two have been added
	IR_9_11			 : out STD_LOGIC;
	IR_7      		 : out STD_LOGIC;
	op_type			 : out std_logic_vector(1 downto 0) ;
	cmp             : out std_logic 
	);
end component;

	signal opcode 						: std_logic_vector(3 downto 0);
	signal op_type 					: std_logic_vector(1 downto 0);
	signal carry,zero,valid,cmp 	: std_logic;
	signal IR_3_5 						: STD_LOGIC;
	signal IR_6_8 						: STD_LOGIC;
	signal IR_9_11 					: STD_LOGIC;
	signal IR_7 						: STD_LOGIC;
	signal control_store				: std_logic_vector (19 downto 0);


begin

ControlPath:FSM_new
    port map (
    clk					=> clk,
    opcode 				=> opcode,
    op_type 			=> op_type,
    reset 				=> reset,
    carry 				=> carry,
    zero 				=> zero,
    valid 				=> valid,
	 cmp   				=> cmp,
    IR_3_5 				=> IR_3_5,
	 IR_6_8			 	=> IR_6_8,
	 IR_9_11			 	=> IR_9_11,
    IR_7 				=> IR_7,
    control_store 	=> control_store
	 );


Data: datapath
    port map (
    C 			=> control_store,
    clk 			=> clk,
    reset 		=> reset,
    valid 		=> valid,
    carry 		=> carry,
    zeroflag	=> zero,
    IR_3_5 		=> IR_3_5,
	 IR_6_8	 	=> IR_6_8,
	 IR_9_11	 	=> IR_9_11,
    IR_7 		=> IR_7,
    op_code 	=> opcode,
	 op_type 	=> op_type,
	 cmp     	=> cmp
	 );
    
end Struct;