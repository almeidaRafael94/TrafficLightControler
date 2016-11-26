library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Semaforos_Demo is
	port(SW   : in std_logic_vector(4 downto 0);
		  LEDR : out std_logic_vector(17 downto 0);
		  LEDG : out std_logic_vector(7 downto 0);
		  CLOCK_50 : in std_logic;
		  KEY : in std_logic_vector(0 downto 0);
		  HEX7, HEX6, HEX5, HEX4 : out std_logic_vector(6 downto 0));
end Semaforos_Demo;		 

architecture RTL of Semaforos_Demo  is
constant CounterBusSize  : integer := 5;
signal s_clk : std_logic;
signal s_count : std_logic;
signal s_SP1Itermitente : std_logic;
signal s_SP2Itermitente : std_logic;
signal s_adress : std_logic_vector(1 downto 0);
signal s_reset : std_logic;
--sinais DebounceUnit

signal s_KeyClk : std_logic;
signal s_clkDebounce : std_logic;

begin
		debounce_unit : entity work.DebounceUnit(RTL)
				generic map(clkFreKHz => 50000,					-- 50000 KHz = 50 MHz
								blindmSec => 300,						-- 300 ms = 0.3 s
								inPol     => '0',						-- active low input
								outPol    => '1')  					-- active high output pulse
				port map(	reset        => SW(4),     		-- reset input
								refClk       => CLOCK_50, 			-- reference clock
								dirtyInput   => KEY(0),    		-- bounced key clock
								pulsedOut    => s_reset); 			-- debounced key clock

				s_clkDebounce <= KEY(0) when (SW(3) = '0') else 		-- select between bounced and 
	         s_keyClk;                     			 					-- debounced key clock
		
		freq_Devider : entity work.FreqDivider(Behavioral)
			generic map(k => 50000000)
			port map(clkIn => CLOCK_50,
						clkOut => s_clk,
						reset => '0');
		
		CounterUpDown : entity work.BinUpCntRst4(RTL)
		port map(clk => s_clk,
					reset => s_reset,   			 
					enable => '1',
					count => s_count);     		 
														                  
																				 
		Itermitentes : entity work.Itermitente(Behavioral)     
		port map (clk => s_clk,
					SP1Itermitente => s_SP1Itermitente,
					SP2Itermitente => s_SP2Itermitente,
					SP1Out => LEDR(16),
					SP2Out => LEDR(2));
		
		Semaforos_Logic : entity work.Semaforos(Behavioral)	
			port map(clk => s_count,
						reset => s_reset,          
						Dveiculo => SW(2),
						ButtonP1 => SW(1),
						ButtonP2 => SW(0),
						---------zona1--------
						Saidas(11) => LEDR(17),
						Saidas(10) => LEDG(7),
						Saidas(7)  => s_SP1Itermitente,
						Saidas(5)  => LEDR(15),
						Saidas(4)  => LEDR(14),
						Saidas(3)  => LEDG(6),
						---------zona2--------
						Saidas(9)  => LEDR(3),
						Saidas(8)  => LEDG(1),
						Saidas(6)  => s_SP2Itermitente,
						Saidas(2)  => LEDR(1),
						Saidas(1)  => LEDR(0),
						Saidas(0)  => LEDG(0),
						---------ROM-------
						adress_rom => s_adress);
						
			ROM : entity work.ROM_4X27(RTL)
					port map(adress => s_adress,
								dataOut(27 downto 21) => HEX7(6 downto 0),
								dataOut(20 downto 14) => HEX6(6 downto 0),
								dataOut(13 downto 7) => HEX5(6 downto 0),
								dataOut(6 downto 0) => HEX4(6 downto 0));				
end RTL;						