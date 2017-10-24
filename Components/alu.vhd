library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity alu is
 Port ( inp_a : in signed(16 downto 0);
 inp_b : in signed(16 downto 0);
 sel : in STD_LOGIC_VECTOR (1 downto 0);
 out_alu : out signed(16 downto 0));
end alu;
 
architecture Behavioral of alu is
begin

process(inp_a, inp_b, sel) 
begin
case sel is
	when "00" => 
		out_alu<= inp_a + inp_b; --addition 
	when "01" => 
		out_alu<= inp_a - inp_b; --subtraction 
	when "10" => 
		out_alu<= inp_a + 1; --add 1 
	when "11" => 
		out_alu<= inp_a nand inp_b; --nand  

	when others =>
	NULL;
end case; 
  
end process; 
 
end Behavioral;

