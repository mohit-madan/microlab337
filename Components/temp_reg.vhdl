LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity temp_reg is  
  port(clock, din : in std_logic;  
      dout : out std_logic);  
end temp_reg;  
architecture behav of temp_reg is  
  begin  
    process (clock)  
      begin  
        if rising_edge(clock) then  
          dout <= din;  
        end if;  
    end process;  
end behav;