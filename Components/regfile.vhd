library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is   
    port
    (
    outA          : out std_logic_vector(63 downto 0);
    outB          : out std_logic_vector(63 downto 0);
    input         : in  std_logic_vector(63 downto 0);
    writeEnable   : in std_logic;
    regASel       : in std_logic_vector(5 downto 0);
    regBSel       : in std_logic_vector(5 downto 0);
    writeRegSel   : in std_logic_vector(5 downto 0);
    clk           : in std_logic
    );
end register_file;

architecture behavioral of register_file is
type registerFile is array(0 to 15) of std_logic_vector(63 downto 0);
signal registers : registerFile;
begin

    regFile: process(clk)
    begin
        if rising_edge(clk) then 
            if(writeEnable = '1') then
                registers(to_integer(unsigned(writeRegSel))) <= input;
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
