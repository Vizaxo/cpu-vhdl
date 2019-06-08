library ieee;

use ieee.std_logic_1164.all;
package logic_multi_way is
  type multi_port is array(natural range <>) of std_logic;
end package;

use ieee.std_logic_1164.all;
use work.logic_multi_way.all;
entity or_m_way is
  generic(m : positive);
  port(ins : in multi_port (m-1 downto 0); o : out std_logic);
end or_m_way;
architecture arch of or_m_way is
  component or2
    port (a, b : in std_logic; o : out std_logic);
  end component;
  signal tmp : std_logic_vector (m-1 downto 0);
begin
  tmp(0) <= ins(0);
  U0: for j in 0 to m-2 generate
    U1 : or2 port map (ins(j+1), tmp(j), tmp(j+1));
  end generate;
  o <= tmp(m-1);
end;
