library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is   
    port
    (
    rf_d1          	: out std_logic_vector(15 downto 0);
    rf_d2          	: out std_logic_vector(15 downto 0);
    rf_d3          	: in  std_logic_vector(15 downto 0);
    writeEnable     : in  std_logic;
    readEnable		: in  std_logic;
    rf_a1   	    : in  std_logic_vector(2 downto 0);
    rf_a2	        : in  std_logic_vector(2 downto 0);
    rf_a3   	    : in  std_logic_vector(2 downto 0);
    clk             : in  std_logic
    );
end register_file;

architecture behavioral of register_file is
type registerFile is array(0 to 7) of std_logic_vector(15 downto 0); --Eight 16-bit registers
signal registers : registerFile;
begin

    regFile: process(clk)
    begin

        if rising_edge(clk) then 
            if(writeEnable = '1') then
                registers(to_integer(unsigned(rf_a3))) <= rf_d3;
            end if;
		    
        end if;
        
        if rising_edge(clk) then
        	if(readEnable = '1') then

		        rf_d1 <= registers(to_integer(unsigned(rf_a1)));
		        rf_d2 <= registers(to_integer(unsigned(rf_a2)));
	    	end if;
	    end if;

    end process;
end behavioral;
