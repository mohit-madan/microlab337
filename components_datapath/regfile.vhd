library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity regfile is   
    port
    (
    rf_d1          	: out std_logic_vector(15 downto 0);
    rf_d2          	: out std_logic_vector(15 downto 0);
    rf_d3          	: in  std_logic_vector(15 downto 0);
    writeEnable     : in  std_logic;
    readEnable1		: in  std_logic;
    readEnable2     : in  std_logic;
    rf_a1   	    : in  std_logic_vector(2 downto 0);
    rf_a2	        : in  std_logic_vector(2 downto 0);
    rf_a3   	    : in  std_logic_vector(2 downto 0);
    clk,reset             : in  std_logic
    );
end regfile;

architecture behavioral of regfile is
type registerFile is array(0 to 7) of std_logic_vector(15 downto 0); --Eight 16-bit registers
signal registers : registerFile := (others => (others => '0') ) ;
begin

    regFile: process(clk,reset,writeEnable)
    begin
			
			if (reset = '1') then
			registers <= (others => (others => '0') ) ;
			elsif rising_edge(clk) and (writeEnable = '1') then 
					registers(to_integer(unsigned(rf_a3))) <= rf_d3;
			end if ;

    end process;
	rf_d1 <= registers(to_integer(unsigned(rf_a1))); 
	rf_d2 <= registers(to_integer(unsigned(rf_a2))); 

	end behavioral;
