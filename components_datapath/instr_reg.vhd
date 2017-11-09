LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity instr_reg is  
  port(clock,reset : in std_logic;
       din   		 : in std_logic_vector(15 downto 0);  
       dout  	    : out std_logic_vector(15 downto 0)
      );  
end instr_reg;

architecture behav of instr_reg is  
  begin  
	
    process (clock)  
      begin  
		if(reset = '1') then
			dout <= (others => '0');
      elsif rising_edge(clock) then  
          dout <= din;  
      end if;  
    end process;  
end behav;