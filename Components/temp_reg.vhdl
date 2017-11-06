LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity temp_reg is  
  generic(
	input_width : integer	
	);
  port( clock 	: in std_logic;
        en      : in std_logic; 
	      din 	  : in std_logic_vector(input_width-1 downto 0);  
        dout 	  : out std_logic_vector(input_width-1 downto 0)
);  
end temp_reg;
  
architecture behav of temp_reg is  
  begin  
    process (clock)  
      begin  
        if rising_edge(clock) and (en = '1') then  
          dout <= din;  
        end if;  
    end process;  
end behav;
