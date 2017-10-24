library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity alu is
 Port ( reg_a : in signed(16 downto 0);
 inp_b : in signed(16 downto 0);
 op_sel : in STD_LOGIC_VECTOR (1 downto 0);
 reg_c : out signed(16 downto 0));
end alu;
 
architecture Behavioral of alu is
begin

process(reg_a, inp_b, op_sel) 
begin
case op_sel is
	when "00" => 
		reg_c<= reg_a + inp_b; --addition 
	when "01" => 
		reg_c<= reg_a - inp_b; --subtraction 
	when "10" => 
		reg_c<= reg_a + 1; --add 1 
	when "11" => 
		reg_c<= reg_a nand inp_b; --nand  

	when others =>
	NULL;
end case; 
  
end process; 
 
end Behavioral;

