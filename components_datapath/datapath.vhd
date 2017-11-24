library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
Port(
	C     	 		 : in  STD_LOGIC_VECTOR(19 downto 0); --control signals 
	clk,reset   	 : in  STD_LOGIC; 
	valid 	 		 : out STD_LOGIC;
	carry,zeroflag  : out STD_LOGIC;
	op_code  		 : out STD_LOGIC_VECTOR(3 downto 0);
	IR_3_5 			 : out STD_LOGIC;
	IR_7      		 : out STD_LOGIC;
	op_type			 : out std_logic_vector(1 downto 0) ;
	cmp             : out std_logic 
	);
end datapath;

architecture rtl of datapath is
-----------------mux 2 to 1-------------------------------
component mux2to1 is
generic(
	input_width : integer
	);
port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	sel: in STD_LOGIC;
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end component;

------------------mux 4 to 1-----------------------------
component mux4to1 is
generic(
	input_width : integer
	);
port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d2 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d3 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	sel: in STD_LOGIC_VECTOR(1 downto 0);
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end component;

---------------mux 8 to 1 -------------------------
 
component mux8to1 is
generic(input_width : integer);
port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d2 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d3 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d4 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d5 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d6 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d7 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	sel: in STD_LOGIC_VECTOR(2 downto 0);
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end component;

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
	data_in			: IN  std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
	address			: IN  std_logic_vector(ADDRESS_WIDTH - 1 DOWNTO 0);
	wr_en				: IN  std_logic;
	rd_en				: IN  std_logic;
	data_out			: OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0)
);
end component;

