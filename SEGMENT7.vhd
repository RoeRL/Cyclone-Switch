LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY SEGMENT7 IS
PORT(	i			:in		std_logic_vector(3 downto 0);
		seg			:out	std_logic_vector(6 DOWNTO 0)
);
END SEGMENT7;

ARCHITECTURE SEGMENT7_ARCH OF SEGMENT7 IS
BEGIN
-----Constructing a table to decode 7 segment display ------
seg	<=	"1111110" WHEN i="0000" ELSE
		"0110000" WHEN i="0001" ELSE
		"1101101" WHEN i="0010" ELSE
		"1111001" WHEN i="0011" ELSE
		"0110011" WHEN i="0100" ELSE
		"1011011" WHEN i="0101" ELSE
		"1011111" WHEN i="0110" ELSE
		"1110000" WHEN i="0111" ELSE
		"1111111" WHEN i="1000" ELSE
		"1111011" WHEN i="1001" ELSE
		"1110111" WHEN i="1010" ELSE
		"0011111" WHEN i="1011" ELSE
		"1001110" WHEN i="1100" ELSE
		"0111101" WHEN i="1101" ELSE
		"1001111" WHEN i="1110" ELSE
		"1000111" WHEN i="1111" ELSE
		"0000000";

END SEGMENT7_ARCH;