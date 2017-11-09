library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sign_ext is
 generic(
 	input_width : integer --input width is variable while output width remains constant
 	);

 port(
 	din 	: in STD_LOGIC_VECTOR(15 - input_width downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end sign_ext;

architecture rtl of sign_ext is

begin
    dout <= std_logic_vector(resize(signed(din), dout'length));
end rtl;