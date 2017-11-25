LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ram IS
	GENERIC
	(
		ADDRESS_WIDTH	: integer := 16;
		DATA_WIDTH	: integer := 16
	);
	PORT
	(
		clock				: IN  std_logic;
		data_in			: IN  std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
		address			: IN  std_logic_vector(ADDRESS_WIDTH - 1 DOWNTO 0);
		wr_en				: IN  std_logic;
		rd_en				: IN  std_logic;
		data_out			: OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0)
	);
END ram;

ARCHITECTURE rtl OF ram IS
	TYPE RAM IS ARRAY(0 TO 31) OF std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL ram_block : RAM := (0 => "0001110010001101", others => x"0000");

BEGIN
data_out <= ram_block(to_integer(unsigned(address(4 downto 0))));			
	PROCESS (clock, wr_en, data_in)
	BEGIN
		IF (clock'event AND clock = '1') THEN
			IF (wr_en = '1') THEN
			    ram_block(to_integer(unsigned(address(4 downto 0)))) <= data_in;
			END IF;
		END IF;
	END PROCESS;

END rtl;
