library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is   
    port
    (
    rf_d1          : out std_logic_vector(15 downto 0);
    rf_d2          : out std_logic_vector(15 downto 0);
    rf_d3          : in  std_logic_vector(15 downto 0);
    writeEnable   : in std_logic;
    regASel       : in std_logic_vector(2 downto 0);
    regBSel       : in std_logic_vector(2 downto 0);
    rf_a3   : in std_logic_vector(3 downto 0);
    clk           : in std_logic
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
                registers(to_integer(unsigned(writeRegSel))) <= input1;
            end if;
            if falling_edge(clk) then
                outA <= registers(to_integer(unsigned(regASel)));
                outB <= registers(to_integer(unsigned(regBSel)));
            end if;
        end if;
        if falling_edge(clk) then
                outA <= registers(to_integer(unsigned(regASel)));
                outB <= registers(to_integer(unsigned(regBSel)));
        end if;
    end process;
end behavioral;
