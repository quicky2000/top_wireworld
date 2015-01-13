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
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.my_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY wireworld_cell_testbench IS
END wireworld_cell_testbench;
 
ARCHITECTURE behavior OF wireworld_cell_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT wireworld_cell
		generic (
		init_state : state_type
		);
     PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         neighbours : IN  std_logic_vector(7 downto 0);
         electron_head : OUT  std_logic;
         electron_queue : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal neighbours : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal electron_head : std_logic;
   signal electron_queue : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: wireworld_cell generic map(init_state=> t_electron_head) PORT MAP (
          clk => clk,
          reset => reset,
          neighbours => neighbours,
          electron_head => electron_head,
          electron_queue => electron_queue
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*2;
		neighbours <= (0 => '1', others => '0');
      wait for clk_period;
		neighbours <= (others => '0');
      wait for clk_period * 2;
		neighbours <= (0 to 3 => '1', others => '0');
      wait for clk_period;
		neighbours <= (others => '0');
      wait for clk_period * 2;
		neighbours <= (0 to 1 => '1', others => '0');
      wait for clk_period;
		neighbours <= (others => '0');
      wait for clk_period * 2;

      -- insert stimulus here 

      wait;
   end process;

END;
