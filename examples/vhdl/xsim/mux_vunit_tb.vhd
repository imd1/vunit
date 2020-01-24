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

entity mux_tb is
  --vunit
  generic (runner_cfg : string);
end;

architecture bench of mux_tb is
  file file_VECTORS : text;
begin
  main : process
  begin

    -- core_pkg.setup(output_path(runner_cfg) & "vunit_results");
    test_runner_setup(runner, runner_cfg);
    test_runner_cleanup(runner);



    report("*******************************");
    -- report(output_path(runner_cfg));
    -- file_open(file_VECTORS, output_path(runner_cfg) & "/output_pepito_results.txt", write_mode);

    -- report((runner_cfg));
    -- assert FALSE Report "********************* It's OKs! 1" severity FAILURE;
    -- std.env.finish;
  end process;

end;
