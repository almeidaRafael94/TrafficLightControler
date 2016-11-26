library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all; 
 
entity BinUpCntRst4 is 
	port(reset : in std_logic; 
		  clk : in std_logic; 
		  enable : in std_logic; 
		  count : out std_logic); 
end BinUpCntRst4; 

architecture RTL of BinUpCntRst4 is 
	signal s_cntValue : unsigned(4 downto 0); 
begin
	process(clk)
	begin
		if(reset = '1') then
			s_cntValue <= (others => '0');
		elsif(rising_edge(clk)) then 
			if(enable = '1') then
						s_cntValue <= s_cntValue + 1;
						case std_logic_vector(s_cntValue) is     -- count = '1' apenas na transicao de clk seguinte
							when "10011" => count <= '1';		     -- ou seja, se queremos que count = '1' quando s_cntValue =  
							when "11010" => count <= '1';          --  10100 (20) temos que fazer : when "10011" (19) 
							when "11011" => s_cntValue <= (others => '0');
							when others => count <= '0';
						end case;
			else
				s_cntValue <= (others => '0');	
		   end if;
		end if;
	end process;
end RTL;
		