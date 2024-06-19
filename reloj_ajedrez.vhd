--------------------------------------------------------------------------------------
-- Archivo:   reloj_ajedrez.vhd
--------------------------------------------------------------------------------------
-- Autor:     
-- Email:     
-- Entidad:   Pontificia Universidad Católica del Perú (PUCP)
-- Facultad:  Estudios Generales Ciencias (EE.GG.CC)
-- Curso:     1IEE04 - Diseño Digital
-- Horario:   H4414
--------------------------------------------------------------------------------------
-- Historia de Versión:
-- Versión 1.0 (14 de Junio de 2024, 20:02:32 h) - 
--------------------------------------------------------------------------------------
-- Descripción:
-- Reloj de ajedrez
--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.my_subcircuits.all;

entity reloj_ajedrez is
  --generic ();
  port(signal reset_n		: in	std_logic;
		 signal clk				: in	std_logic;
		 signal config			: in	std_logic;
		 signal ini_pausa		: in	std_logic;
		 signal jugador_act	: in	std_logic;
		 signal modo			: in	std_logic_vector(1 downto 0);
		 signal ver_disp		: in	std_logic_vector(1 downto 0);
		 
		 signal display_0		: out	std_logic_vector(6 downto 0);
		 signal display_1		: out	std_logic_vector(6 downto 0);
		 signal display_2		: out	std_logic_vector(6 downto 0);
		 signal display_3		: out	std_logic_vector(6 downto 0);
		 signal display_4		: out	std_logic_vector(6 downto 0);
		 signal display_5		: out	std_logic_vector(6 downto 0));
		 
end reloj_ajedrez; 

architecture structural_0 of reloj_ajedrez is

	-- Divisor de frecuencia
	signal en			: std_logic;
	
	-- Reg / Reloj
	signal modo_reg				: std_logic_vector(1 downto 0);
	
	-- FSM salidas
	signal ini_pausa_j0	: std_logic;
	signal borrar_j0		: std_logic;
	signal ini_pausa_j1	: std_logic;
	signal borrar_j1		: std_logic;
	signal en_sel			: std_logic;
	-- FSM / reloj
	signal min_value_j0	: std_logic;
	signal min_value_j1	: std_logic;
	
	-- Salidas reloj 0
	signal display_0_j0			: std_logic_vector(6 downto 0);
	signal display_1_j0			: std_logic_vector(6 downto 0);
	signal display_2_j0			: std_logic_vector(6 downto 0);
	signal display_3_j0			: std_logic_vector(6 downto 0);
	signal display_4_j0			: std_logic_vector(6 downto 0);
	signal display_5_j0			: std_logic_vector(6 downto 0);

		-- Salidas reloj 1
	signal display_0_j1			: std_logic_vector(6 downto 0);
	signal display_1_j1			: std_logic_vector(6 downto 0);
	signal display_2_j1			: std_logic_vector(6 downto 0);
	signal display_3_j1			: std_logic_vector(6 downto 0);
	signal display_4_j1			: std_logic_vector(6 downto 0);
	signal display_5_j1			: std_logic_vector(6 downto 0);
	
	--Salidas muxs
	signal dis0			: std_logic_vector(6 downto 0);
	signal dis1			: std_logic_vector(6 downto 0);
	signal dis2			: std_logic_vector(6 downto 0);
	signal dis3			: std_logic_vector(6 downto 0);
	signal dis4			: std_logic_vector(6 downto 0);
	signal dis5			: std_logic_vector(6 downto 0);

	
	
	

begin


	
	DIV : divisor_freq generic map(N  			=> 10,
											 BUS_WIDTH	=> 4)
							 port map(reset_n => reset_n,
										 clk     => clk,
										 clk_o   => en);
										 
	REG : reg_d port map (datain => modo,
										 clk     => clk,
										 en   => en_sel,
										 reset  => reset_n,
										 dataout => modo_reg);
										 
	MOORE : fsm port map(en => en,
								reset_n => reset_n,
								min_value_j0 => min_value_j0,
								min_value_j1 => min_value_j1,
								clk => clk,
								config => config,
								ini_pausa => ini_pausa,
								jugador_act => jugador_act,
								ini_pausa_j0 => ini_pausa_j0,
								ini_pausa_j1 => ini_pausa_j1,
								borrar_j0 => borrar_j0,
								borrar_j1 => borrar_j1,
								en_sel => en_sel);
	REL_0 : reloj generic map ( M => 1000,
								DF => 10)
			port map ( reset_n => reset_n,
							clk => clk,
							sel => modo_reg,
							ini_pausa => ini_pausa_j0,
							borrar => borrar_j0,
							display_0 => display_0_j0,
							display_1 => display_1_j0,
							display_2 => display_2_j0,
							display_3 => display_3_j0,
							display_4 => display_4_j0,
							display_5 => display_5_j0,
							min_value => min_value_j0);
	REL_1 : reloj	generic map ( M => 1000,
								DF => 10)
			port map ( reset_n => reset_n,
							clk => clk,
							sel => modo_reg,
							ini_pausa => ini_pausa_j1,
							borrar => borrar_j1,
							display_0 => display_0_j1,
							display_1 => display_1_j1,
							display_2 => display_2_j1,
							display_3 => display_3_j1,
							display_4 => display_4_j1,
							display_5 => display_5_j1,
							min_value => min_value_j1);
							
	MUX0 : mux4a1 port map (sel => ver_disp,
									A => display_0_j0,
									B => "1000000",
									C => display_0_j1,
									D => "1000000",
									f => dis0);
									
									
	MUX1 : mux4a1 port map (sel => ver_disp,
									A => display_1_j0,
									B => "1000000",
									C => display_1_j1,
									D => "1000000",
									f => dis1);
									
	MUX2 : mux4a1 port map (sel => ver_disp,
									A => display_2_j0,
									B => "1000000",
									C => display_2_j1,
									D => "1000000",
									f => dis2);	

	MUX3 : mux4a1 port map (sel => ver_disp,
									A => display_3_j0,
									B => "1111111",
									C => display_3_j1,
									D => "1111111",
									f => dis3);
									
	MUX4 : mux4a1 port map (sel => ver_disp,
									A => display_4_j0,
									B => "1111111",
									C => display_4_j1,
									D => "1111111",
									f => dis4);
									
	MUX5 : mux4a1 port map (sel => ver_disp,
									A => display_5_j0,
									B => "1111111",
									C => display_5_j1,
									D => "1111111",
									f => dis5);									
							 
	display_0 <=  dis0;
	display_1 <=  dis1;
	display_2 <=  dis2;
	display_3 <=  dis3;
	display_4 <=  dis4;	
	display_5 <=  dis5;	

end structural_0;

--architecture structural_1 of reloj_ajedrez is
--
--
--
--begin
--
--
--
--end structural_1;
