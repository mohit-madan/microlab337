library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux8to1 is
generic(input_width : integer);

port(
	d0 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d1 : STD_LOGIC_VECTOR(input_width-1 downto 0);
	d2 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d3 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d4 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d5 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d6 : STD_LOGIC_VECTOR(input_width-1 downto 0);
  d7 : STD_LOGIC_VECTOR(input_width-1 downto 0);

  sel: in STD_LOGIC_VECTOR(2 downto 0);
	dout: out STD_LOGIC_VECTOR(input_width-1 downto 0)
);
end mux8to1;
 
architecture rtl of mux8to1 is
begin
process (d0,d1,d2,d3,d4,d5,d6,d7,sel) is
begin
  case sel is
    when "000" =>
      dout <= d0;
    when "001" =>
      dout <= d1;   
    when "010" =>
      dout <= d2;
    when "011" =>
      dout <= d3;
    when "100" =>
      dout <= d4;
    when "101" =>
      dout <= d5;
    when "110" =>
      dout <= d6;
    when "111" =>
      dout <= d6;
    when others =>
      NULL;
  end case;
        
end process;

end rtl;
