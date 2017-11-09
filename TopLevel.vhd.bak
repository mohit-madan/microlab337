library std;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ProcessorComponents.all;

entity TopLevel is
  port (
    clk, reset: in std_logic;
   );
end entity TopLevel;

architecture Struct of TopLevel is

	component FSM_new is
  		port
		(
			clk		 			: in  std_logic;
			opcode				: in  std_logic_vector(3 downto 0);
			op_type 			: in  std_logic_vector(1 downto 0);
			reset	 			: in  std_logic;
			carry,zero,valid	: in  std_logic;
			IR_3_5				: in  std_logic;
			IR_7				: in  std_logic;
			control_store 		: out std_logic_vector (19 downto 0);
	end component;

	component datapath is
		port
		(
			C     	 		 : in  STD_LOGIC_VECTOR(19 downto 0); --control signals 
			clk,reset   	 : in  STD_LOGIC; 
			valid 	 		 : out STD_LOGIC;
			carry,zeroflag 	 : out STD_LOGIC;
			op_code  		 : out STD_LOGIC_VECTOR(3 downto 0);
			IR_3_5 			 : out STD_LOGIC_VECTOR(2 downto 0);
			IR_7      		 : out STD_LOGIC);
	end component;

	signal opcode : in std_logic_vector(3 downto 0);
	signal reset : in  std_logic;
	signal clk : in  std_logic;
	signal carry,zero,valid : in  std_logic;
	signal zeroflag : in std_logic;
	signal IR_3_5 : out STD_LOGIC_VECTOR(2 downto 0);
	signal IR_7 : out STD_LOGIC;

begin

ControlPath:FSM_new
    port map (
    clk	=> clk,
    opcode => opcode,
    op_type => op_type,
    reset => reset,
    carry => carry,
    zero => zero,
    valid => valid,
    IR_3_5 => IR_3_5,
    IR_7 => IR_7,
    control_store => control_store);


Data: datapath
    port map (
    C => C,
    clk => clk,
    reset => reset,
    valid => valid,
    carry => carry,
    zeroflag => zeroflag,
    IR_3_5 => IR_3_5,
    IR_7 => IR_7,
    opcode => opcode);
    
end Struct;