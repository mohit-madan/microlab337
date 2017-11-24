library IEEE;
use IEEE.STD_LOGIC_1164.all;      
use ieee.numeric_std.all;

entity priorityEncoder is
     port(
         din 	: in STD_LOGIC_VECTOR(15 downto 0);
         dout 	: out STD_LOGIC_VECTOR(2 downto 0);
	 valid  : out STD_LOGIC :='1'

         );
end priorityEncoder;


architecture priority_enc_arc of priorityEncoder is
begin

    pri_enc : process (din) is
    begin
        if (din(0)='1') then
            dout <= "000";

        elsif (din(1)='1') then
            dout <= "001";

        elsif (din(2)='1') then
            dout <= "010";

        elsif (din(3)='1') then
            dout <= "011";

        elsif (din(4)='1') then
            dout <= "100";

        elsif (din(5)='1') then
            dout <= "101";

        elsif (din(6)='1') then
            dout <= "110";

        elsif (din(7)='1') then
            dout <= "111";
	else
	    valid <= '0';
        
	end if;
	
	
    end process pri_enc;
end priority_enc_arc;
