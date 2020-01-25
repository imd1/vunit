--! Standard library.
library ieee;
--! Logic elements.
use ieee.std_logic_1164.all;
--! Arithmetic functions.
use ieee.numeric_std.all;
--
library std;
use std.textio.all;


library vunit_lib;
use vunit_lib.run_pkg.all;
use vunit_lib.core_pkg;

library tb_lib;
use tb_lib.adder;

entity mux_tb is
  --vunit
  generic (runner_cfg : string);
end;

architecture bench of mux_tb is
    component adder
    generic(DATA_WIDTH : positive := 5);
    port (
    clk : in std_logic;
    a   : in  std_logic_vector(4 downto 0);
    b   : in  std_logic_vector(4 downto 0);
    x   : out std_logic_vector(4 downto 0)
    );
  end component;

  -- clock period
  constant clk_period : time := 5 ns;
  -- Signal ports
  signal clk: std_logic := '0';
  signal a: std_logic_vector(4 downto 0);
  signal b: std_logic_vector(4 downto 0);
  signal x: std_logic_vector(4 downto 0) ;
begin

    uut: adder
      generic map (DATA_WIDTH => 5)
      port map ( clk => clk,
                 a  => a,
                 b  => b,
                 x  => x );

  main : process
  begin

    test_runner_setup(runner, runner_cfg);


    



    -- a <= "00000";
    -- b <= "00000";
    -- wait for 10*clk_period;
    --
    -- report("Output = " & integer'image(to_integer(unsigned(x))));
    --
    -- wait for 10*clk_period;
    --
    -- a <= "00010";
    -- b <= "00001";
    -- wait for 10*clk_period;
    --
    -- report("Output = " & integer'image(to_integer(unsigned(x))));
    --
    -- wait for 10*clk_period;


    std.env.stop;
    test_runner_cleanup(runner);
  end process;

  clk_process :process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process;

end;
