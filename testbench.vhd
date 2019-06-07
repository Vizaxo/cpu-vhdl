library ieee;
use ieee.std_logic_1164.all;

entity test_adder is
end test_adder;
architecture behavior of test_adder is
    component adder
      PORT(a, b, cin : in std_logic;
           s, cout : out std_logic
           );
    end component;

    signal a, b, cin, s, cout : std_logic;
begin
   adder_: adder port map (a, b, cin, s, cout);
   test_adder: process
     type pattern_ty is record
       a, b, cin, s, cout: std_logic;
     end record;
     type pattern_array is array (natural range <>) of pattern_ty;
     constant patterns : pattern_array :=
       (('0', '0', '0', '0', '0'),
        ('0', '0', '1', '1', '0'),
        ('0', '1', '0', '1', '0'),
        ('0', '1', '1', '0', '1'),
        ('1', '0', '0', '1', '0'),
        ('1', '0', '1', '0', '1'),
        ('1', '1', '0', '0', '1'),
        ('1', '1', '1', '1', '1'));
   begin
     for i in patterns'range loop
       a <= patterns(i).a;
       b <= patterns(i).b;
       cin <= patterns(i).cin;
       wait for 1 ns;
       assert s = patterns(i).s report "Adder: wrong sum" severity error;
       assert cout = patterns(i).cout report "Adder: wrong carry" severity error;
     end loop;
     assert false report "Adder passed all tests" severity note;
     wait;
   end process;
end;

use ieee.std_logic_1164.all;
entity test_mux is
end test_mux;
architecture behaviour of test_mux is
  component mux
    port(a, b, sel : in std_logic; o : out std_logic);
  end component;
  signal a, b, sel, o : std_logic;
begin
   mux_: mux port map (a, b, sel, o);
   test_mux: process
     type pattern_ty is record
       a, b, sel, o : std_logic;
     end record;
     type pattern_array is array (natural range <>) of pattern_ty;
     constant patterns : pattern_array :=
       (('0', '0', '0', '0'),
        ('0', '0', '1', '0'),
        ('0', '1', '0', '0'),
        ('0', '1', '1', '1'),
        ('1', '0', '0', '1'),
        ('1', '0', '1', '0'),
        ('1', '1', '0', '1'),
        ('1', '1', '1', '1'));
   begin
     for i in patterns'range loop
       a <= patterns(i).a;
       b <= patterns(i).b;
       sel <= patterns(i).sel;
       o <= patterns(i).o;
       wait for 1 ns;
       assert o = patterns(i).o report "Mux: wrong output" severity error;
     end loop;
     assert false report "Mux: passed all tests" severity note;
     wait;
   end process;
end;

use ieee.std_logic_1164.all;
entity test_dmux is
end test_dmux;
architecture behaviour of test_dmux is
  component dmux
    port(i, sel : in std_logic; a, b : out std_logic);
  end component;
  signal i, sel, a, b : std_logic;
begin
   dmux_: dmux port map (i, sel, a, b);
   test_dmux: process
     type pattern_ty is record
       i, sel, a, b : std_logic;
     end record;
     type pattern_array is array (natural range <>) of pattern_ty;
     constant patterns : pattern_array :=
       (('0', '0', '0', '0'),
        ('0', '1', '0', '0'),
        ('1', '0', '1', '0'),
        ('1', '1', '0', '1'));
   begin
     for j in patterns'range loop
       i <= patterns(j).i;
       sel <= patterns(j).sel;
       a <= patterns(j).a;
       b <= patterns(j).b;
       wait for 1 ns;
       assert a = patterns(j).a report "Dmux: wrong a" severity error;
       assert b = patterns(j).b report "Dmux: wrong b" severity error;
     end loop;
     assert false report "Dmux: passed all tests" severity note;
     wait;
   end process;
end;

use ieee.std_logic_1164.all;
entity test_notn is
  generic(n : natural);
end test_notn;
architecture behaivour of test_notn is
  component notn
    generic(n : natural);
    port(a : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
  end component;
  signal a, o : std_logic_vector(n-1 downto 0);
begin
  notn_: notn generic map (n) port map (a, o);
  test_notn: process
    type pattern_ty is record
      a, o : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_ty;
    constant patterns : pattern_array :=
      (('0', '1'),
       ('1', '0'));
  begin
    for j in 0 to n-1 loop
      for i in patterns'range loop
        a(j) <= patterns(i).a;
        o(j) <= patterns(i).o;
        wait for 1 ns;
        assert o(j) = patterns(i).o report "notn: wrong output" severity error;
        assert false report "notn: passed all tests" severity note;
      end loop;
      wait;
    end loop;
  end process;
end;

entity test_all is
end test_all;
architecture behaviour of test_all is
  component test_adder end component;
  component test_mux end component;
  component test_dmux end component;
  component test_notn
    generic (n : natural);
  end component;
begin
  U0: test_adder;
  U1: test_mux;
  U2: test_dmux;
  U3: for j in 0 to 32 generate
    U4: test_notn generic map (n => 1);
  end generate;
end;
