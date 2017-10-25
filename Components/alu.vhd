library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity alu is
 Port ( reg_a : in signed(15 downto 0);
 reg_b : in signed(15 downto 0); 
 en_c : in STD_LOGIC; --enable for carry flag
 en_z : in STD_LOGIC; -- enable for zero flag
 op_sel : in STD_LOGIC_VECTOR (2 downto 0);
 reg_c : out signed(15 downto 0);
 c : out STD_LOGIC;
 z : out STD_LOGIC
);
end alu;

 
architecture Behavioral of alu is
begin

process(reg_a, reg_b, op_sel) 
begin
case op_sel is
	when "000" => 
		reg_c <= reg_a + reg_b; --addition 
		-- flag modification
		if (reg_a + reg_b > "0111111111111111") and (en_c ='1') then 
			c <= '1';
		end if;

		if(reg_a + reg_b = 0) and (en_z = '1') then
			z <= '1';
		end if;
			
	when "001" => 
		reg_c<= reg_a - reg_b; --subtraction
		-- flag modification
		if(reg_a = reg_b) and (en_z = '1') then
			z <= '1';
		end if;
		if(reg_a < reg_b) and (en_c ='1') then
			c <= '1';	
		end if;
	
	when "010" => 
		reg_c<= reg_a + 1; --add 1 
	
	when "011" => 
		reg_c<= reg_a nand reg_b; --nand
		-- flag modification
		if(reg_a = reg_b) and (en_z = '1') then
			z <= '1';  
		end if;

	when "100" =>
		reg_c<= reg_a xor reg_b; --xor
		-- flag modification
		if(reg_a = reg_b) and (en_z = '1') then
			z <= '1';		
		end if;

	when others =>
	NULL;

end case; 
  
end process; 
 
end Behavioral;

