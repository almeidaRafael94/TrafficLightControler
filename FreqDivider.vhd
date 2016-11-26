library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FreqDivider is
		generic (k : positive := 2);
		port(clkIn, reset : in std_logic;
			  clkOut : out std_logic);
end FreqDivider;

architecture Behavioral of FreqDivider is
		signal s_counter : natural;
		constant halfWay : natural := K/2-1;
begin
		process(clkIn)
		begin
			if(rising_edge(clkIn)) then
			   if(s_counter = k-1) then
					s_counter <= 0;
				else
					s_counter <= s_counter +1;
				end if;
				
				if(s_counter = k-1) then
					clkOut <= '1';
				elsif(s_counter = halfWay) then	
					clkOut <= '0';
				end if;
			end if;		
		end process;
end Behavioral;		
		