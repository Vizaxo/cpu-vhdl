-- n-bit versions of standard logic gates

library ieee;

use ieee.std_logic_1164.all;
entity notn is
  generic(n : natural);
  port(a : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
end notn;
architecture arch of notn is
begin
  foo: for i in (n-1) downto 0 generate
    o(i) <= not a(i);
  end generate;
end;
