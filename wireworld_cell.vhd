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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.my_package.all;

entity wireworld_cell is
  generic (
    init_state : state_type := t_copper
    );
  Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         neighbours : in  STD_LOGIC_VECTOR (7 downto 0);
         electron_head : out  STD_LOGIC;
         electron_queue : out  STD_LOGIC);
end wireworld_cell;

architecture Behavioral of wireworld_cell is
  signal state : state_type := init_state;
  signal next_state : state_type;
begin
  --state process
  process(clk,reset)
  begin
    if reset = '1' then
      state <= init_state;
    elsif rising_edge(clk) then
      state <= next_state;
    end if;
  end process;
  
  --state transition
  process(state,neighbours)
    variable a : integer := 0;
  begin
    case state is
      when t_copper => next_state <= t_electron_head ;
                       a:=0;
                       for index in 0 to 7 loop
                         if neighbours(index) = '1' then 
                           a := a + 1;
                         else
                           a := a;
                         end if;
                       end loop;
                       if a = 1 or a = 2 then
                         next_state <= t_electron_head ;
                       else
                         next_state <= t_copper;
                       end if;
      when t_electron_head => next_state <= t_electron_queue;
      when t_electron_queue => next_state <= t_copper;
    end case;
  end process;
  
  --output function
  electron_head <= '1' when state = t_electron_head else '0';
  electron_queue <= '1' when state = t_electron_queue else '0';
  
end Behavioral;

