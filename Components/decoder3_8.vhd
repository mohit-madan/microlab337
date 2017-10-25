library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder3_8 is
     port(
         din : in STD_LOGIC_VECTOR(2 downto 0);
         dout : out STD_LOGIC_VECTOR(7 downto 0)
         );
end decoder3_8;


architecture decoder3_8_arc of decoder3_8 is
begin

    dout <= ("00000001") when (din="000") else
            ("00000010") when (din="001") else
            ("00000100") when (din="010") else
            ("00001000") when (din="011") else
            ("00010000") when (din="100") else
            ("00100000") when (din="101") else
            ("01000000") when (din="110") else
            ("10000000") ;

end decoder3_8_arc;