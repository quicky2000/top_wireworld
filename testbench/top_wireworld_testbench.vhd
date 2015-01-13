--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:22:09 01/04/2011
-- Design Name:   
-- Module Name:   /media/LaCie/fpga/projects/wireworld/top_wireworld_testbench.vhd
-- Project Name:  wireworld
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_wireworld
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_wireworld_testbench IS
END top_wireworld_testbench;
 
ARCHITECTURE behavior OF top_wireworld_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_wireworld
    PORT(
         clk : IN  std_logic;
         w1a : INOUT  std_logic_vector(15 downto 0);
         w1b : INOUT  std_logic_vector(15 downto 0);
         w2c : INOUT  std_logic_vector(15 downto 0);
         rx : IN  std_logic;
         tx : INOUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rx : std_logic := '0';

	--BiDirs
   signal w1a : std_logic_vector(15 downto 0);
   signal w1b : std_logic_vector(15 downto 0);
   signal w2c : std_logic_vector(15 downto 0);
   signal tx : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_wireworld PORT MAP (
          clk => clk,
          w1a => w1a,
          w1b => w1b,
          w2c => w2c,
          rx => rx,
          tx => tx
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
      wait for clk_period;	
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
