-- n-bit versions of standard logic gates

library ieee;

use ieee.std_logic_1164.all;
entity notn is
  generic(n : natural);
  port(a : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
end notn;
architecture arch of notn is
  component not1
    port (a : in std_logic; o : out std_logic);
  end component;
begin
  foo: for i in (n-1) downto 0 generate
    U1: not1 port map (a(i), o(i));
  end generate;
end;

use ieee.std_logic_1164.all;
entity andn is
  generic(n : natural);
  port(a, b : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
end andn;
architecture arch of andn is
  component and2
    port (a, b : in std_logic; o : out std_logic);
  end component;
begin
  foo: for i in (n-1) downto 0 generate
    U0: and2 port map (a(i), b(i), o(i));
  end generate;
end;

use ieee.std_logic_1164.all;
entity orn is
  generic(n : natural);
  port(a, b : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
end orn;
architecture arch of orn is
  component or2
    port (a, b : in std_logic; o : out std_logic);
  end component;
begin
  foo: for i in (n-1) downto 0 generate
    U0: or2 port map (a(i), b(i), o(i));
  end generate;
end;
