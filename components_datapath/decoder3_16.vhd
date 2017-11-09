library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder3_16 is
     port(
         din  : in STD_LOGIC_VECTOR(2 downto 0);
         dout : out STD_LOGIC_VECTOR(15 downto 0)
         );
end decoder3_16;


architecture decoder3_16_arc of decoder3_16 is
begin

    dout <= ("0000000000000001") when (din="000") else
            ("0000000000000010") when (din="001") else
            ("0000000000000100") when (din="010") else
            ("0000000000001000") when (din="011") else
            ("0000000000010000") when (din="100") else
            ("0000000000100000") when (din="101") else
            ("0000000001000000") when (din="110") else
            ("0000000010000000") ;

end decoder3_16_arc;
