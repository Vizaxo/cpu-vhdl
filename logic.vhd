library ieee;

use ieee.std_logic_1164.all;
entity not1 is
  port(a : in std_logic; o : out std_logic);
end not1;
architecture rtl of not1 is
begin
  o <= not a;
end rtl;

use ieee.std_logic_1164.all;
entity and2 is
  port (
    a : in  std_logic;
    b : in  std_logic;
    o : out std_logic
    );
end and2;
architecture rtl of and2 is
begin
  o <= a and b;
end rtl;

use ieee.std_logic_1164.all;
entity xor2 is
  port (
    a : in  std_logic;
    b : in  std_logic;
    o : out std_logic
    );
end xor2;
architecture rtl of xor2 is
begin
  o <= a xor b;
end rtl;

use ieee.std_logic_1164.all;
entity or2 is
  port (
    a : in  std_logic;
    b : in  std_logic;
    o : out std_logic
    );
end or2;
architecture rtl of or2 is
begin
  o <= a or b;
end rtl;

use ieee.std_logic_1164.all;
entity half_adder is
  port (
    i0 : in std_logic;
    i1 : in std_logic;
    o : out std_logic;
    c : out std_logic);
end half_adder;
architecture structural of half_adder is
  component and2
    port (a, b : in std_logic;
          o : out std_logic);
  end component;
  component xor2
    port (a, b : in std_logic;
          o : out std_logic);
  end component;
begin
  U0: xor2 port map (i0, i1, o);
  U1: and2 port map (i0, i1, c);
end structural;

use ieee.std_logic_1164.all;
entity adder is
  port (
    a, b, cin : in std_logic;
    s, cout : out std_logic);
end adder;
architecture structural of adder is
  component half_adder
    port (i0, i1 : in std_logic;
          o, c : out std_logic);
  end component;
  component or2
    port (a, b : in std_logic; o : out std_logic);
  end component;
  signal x, y, z : std_logic;
begin
  U0: half_adder port map (a, b, x, y);
  U1: half_adder port map (x, cin, s, z);
  U2: or2 port map (z, y, cout);
end structural;

use ieee.std_logic_1164.all;
entity mux is
  port (a, b, sel : in std_logic;
        o : out std_logic);
end mux;
architecture structural of mux is
  component and2
    port (a, b : in std_logic; o : out std_logic);
  end component;
  component not1
    port (a : in std_logic; o : out std_logic);
  end component;
  component or2
    port (a, b : in std_logic; o : out std_logic);
  end component;
  signal a1, b1, notsel : std_logic;
begin
  U0: and2 port map (a, notsel, a1);
  U1: not1 port map (sel, notsel);
  U2: and2 port map (b, sel, b1);
  U3: or2 port map (a1, b1, o);
end structural;

