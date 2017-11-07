library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity alu is
 Port ( reg_a : in STD_LOGIC_VECTOR(15 downto 0);
 reg_b 		  : in STD_LOGIC_VECTOR(15 downto 0); 
 op_sel       : in STD_LOGIC_VECTOR (2 downto 0);
 reg_c        : out STD_LOGIC_VECTOR(15 downto 0);
 en_c			  : in std_logic;
 en_z			  : in std_logic;
 carry_flag            : out STD_LOGIC;
 zero_flag            : out STD_LOGIC
);
end alu;

 
architecture Behavioral of alu is
signal reg_a_sign,reg_b_sign,reg_c_sign : signed (15 downto 0);
begin
reg_a_sign <=signed(reg_a);
reg_b_sign <=signed(reg_b);
process(reg_a_sign, reg_b_sign, op_sel) 
begin
case op_sel is
	when "000" => 
		reg_c_sign <= reg_a_sign + reg_b_sign; --addition 
		-- flag modification
		if (reg_a_sign + reg_b_sign > "0111111111111111") and (en_c ='1') then 
			carry_flag <= '1';
		end if;

		if(reg_a_sign + reg_b_sign = 0) and (en_z ='1') then
			zero_flag <= '1';
		end if;
			---change carry logic
	when "001" => 
		reg_c_sign<= reg_a_sign - reg_b_sign; --subtraction
		-- flag modification
		if(reg_a_sign = reg_b_sign) and (en_z ='1') then
			zero_flag <= '1';
		end if;
		if(reg_a_sign < reg_b_sign) and (en_c ='1') then
			carry_flag <= '1';	
		end if;
	
	when "010" => 
		reg_c_sign<= reg_a_sign + 1; --add 1 
	
	when "011" => 
		reg_c_sign<= reg_a_sign nand reg_b_sign; --nand
		-- flag modification
		if(reg_a_sign = reg_b_sign) and (en_z ='1') then
			zero_flag <= '1';  
		end if;

	when "100" =>
		reg_c_sign<= reg_a_sign xor reg_b_sign; --xor
		-- flag modification
		if(reg_a_sign = reg_b_sign) and (en_z ='1') then
			zero_flag <= '1';		
		end if;

	when others =>
	NULL;

end case; 
  
end process; 
reg_c <=STD_LOGIC_VECTOR(reg_c_sign);
 
end Behavioral;

