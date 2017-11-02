library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
Port(

	clk   : in STD_LOGIC; 
	reset : in STD_LOGIC
	);
end datapath;

architecture rtl of datapath is


---------------------memory--------------------------------------------
component ram is
generic
(
	ADDRESS_WIDTH	: integer;
	DATA_WIDTH		: integer 
);
port
(
	clock				: IN  std_logic;
	data				: IN  std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
	write_address		: IN  std_logic_vector(ADDRESS_WIDTH - 1 DOWNTO 0);
	read_address		: IN  std_logic_vector(ADDRESS_WIDTH - 1 DOWNTO 0);
	we					: IN  std_logic;
	q					: OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0) 	--output
);
end component;

--------------------trailing zeroes-----------------------------------
component trail_zero7 is
 port(
 	din 	: in STD_LOGIC_VECTOR(6 downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end component;
-------------------decoder --------------------------------------------

component decoder3_16 is
     port(
         din  : in STD_LOGIC_VECTOR(2 downto 0);
         dout : out STD_LOGIC_VECTOR(15 downto 0)
         );
end component;

----------------------temporary register--------------------------------
component temp_reg is  
  generic(
	input_width : integer	
	);
  port( clock 	: in std_logic; 
	din 	: in std_logic_vector(input_width-1 downto 0);  
        dout 	: out std_logic_vector(input_width-1 downto 0)
);  
end component;

-----------------------register file component-------------------------
component register_file is   
    port
    (
    rf_d1          	: out std_logic_vector(15 downto 0);    --dataout 1 
    rf_d2          	: out std_logic_vector(15 downto 0);    --dataout 2
    rf_d3          	: in  std_logic_vector(15 downto 0);    --datain 3
    writeEnable     : in  std_logic;
    readEnable		: in  std_logic;
    rf_a1   	    : in  std_logic_vector(2 downto 0);		--address in 1
    rf_a2	        : in  std_logic_vector(2 downto 0);		--address in 2
    rf_a3   	    : in  std_logic_vector(2 downto 0);		--address in 3
    clk             : in  std_logic
    );
end component;

------------instruction register -------------------------------
component instr_reg is  
  port(clock : in std_logic;
       din   : in std_logic_vector(15 downto 0);  
       dout  : out std_logic_vector(15 downto 0)
      );  
end component;


------------priority encoder----------------------
component priorityEncoder is
     port(
         din 	: in STD_LOGIC_VECTOR(15 downto 0);
         dout 	: out STD_LOGIC_VECTOR(2 downto 0);
		 valid  : out STD_LOGIC
         );
end component;

------------------------ALU-----------------------
component alu is
 Port ( reg_a 	: in signed(15 downto 0); 			--input A
 		reg_b  	: in signed(15 downto 0); 			--input B
 		op_sel 	: in STD_LOGIC_VECTOR (2 downto 0); --operation select
 		reg_c 	: out signed(15 downto 0); 			--output
	    c 		: out STD_LOGIC;					--carry flag
 		z 		: out STD_LOGIC_VECTOR 				--zero flag
);
end component;

-------------sign extender----------------
component sign_ext is
 generic( input_width : integer --input width is variable while output width remains constant
 );
 port(
 		din 	: in STD_LOGIC_VECTOR(input_width-1 downto 0);
 		dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end component;

------------signals----------------------------
	signal t1_alu_mux,t1_mema_mux,t1_memd_mux,rfd1_t1_mux,t3_t1_mux,o_t1_mux,mux_t1

begin

--instatntiation of all the parts
---- alu instantiation--------
alu: alu
port map(
	reg_a	=>, 	
	reg_b  	=>,
	en_c 	=>,
	en_z 	=>,
	op_sel 	=>,
	reg_c 	=>,
	c 		=>,
	z 		=>
);

---------------------sign extendors ---------------------
sign_ext7: sign_ext
generic map(7)
port map(
	din 	=>,
	dout	=>
);

sign_ext8: sign_ext
generic map(8)
port map(
	din 	=>,
	dout	=>
);

sign_ext10: sign_ext
generic map(10)
port map(
	din 	=>,
	dout	=>
);

pr_enc : priorityEncoder 
port map(
	din 	=>,
	dout 	=>,
	valid   =>
);

--------memory-----------------------------------------
memory : ram 
generic map(16,16)
port map
(
	clock				=>,
	data				=>,
	write_address		=>,
	read_address		=>,
	we					=>,
	q					=>
);
------------------------------ five temporary registers of 16 bit each ------------------------------
temp1 : temp_reg   
generic map(16)
port map( 	
	clock 	=>, 
	din 	=>,  
	dout 	=>
);  

temp2 : temp_reg   
generic map(16)
port map( 	
	clock 	=>, 
	din 	=>,  
	dout 	=>
);
temp3 : temp_reg   
generic map(16)
port map( 	
	clock 	=>, 
	din 	=>,  
	dout 	=>
);
temp4 : temp_reg   
generic map(16)
port map( 	
	clock 	=>, 
	din 	=>,  
	dout 	=>
);
temp5 : temp_reg   
generic map(16)
port map( 	
	clock 	=>, 
	din 	=>,  
	dout 	=>
);
------------------ trailing zero -------------------------------
trail_zero : trail_zero7 
port map(
	din 	=>,
	dout	=>
);
---------------------deocder from 3 to 16 where only first 8 bits are considered while remaining are zero padded------------------
decoder :  decoder3_16
port map(
	din  	=>,
	dout 	=> 
);

reg_file : register_file 
port map(
	rf_d1          	=>, 
	rf_d2          	=>,
	rf_d3          	=>,
	writeEnable     =>,
	readEnable		=>,
	rf_a1   	    =>,
	rf_a2	        =>,
	rf_a3   	    =>,
	clk             =>
);








end architecture ; -- rtl
