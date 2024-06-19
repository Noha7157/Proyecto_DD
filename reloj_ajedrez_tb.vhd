--------------------------------------------------------------------------------------
-- Archivo:   reloj_ajedrez_tb.vhd
--------------------------------------------------------------------------------------
-- Autor:     Grupo
-- Email:     hola
-- Entidad:   Pontificia Universidad Católica del Perú (PUCP)
-- Facultad:  Estudios Generales Ciencias (EE.GG.CC)
-- Curso:     1IEE04 - Diseño Digital
-- Horario:   H4414
--------------------------------------------------------------------------------------
-- Historia de Versión:
-- Versión 1.0 (14 de Junio de 2024, 18:34:02 h) - Grupo
--------------------------------------------------------------------------------------
-- Descripción:
-- Testbench del circuito reloj_ajedrez
--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reloj_ajedrez_tb is
  --generic ();
end reloj_ajedrez_tb; 

architecture behavioral of reloj_ajedrez_tb is

  -- Definir constantes
  constant CLOCK_PERIOD : time := 10 ns;

  -- Definir las señales para evaluar el DUV
signal reset_n     : std_logic;
signal clk         : std_logic;
signal config      : std_logic; 
signal ini_pausa   : std_logic;
signal jugador_act : std_logic;
signal modo        : std_logic_vector(1 downto 0);
signal ver_disp    : std_logic_vector(1 downto 0);
signal display_0   : std_logic_vector(6 downto 0);
signal display_1   : std_logic_vector(6 downto 0);
signal display_2   : std_logic_vector(6 downto 0);
signal display_3   : std_logic_vector(6 downto 0);
signal display_4   : std_logic_vector(6 downto 0);
signal display_5   : std_logic_vector(6 downto 0);
  
  -- Poner el componente a evaluar
component reloj_ajedrez is
  --generic ();
  port ( reset_n      : in std_logic;
         clk          : in std_logic;
			config       : in std_logic;
			ini_pausa    : in std_logic;
			jugador_act  : in std_logic;
			modo         : in std_logic_vector(1 downto 0);
			ver_disp     : in std_logic_vector(1 downto 0);
			display_0    : out std_logic_vector(6 downto 0);
			display_1    : out std_logic_vector(6 downto 0);
			display_2    : out std_logic_vector(6 downto 0);
			display_3    : out std_logic_vector(6 downto 0);
			display_4    : out std_logic_vector(6 downto 0);
			display_5    : out std_logic_vector(6 downto 0) );
			
end component reloj_ajedrez; 

begin

  --en un circuito secuencial debe realizar lo siguiente para tener la señal del reloj
  clk <= not (clk) after CLOCK_PERIOD/2;

  --DUV: -- realizar el portmap del circuito reloj_ajedrez para verificar (Design Under Verification) 
  DUV: PORT MAP ( reset_n     => reset_n,
                  clk         => clk,
		            config      => config, 
		            ini_pausa   => ini_pausa,
		            jugador_act => jugador_act,
		            modo        => modo,
		            ver_disp    => ver_disp,
		            display_0   => display_0,
		            display_1   => display_1,
		            display_2   => display_2,
		            display_3   => display_3,
		            display_4   => display_4,
		            display_5   => display_5 )

  always: process
    --Definir variables que usará
  begin
    --recuerde que debe generar los estímulos para verificar el circuito reloj_ajedrez
    --puede usar for loop
  
  --- ESTA APAGADO EL RELOJ---
    reset_n <= '0';
	 config <= '0';
	 ini_pausa <= '0';
	 jugador_act <= '0';
	 modo <= "00";
	 ver_disp <= "00";
	 WAIT FOR 3000*CLOCK_PERIOD;
	 
	   --- PRENDIDO EL RELOJ Y ACTIVAR LA CONFIGURACION ---
    reset_n <= '1';
	 config <= '1';
	 ini_pausa <= '0';
	 jugador_act <= '0';
	 modo <= "00";
	 ver_disp <= "00";
	 WAIT FOR 2000*CLOCK_PERIOD;
	 
	   --- ELEJIMOS LA CONFIGURACION Y EMPEZAMOS EL PARTIDO con el jugador 0, el jugador 0 no sabia que hacer en todos los 5 minutos  ---
    reset_n <= '1';
	 config <= '1';
	 ini_pausa <= '1';
	 jugador_act <= '0';
	 modo <= "01";
	 ver_disp <= "00";
	 WAIT FOR 30000*CLOCK_PERIOD;
	 
	   --- el jugador 0 no sabia que hacer en todos los 5 minutos  ---
    reset_n <= '1';
	 config <= '1';
	 ini_pausa <= '1';
	 jugador_act <= '1';
	 modo <= "01";
	 ver_disp <= "10";
	 WAIT FOR 5000000*CLOCK_PERIOD;
	 
	 
	   --- hay un terremoto y se resetea y se cancela el partido ---
    reset_n <= '0';
	 config <= '1';
	 ini_pausa <= '0';
	 jugador_act <= '0';
	 modo <= "00";
	 ver_disp <= "00";
	 WAIT FOR 200000*CLOCK_PERIOD;
	 
	 
 
	 

    --la siguiente línea sirve para detener automáticamente la simulación
    assert false severity failure;
  end process always;

end behavioral;
