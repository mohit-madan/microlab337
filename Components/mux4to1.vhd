library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux4to1 is
port(
	d0 : STD_LOGIC_VECTOR(15 downto 0);
	d1 : STD_LOGIC_VECTOR(15 downto 0);
  d2 : STD_LOGIC_VECTOR(15 downto 0);
  d3 : STD_LOGIC_VECTOR(15 downto 0);

  sel: in STD_LOGIC_VECTOR(1 downto 0);
	dout: out STD_LOGIC
);
end mux4to1;
 
architecture rtl of mux4to1 is
begin
process (din,sel) is
begin
  if (sel(0) ='0' and sel(1) = '0') then
      dout <= d0;
  
  elsif (sel(0) ='1' and sel(1) = '0') then
      dout <= d1;
  
  elsif (sel(0) ='0' and sel(1) = '1') then
      dout <= d2;
  
  else
      dout <= d3;
  
  end if;
 
end process;

end rtl;