--------------------trailing zeroes-----------------------------------
component trail_zero7 is
 port(
 	din 	: in STD_LOGIC_VECTOR(8 downto 0);
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
   port( 
			clock,reset : in std_logic;
        en      : in std_logic; 
	      din 	  : in std_logic_vector(input_width-1 downto 0);  
        dout 	  : out std_logic_vector(input_width-1 downto 0)
);  
end component;

-----------------------register file component-------------------------
component regfile is   
    port
    (
    rf_d1          	: out std_logic_vector(15 downto 0);    --dataout 1 
    rf_d2          	: out std_logic_vector(15 downto 0);    --dataout 2
    rf_d3          	: in  std_logic_vector(15 downto 0);    --datain 3
    writeEnable     : in  std_logic;
    readEnable1		: in  std_logic;
    readEnable2     : in  std_logic;
    rf_a1   	    : in  std_logic_vector(2 downto 0);		--address in 1
    rf_a2	        : in  std_logic_vector(2 downto 0);		--address in 2
    rf_a3   	    : in  std_logic_vector(2 downto 0);		--address in 3
    clk,reset       : in  std_logic
    );
end component;



------------priority encoder----------------------
component priorityEncoder is
     port(
         din 	: in STD_LOGIC_VECTOR(15 downto 0);
         dout 	: out STD_LOGIC_VECTOR(2 downto 0);
		   valid : out STD_LOGIC
         );
end component;

----------

component registers is  
  port( clock,reset 	  : in std_logic;
        en       : in std_logic; 
		  din 	  : in std_logic;  
        dout 	  : out std_logic
);  
end component;
  
------------------------ALU-----------------------
component alu is
   port(reg_a, reg_b: in std_logic_vector(15 downto 0);
	     add1bit: in std_logic;
        op_sel: in std_logic_vector(3 downto 0);
        reg_c: out std_logic_vector(15 downto 0);
        carry: out std_logic;
        zero: out std_logic;
   		cmp       : out std_logic);
end component;
---------------------------signext8---------------------

component signext8 is
 port(
 	din 	: in STD_LOGIC_VECTOR(7 downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end component;

-------------sign extender----------------
component sign_ext is
 generic( input_width : integer --input width is variable while output width remains constant
 );
 port(
 		din 	: in STD_LOGIC_VECTOR(15 - input_width downto 0);
 		dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end component;

------------signals----------------------------
	signal D1,D2,mem_out,alu_out,t1,t2,t3,t4,t5,t6,ir_out, se7_out, se8_out, se10_out, trail_zero_out, decoder_out,pc_out : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal muxout_mema, muxout_mem_din, muxout_d3,muxout_t1 ,muxout_t2, muxout_t4,muxout_alu_a, muxout_alu_b: STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); 
	signal pr_enc_out,a3_mux,muxout_a1, muxout_a3 : STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
	signal en_t1, en_t4,en_t6, wren, rden1, rden2, memwr, memrd, memd_mux, alu_enc, alu_enz,en1_bit, carry1, zeroflag1 : std_logic:= '0';
	signal a1_mux, d3_mux, mema, alu2_mux : std_logic_vector(1 downto 0):= (others => '0');
	signal alu1_mux : std_logic_vector(2 downto 0):= (others => '0');

begin

------------------------
--C(0) - PC

--C(2-1)   - input select FOR T1
	

--C(4-3) - input select FOR T2
	

--C(5) - input selet for T3
	

-- C(7-6) - input select for T4	


--C(8) - input select for T5


--C(9) - input select for IR

--C(12 -10) - input select for MEMORY


--C(15-13) - input select for ALU

--C(19-16) - input select for REGISTER FILE

	
--instatntiation of all the parts


---------------------



--effectively 1 and 2 are changed in the sheet

en_t1 <= not (C(1) and C(2));
en_t4 <= not C(6) ; -- this is changed from not 6 and 7
en_t6 <= C(16) and C(17);    --lol

----reg file
wren  <= (not(C(16)) and C(17)) or (C(18) and C(19)); -- write enable pin registhttps://github.com/mohit-madan/microlab337.giter file
rden1  <= (not C(16) and not C(17)) and (C(18) xor C(19)) ; 
rden2  <= (C(17) and not C(18)) and (C(16) xor C(19));
a1_mux(1) <= C(16) and C(17) and not C(18) and not C(19);
a1_mux(0) <= not C(16) and not C(17) and C(18) and not C(19);

a3_mux(2) <= C(16) and not C(17) and not C(18) and not C(19); 
a3_mux(1) <= (not C(16) and C(17) and (C(18) or C(19))) or (C(16) and not C(17) and not C(18) and C(19));
a3_mux(0) <= (C(16) and not C(17) and C(18)) or (not C(16) and C(17) and (not(C(18) xor C(19))));

d3_mux(1) <= C(18) and ((not C(16) and C(17)) or (C(16) and not C(17) and C(19)));
d3_mux(0) <= (not C(16) and C(17) and not C(18)) or (not C(16) and C(17) and C(18) and C(19)) or (C(16) and not C(17) and C(19));


---memory
memwr <= C(10) and not C(11);
memrd <= not C(10) and (C(11) or C(12));

memd_mux <= C(11) or C(12);

mema(1) <= not(C(11) xor C(12));
mema(0) <= (not C(10) and C(11) and not C(12)) or (C(10) and not C(11) and C(12));

----alu

alu_enc <= not C(13) and C(14);
alu_enz <= (not C(13) and C(14)) or (C(13) and (not C(14)) and C(15));

alu1_mux(2) <= C(13) and C(14) and C(15);
alu1_mux(1) <= (C(15) and (C(13) xor C(14))) or (C(13) and C(14) and not C(15));
alu1_mux(0) <= (C(13) and not C(14)) or (C(14) and (not C(13) and not C(15)));

alu2_mux(1) <= C(13) and (C(14) or C(15));
alu2_mux(0) <= C(14);



------ opcode for user -----------------
op_code <= ir_out(15 downto 12);
IR_3_5 <= not(ir_out(5) and ir_out(4) and ir_out(3)) ;
IR_7   <= ir_out(7);
op_type <= ir_out(1 downto 0);

en1_bit <= (not C(14) and (C(13) xor C(15))) or (C(13) and C(14) and not C(15)); -- add1 bit

-------muxes inititalisation --------------
t2_mux : mux2to1 
generic map(16)
port map(
	d0   => mem_out,
	d1   => D2,
	sel  => C(4),
	dout => muxout_t2
);

memdin_mux : mux2to1 
generic map(16)
port map(
	d0   => t1,
	d1   => t6,
	sel  => memd_mux,
	dout => muxout_mem_din
);


muxt1 : mux4to1
generic map(16)
port map(
	d0   => "0000000000000000",
	d1   => t3,
	d2   => D1,
	d3   => "1111111111111111",
	sel  => C(2 downto 1),
	dout => muxout_t1
);

muxt4 : mux4to1
generic map(16)
port map(
	d0   => alu_out,
	d1   => D1,
	d2   => se8_out,
	d3   => "1111111111111111",
	sel  => C(7 downto 6),
	dout => muxout_t4
);

mema_mux : mux4to1
generic map(16)
port map(
	d0   => D1,
	d1   => t1,
	d2   => t3,
	d3   => "1111111111111111",
	sel  => mema(1 downto 0),
	dout => muxout_mema
);

-----TEMP1 AND TEMP2 -------------

temp1 : temp_reg   
generic map(16)
port map( 	
	reset => reset ,
	clock 	=> clk,
	en      => en_t1, 
	din 	=> muxout_t1,  
	dout 	=> t1
);  

temp2 : temp_reg   
generic map(16)
port map( 	
	reset => reset ,
	clock 	=> clk,
	en      => C(3), 
	din 	=> muxout_t2,  
	dout 	=> t2
);


d3_of_rf : mux4to1
generic map(16)
port map(
	d0   => t3,
	d1   => pc_out,
	d2   => trail_zero_out,
	d3   => t2,
	
	sel  => d3_mux(1 downto 0),
	dout => muxout_d3
);
----changes have to be made here----
a1_rf : mux4to1 
generic map(3)
port map(
	d0   => "111",
	d1   => ir_out(11 downto 9),
	d2   => pr_enc_out, 
	d3   => "111",
	sel  => a1_mux(1 downto 0),
	dout => muxout_a1
);

a3_rf : mux8to1
generic map(3)
port map(
	d0   => ir_out(5 downto 3),
	d1   => "111",
	d2   => ir_out(11 downto 9),
	d3   => pr_enc_out,
	d4   => ir_out(8 downto 6),
	d5   => "111",
	d6   => "111",
	d7   => "111",
	
	sel  => a3_mux(2 downto 0),
	dout => muxout_a3
);

alu_a_mux : mux8to1
generic map(16)
port map(
	d0   => D1,
	d1   => t1,
	d2   => se10_out,
	d3   => t4,
	d4   => se7_out,
	d5   => "1111111111111111",
	d6   => "1111111111111111",
	d7   => "1111111111111111",
	
	sel  => alu1_mux (2 downto 0),
	dout => muxout_alu_a
);
------------

alu_b_mux : mux4to1
generic map(16)
port map(
	d0   => "0000000000000001",
	d1   => t2,
	d2   => t5,
	d3   => pc_out,
	sel  => alu2_mux(1 downto 0),
	dout => muxout_alu_b
);



---- alu instantiation--------
my_alu: alu
port map(
	reg_a	=> muxout_alu_a, 	
	reg_b => muxout_alu_b,
	add1bit => en1_bit,
	op_sel 	=> ir_out(15 downto 12), --will be provided from opcode
	reg_c 	=> alu_out,
	carry		=> carry1, --output from the entity
	zero	=> zeroflag1, -- output from the entity\
	cmp             => cmp
);
car : registers
port map(
	reset => reset,
	clock => clk,
	en    => alu_enc,
	din   => carry1,
    dout  => carry 
	);

z : registers
port map(
	reset => reset,
	clock => clk,
	en    => alu_enz,
	din   => zeroflag1,
   dout  => zeroflag
	);

---------------------sign extendors ---------------------
sign_ext7: sign_ext
generic map(7)
port map(
	din 	=> ir_out(8 DOWNTO 0),
	dout	=> se7_out
);

sign_ext8: signext8
port map(
	din 	=> ir_out(7 downto 0),
	dout	=> se8_out
);

sign_ext10: sign_ext
generic map(10)
port map(
	din 	=> ir_out(5 downto 0),
	dout	=> se10_out
);

pr_enc : priorityEncoder 
port map(
	din 	=> t4,
	dout 	=> pr_enc_out,
	valid   => valid
);

--------memory-----------------------------------------
memory : ram 
generic map(16,16)
port map
(
	clock				=> clk,
	data_in				=> muxout_mem_din,
	address				=> muxout_mema,
	wr_en				=> memwr,
	rd_en				=> memrd,
	data_out			=> mem_out
);
------------------------------instruction register-------------------

instruction_reg : temp_reg
generic map(16)
port map(
	reset => reset ,
	clock => clk, 
	en      => C(9),
	din 	=> mem_out,  
	dout 	=> ir_out
	);
-----------------------------program counter-----------------------
program_counter : temp_reg
generic map(16)
port map(
	reset => reset ,
	clock 	=> clk,
	en      => C(0), 
	din 	=> alu_out,  
	dout 	=> pc_out
	);

------------------------------ five temporary registers of 16 bit each ------------------------------
temp6 : temp_reg
generic map(16)
port map( 	
	reset => reset ,
	clock 	=> clk,
	en      => en_t6, 
	din 	=> D1,  
	dout 	=> t6
);

temp3 : temp_reg   
generic map(16)
port map( 	
	reset => reset ,
	clock 	=> clk,
	en      => C(5), 
	din 	=> alu_out,  
	dout 	=> t3
);
temp4 : temp_reg   
generic map(16)
port map( 
		reset => reset ,
	clock 	=> clk,
	en      => en_t4, 
	din 	=> muxout_t4,  
	dout 	=> t4
);
temp5 : temp_reg   
generic map(16)
port map( 
		reset => reset ,
	clock 	=> clk,
	en       => C(8), 
	din 		=> decoder_out,  
	dout 		=> t5
);
------------------ trailing zero -------------------------------
trail_zero : trail_zero7 
port map(
	din 	=> ir_out(8 downto 0),
	dout	=> trail_zero_out
);
---------------------deocder from 3 to 16 where only first 8 bits are considered while remaining are zero padded------------------
decoder :  decoder3_16
port map(
	din  	=> pr_enc_out,
	dout 	=> decoder_out
);

reg_file : regfile 
port map(
	rf_d1          	=> D1, 
	rf_d2          	=> D2,
	rf_d3          	=> muxout_d3,
	writeEnable     	=> wren,
	readEnable1			=> rden1,
	readEnable2			=> rden2,
	rf_a1   	    		=> muxout_a1,
	rf_a2	        		=> ir_out(8 downto 6),
	rf_a3   	    		=> muxout_a3,
	clk             	=> clk,
	reset 				=> reset
);
-- temp register



end architecture ; -- rtl