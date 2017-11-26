library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux4to1 is
generic(input_width : integer);

port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d2 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d3 : STD_LOGIC_VECTOR(input_width-1 downto 0);

  sel: in STD_LOGIC_VECTOR(1 downto 0);
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end mux4to1;
 
architecture rtl of mux4to1 is
begin
process (d0,d1,d2,d3,sel) is
begin
	case sel is
		when "00" =>
			dout <= d0;
		when "01" =>
			dout <= d1;
		when "10" =>
			dout <= d2;
		when "11" =>
			dout <= d3;	
	end case;
	
--  if (sel(0) ='0' and sel(1) = '0') then
--      dout <= d0;
--  
--  elsif (sel(0) ='1' and sel(1) = '0') then
--      dout <= d1;
--  
--  elsif (sel(0) ='0' and sel(1) = '1') then
--      dout <= d2;
--  
--  else
--      dout <= d3;
--  
--  end if;
 
end process;

end rtl;
