library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sign_ext8 is
 port(
 	din 	: in STD_LOGIC_VECTOR(7 downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end sign_ext8;

architecture behav of sign_ext8 is

begin
    dout <= std_logic_vector(resize(signed(din), dout'length));
end behav;