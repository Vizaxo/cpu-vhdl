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

END;

entity test_all is
end test_all;
architecture behaviour of test_all is
  component test_adder end component;
  component test_mux end component;
begin
  U0: test_adder;
  U1: test_mux;
end;
