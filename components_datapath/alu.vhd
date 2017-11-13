library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
   port(reg_a, reg_b: in std_logic_vector(15 downto 0);
	     add1bit: in std_logic;
        op_sel: in std_logic_vector(3 downto 0);
        reg_c: out std_logic_vector(15 downto 0);
        carry: out std_logic;
        zero: out std_logic;
		  cmp: out std_logic
		  );
end entity;
 
architecture Struct of ALU is
  component TwosComplement is
	port (
	  input: in std_logic_vector(15 downto 0);
	  output: out std_logic_vector(15 downto 0)
	);
  end component;
  signal alu_out_read : std_logic_vector(15 downto 0);
  signal two_complement1: std_logic_vector(15 downto 0);
  signal two_complement2: std_logic_vector(15 downto 0);
  signal two_complement_add: std_logic_vector(15 downto 0);
  signal carry1, carry2: std_logic;


begin
   two: TwosComplement
        port map (
          input => reg_a,
          output => two_complement1
        );
   two1: TwosComplement
        port map (
          input => reg_b,
          output => two_complement2
        );
   
   reg_c <= alu_out_read;
   
   zero <= '1' when alu_out_read = "0000000000000000" else '0';
   
   carry1 <= '1' when reg_a(15) = '1' and reg_b(15) = '1' and
                      two_complement1(14 downto 0) > two_complement_add(14 downto 0) else '0';
   carry2 <= '1' when reg_a(15) = '0' and reg_b(15) = '0' and
                      reg_a(14 downto 0) > alu_out_read(14 downto 0) else '0';
   carry <= '1' when (carry1 = '1' or carry2 = '1') else '0';

-------------
process(op_sel, reg_a, reg_b, two_complement1, two_complement2, add1bit)
   begin

-------------

if(add1bit = '1' or op_sel = "0000" or op_sel ="0001" or op_sel = "0100" or op_sel = "0101" or op_sel = "1000") then--add
	alu_out_read <= std_logic_vector(unsigned(reg_a) + unsigned(reg_b));
   two_complement_add <= std_logic_vector(unsigned(two_complement1) + unsigned(two_complement2));

elsif(op_sel = "0010") then -- nand
	alu_out_read <= reg_a nand reg_b;
   two_complement_add <= reg_a nand reg_b;

elsif(op_sel = "0110" or op_sel = "0111" ) then -- xor
	alu_out_read <= reg_a xor reg_b;
	two_complement_add <= reg_a xor reg_b; 
elsif(op_sel = "1100") then	
	if(reg_a = reg_b) then
		cmp <= '1';
	else cmp <= '0';
	end if;
end if;
	  
end process; 
end struct;

