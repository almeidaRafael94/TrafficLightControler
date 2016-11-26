library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Itermitente is
	port (clk : in std_logic;
			SP1Itermitente : in std_logic;
			SP2Itermitente : in std_logic;
			SP1Out : out std_logic;
			SP2Out : out std_logic);
end Itermitente;

architecture Behavioral of Itermitente is
type state is (S0,S1,S2);
signal PS,NS : state;

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(not(SP1Itermitente = '0') xor (SP2Itermitente = '0') ) then
				PS <= S0;
			else
				PS <= NS;
			end if;
		end if;	
	end process;
		
	process (PS, SP1Itermitente, SP2Itermitente)
	begin
		NS <= PS;
		SP1Out <= '0';
		SP2Out <= '0';
		
		case PS is
			when S0 => if(SP1Itermitente = '1') then
								NS <= S1;
						  elsif(SP2Itermitente = '1') then
							   NS <= S2;
						  else
								NS <= S0;
						  end if;
			
			when S1 => NS <= S0;
						  SP1Out <= '1';
						  
			when S2 => NS <= S0;
						  SP2Out <= '1';
		end case;
	end process;
end Behavioral;	
		