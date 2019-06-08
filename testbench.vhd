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
       wait for 1 ns;
       assert o = patterns(i).o report "Mux: wrong output" severity error;
     end loop;
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
       wait for 1 ns;
       assert a = patterns(j).a report "Dmux: wrong a" severity error;
       assert b = patterns(j).b report "Dmux: wrong b" severity error;
     end loop;
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
        wait for 1 ns;
        assert o(j) = patterns(i).o report "notn: wrong output" severity error;
      end loop;
    end loop;
    wait;
  end process;
end;

use ieee.std_logic_1164.all;
entity test_andn is
  generic(n : natural);
end test_andn;
architecture behaivour of test_andn is
  component andn
    generic(n : natural);
    port(a, b : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
  end component;
  signal a, b, o : std_logic_vector(n-1 downto 0);
begin
  andn_: andn generic map (n) port map (a, b, o);
  test_andn: process
    type pattern_ty is record
      a, b, o : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_ty;
    constant patterns : pattern_array :=
      (('0', '0', '0'),
       ('0', '1', '0'),
       ('1', '0', '0'),
       ('1', '1', '1'));
  begin
    for j in 0 to n-1 loop
      for i in patterns'range loop
        a(j) <= patterns(i).a;
        b(j) <= patterns(i).b;
        wait for 1 ns;
        assert o(j) = patterns(i).o report "andn: wrong output" severity error;
      end loop;
    end loop;
    wait;
  end process;
end;

use ieee.std_logic_1164.all;
entity test_orn is
  generic(n : natural);
end test_orn;
architecture behaivour of test_orn is
  component orn
    generic(n : natural);
    port(a, b : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
  end component;
  signal a, b, o : std_logic_vector(n-1 downto 0);
begin
  orn_: orn generic map (n) port map (a, b, o);
  test_orn: process
    type pattern_ty is record
      a, b, o : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_ty;
    constant patterns : pattern_array :=
      (('0', '0', '0'),
       ('0', '1', '1'),
       ('1', '0', '1'),
       ('1', '1', '1'));
  begin
    for j in 0 to n-1 loop
      for i in patterns'range loop
        a(j) <= patterns(i).a;
        b(j) <= patterns(i).b;
        wait for 1 ns;
        assert o(j) = patterns(i).o report "orn: wrong output" severity error;
      end loop;
    end loop;
    wait;
  end process;
end;

use ieee.std_logic_1164.all;
entity test_xorn is
  generic(n : natural);
end test_xorn;
architecture behaivour of test_xorn is
  component xorn
    generic(n : natural);
    port(a, b : in std_logic_vector(n-1 downto 0); o : out std_logic_vector(n-1 downto 0));
  end component;
  signal a, b, o : std_logic_vector(n-1 downto 0);
begin
  xorn_: xorn generic map (n) port map (a, b, o);
  test_xorn: process
    type pattern_ty is record
      a, b, o : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_ty;
    constant patterns : pattern_array :=
      (('0', '0', '0'),
       ('0', '1', '1'),
       ('1', '0', '1'),
       ('1', '1', '0'));
  begin
    for j in 0 to n-1 loop
      for i in patterns'range loop
        a(j) <= patterns(i).a;
        b(j) <= patterns(i).b;
        wait for 1 ns;
        assert o(j) = patterns(i).o report "xorn: wrong output" severity error;
      end loop;
    end loop;
    wait;
  end process;
end;

use ieee.std_logic_1164.all;
entity test_muxn is
  generic(n : natural);
end test_muxn;
architecture behaivour of test_muxn is
  component muxn
    generic(n : natural);
    port(a, b : in std_logic_vector(n-1 downto 0);
         sel : in std_logic;
         o : out std_logic_vector(n-1 downto 0));
  end component;
  signal a, b, o : std_logic_vector(n-1 downto 0);
  signal sel : std_logic;
begin
  muxn_: muxn generic map (n) port map (a, b, sel, o);
  test_muxn: process
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
    for j in 0 to n-1 loop
      for i in patterns'range loop
        a(j) <= patterns(i).a;
        b(j) <= patterns(i).b;
        sel <= patterns(i).sel;
        wait for 1 ns;
        assert o(j) = patterns(i).o report "muxn: wrong output" severity error;
      end loop;
    end loop;
    wait;
  end process;
end;

use ieee.std_logic_1164.all;
use work.logic_multi_way.all;
entity test_or_m_way is
  constant width : natural := 4;
end test_or_m_way;
architecture behaivour of test_or_m_way is
  component or_m_way
    generic(m : natural);
    port(ins : in multi_port (width-1 downto 0); o : out std_logic);
  end component;
  signal ins : multi_port (width-1 downto 0);
  signal o : std_logic;

  signal a : multi_port (0 downto 0);
  signal o_1 : std_logic;
begin
  or_m_way_: or_m_way generic map (width) port map (ins, o);
  test_or_m_way: process
    type pattern_ty is record
      ins : multi_port(width-1 downto 0);
      o : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_ty;
    constant patterns : pattern_array :=
      ((('0', '0', '0', '0'), '0'),
       (('1', '0', '0', '0'), '1'),
       (('0', '1', '0', '0'), '1'),
       (('0', '0', '1', '0'), '1'),
       (('0', '0', '0', '1'), '1'),
       (('1', '0', '0', '1'), '1'),
       (('0', '1', '1', '0'), '1'),
       (('1', '1', '1', '0'), '1'),
       (('1', '1', '1', '1'), '1'),
       (('1', '1', '1', '1'), '1'));
  begin
    for i in patterns'range loop
      for j in 3 downto 0 loop
        ins(j) <= patterns(i).ins(j);
      end loop;
      wait for 1 ns;
      assert o = patterns(i).o report "or_m_way: wrong output" severity error;
    end loop;
    wait;
  end process;

  or_m_way_1: or_m_way generic map (1) port map (a, o_1);
  test_or_m_way_1: process
    begin
      a(0) <= '0';
      wait for 1 ns;
      assert o_1 = '0' report "or_m_way (1-wide): expected 0; got 1" severity error;
      a(0) <= '1';
      wait for 1 ns;
      assert o_1 = '1' report "or_m_way (1-wide): expected 1; got 0" severity error;
      wait;
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
  component test_andn
    generic (n : natural);
  end component;
  component test_orn
    generic (n : natural);
  end component;
  component test_xorn
    generic (n : natural);
  end component;
  component test_muxn
    generic (n : natural);
  end component;
  component test_or_m_way end component;
begin
  U0: test_adder;
  U1: test_mux;
  U2: test_dmux;
  U3: for j in 0 to 16 generate
    U4: test_notn generic map (n => j);
    U5: test_andn generic map (n => j);
    U6: test_orn generic map (n => j);
    U7: test_xorn generic map (n => j);
    U8: test_muxn generic map (n => j);
  end generate;
  U9: test_or_m_way;
end;
