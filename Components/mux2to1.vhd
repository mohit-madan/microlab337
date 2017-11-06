library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux2to1 is
generic(input_width := integer);
port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);

  	sel: in STD_LOGIC;
	dout: out STD_LOGIC
);
end mux2to1;
 
architecture rtl of mux2to1 is
begin
process (d0,d1,sel) is
begin
  if (sel ='0') then
      dout <= d0;
  else
      dout <= d1;
  end if;
 
end process;

end rtl;

