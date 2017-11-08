library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trail_zero7 is
 port(
 	din 	: in STD_LOGIC_VECTOR(8 downto 0);
 	dout	: out STD_LOGIC_VECTOR(15 downto 0)
 	);
end trail_zero7;

architecture behav of trail_zero7 is

begin
    dout <= std_logic_vector(resize(unsigned(din), dout'length));
end behav;
