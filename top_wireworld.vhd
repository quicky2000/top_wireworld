--
--    This file is part of top_wireworld
--    Copyright (C) 2011  Julien Thevenon ( julien_thevenon at yahoo.fr )
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.my_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_wireworld is
	port(
		clk : in std_logic;
		w1a : inout std_logic_vector(15 downto 0);
		w1b : inout std_logic_vector(15 downto 0);
		w2c : inout std_logic_vector(15 downto 0);
		rx : in std_logic;
		tx : inout std_logic
	);
end top_wireworld;


architecture Behavioral of top_wireworld is
--	component wireworld_cell is
--	generic (
--		init_state : state_type := t_copper
--	);
--    Port ( clk : in STD_LOGIC;
--	   reset : in STD_LOGIC;
--	   neighbours : in  STD_LOGIC_VECTOR (7 downto 0);
--          electron_head : out  STD_LOGIC;
--           electron_queue : out  STD_LOGIC);
--	end component;
	signal reset : std_logic;
	signal to_0 : std_logic_vector (7 downto 0);
	signal to_1 : std_logic_vector (7 downto 0);
	signal to_2 : std_logic_vector (7 downto 0);
	signal from_0 : std_logic;
	signal from_1 : std_logic;
	signal from_2 : std_logic;
begin
--	to_0 <= (0 => from_1,others => '0');
--	to_1 <= (0 => from_0,others => '0');
	to_0 <= (0=> from_2, others => '0');
	to_1 <= (0=> from_0, others => '0');
	to_2 <= (0=> from_1, others => '0');
	cell_0 : entity work.wireworld_cell
	generic map( init_state => t_electron_head )
		port map (
				clk => clk,
				reset => reset,
				neighbours => to_0,
				electron_head => from_0,
				electron_queue => w1a(2)
			 );

	cell_1 : entity work.wireworld_cell
		port map (
				clk => clk,
				reset => reset,
				neighbours => to_1,
				electron_head => from_1,
				electron_queue => w1a(6)
			 );
			 
	cell_2 : entity work.wireworld_cell
		port map (
				clk => clk,
				reset => reset,
				neighbours => to_2,
				electron_head => from_2,
				electron_queue => w1a(10)
			 );
        w1a(0) <= from_0;
	w1a(4) <= from_1;
	w1a(8) <= from_2;
	reset <= '0';
end Behavioral;

