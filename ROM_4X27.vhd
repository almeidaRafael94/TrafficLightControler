library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ROM_4X27 is
	port(adress : in std_logic_vector(1 downto 0);
			dataOut : out std_logic_vector(27 downto 0));
end ROM_4X27;

architecture RTL of ROM_4X27 is
	subtype TDataWord is std_logic_vector(27 downto 0);
	type TROM is array (0 to 3) of TDataWord;
	constant c_memory : TROM := ("0011100010001101000110011100",
										  "0011100011111100111000011100",
										  "0100011001110000111000100011",
										  "0011100001110000111000111111");
	begin
		dataOut <= c_memory(to_integer(unsigned(adress)));
end RTL;		