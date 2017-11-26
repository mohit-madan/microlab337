library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux2to1 is
generic(input_width : integer);
port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);

  	sel: in STD_LOGIC;
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end mux2to1;
 
architecture rtl of mux2to1 is
begin
process (d0,d1,sel) is
begin
	case sel is
		when '0' =>
			dout <= d0;
		when '1' =>
			dout <= d1;
		end case;
 
end process;

end rtl;

