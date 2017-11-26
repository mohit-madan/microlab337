LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity registers is  
  port( 
  clock,reset 	: in std_logic;
        en      : in std_logic; 
	din 	  : in std_logic;  
        dout 	  : out std_logic
);  
end registers;
  
architecture behav of registers is  
  begin  
    process (clock, reset, din, en)  
      begin  
		if reset = '1' then
			dout <= '0' ;
			
        elsif rising_edge(clock) and (en = '1') then  
          dout <= din;  
        end if;  
    end process;  
end behav;
