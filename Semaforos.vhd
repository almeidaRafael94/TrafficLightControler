library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Semaforos is
	port (reset        : in std_logic;
			clk          : in std_logic;
			Dveiculo     : in std_logic;
			ButtonP1     : in std_logic;
			ButtonP2     : in std_logic;      
			Saidas : out std_logic_vector(11 downto 0);
			adress_rom: out std_logic_vector(1 downto 0));			
end Semaforos;

architecture Behavioral of Semaforos is
	type state is (S0,S1,S2,S3);
	signal PS,NS : state := S0;

begin
	state_register : process(clk,reset)
	begin	
		if (reset = '1') then
			PS <= S0;
		elsif(rising_edge(clk)) then 
				PS <= NS;	
		end if;	
	end process;
 
   next_state : process(PS, Dveiculo, ButtonP1, ButtonP2) 
	begin
		NS <= PS;
		case PS is
			when S0 => if(Dveiculo = '1' or ButtonP1 = '1' or ButtonP2 = '1') then
								NS <= S1;
						  elsif(Dveiculo = '0' or ButtonP1 = '0' or ButtonP2 = '0') then
								NS <= S0;
						  end if;				
			when S1 => NS <= S2;
			
			when S2 => NS <= S3;
			
			when S3 => NS <= S0;
		  
		   when others => NS <= S0;
		end case;
	end process;
		
		process_Saidas : process(PS)
			begin
				case PS is
					when S0 => Saidas <= "100101001100"; adress_rom <= "00"; 
					when S1 => Saidas <= "101000010100"; adress_rom <= "01" ;
					when S2 => Saidas <= "011010100001"; adress_rom <= "10"; 
					when S3 => Saidas <= "101000100010"; adress_rom <= "11"; 
					when others => Saidas <= "100101001100"; adress_rom <= "00";
				end case;
			end process;	
	end Behavioral;	
			
			
			
		
	

