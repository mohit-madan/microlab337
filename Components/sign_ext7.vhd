library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sign_ext7 is
 port(
 	din 	: in STD_LOGIC_VECTOR(6 downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end sign_ext7;

architecture behav of sign_ext7 is

begin
    dout <= std_logic_vector(resize(signed(din), dout'length));
end behav;
