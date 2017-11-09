library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TwosComplement is
port (
  input: in std_logic_vector(15 downto 0);
  output: out std_logic_vector(15 downto 0)
);

end entity TwosComplement;
architecture Behave of TwosComplement is
begin
output <= std_logic_vector(unsigned(not input) + 1);
end Behave;

