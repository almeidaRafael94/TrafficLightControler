library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Semaforos_Demo_TestBench is
end Semaforos_Demo_TestBench;

architecture Stimulus of Semaforos_Demo_TestBench is

--Sinais contador
signal s_clk : std_logic;
signal s_reset: std_logic;
signal s_enable : std_logic;
signal s_count : std_logic;

--sinais Semaforos
signal s_Dveiculo : std_logic;
signal s_ButtonP1, s_ButtonP2 : std_logic;
signal s_saidas : std_logic_vector(11 downto 0);
signal s_adress : std_logic_vector(1 downto 0);

--sinais Itermitentes
signal s_SP1Out, s_SP2Out : std_logic;

-- sinais ROM
signal s_dispalysHex : std_logic_vector(27 downto 0);


begin
	
	uutCounter : entity work.BinUpCntRst4(RTL)
			port map(clk => s_clk,
						reset => s_reset,
						enable => s_enable,
						count => s_count);
						
	uutIntermitente : entity work.Itermitente(Behavioral)		
					port map(clk => s_clk,
								SP1Itermitente => s_saidas(7),
								SP2Itermitente => s_saidas(6),
								SP1Out => s_SP1Out,
								SP2Out => s_SP2Out);

	uutSemaforos : entity work.Semaforos(Behavioral)
			port map(clk => s_clk,
						reset => s_reset,
						Dveiculo => s_Dveiculo,
						ButtonP1 => s_ButtonP1,
						ButtonP2 => s_ButtonP2,
						Saidas => s_saidas,
						adress_rom => s_adress);
						
	 uutROM : entity work.ROM_4X27(RTL)
			port map(adress => s_adress,
						dataOut => s_dispalysHex);

	
	clock_process : process
							begin
								s_clk <= '0'; wait for 50 ns;
								s_clk <= '1'; wait for 50 ns;
							end process;
		
	stimulus_process: process 
								begin
								   s_enable <= '0';
									s_reset <= '1';
									s_Dveiculo <= '0';
									s_ButtonP1 <= '0';
									s_ButtonP2 <= '0';
									wait for 200 ns;
									
									s_reset <= '0';
									s_enable <= '1';
									wait for 300 ns;
									
									s_Dveiculo <= '1';
									wait for 300 ns;
									
									s_Dveiculo <= '0';
									s_ButtonP1 <= '1';
									wait for 300 ns;
									
									s_ButtonP1 <= '0';
									s_ButtonP2 <= '1';
									wait for 300 ns;
									
									s_ButtonP2 <= '0';
									wait for 300 ns;
									
									s_reset <= '1';
									wait for 100 ns;
							end process;	
end Stimulus;							
						

