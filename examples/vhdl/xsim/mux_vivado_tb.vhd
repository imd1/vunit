--! Standard library.
library ieee;
--! Logic elements.
use ieee.std_logic_1164.all;
--! Arithmetic functions.
use ieee.numeric_std.all;
--
library std;
use std.textio.all;

--  library vunit_lib;
-- use vunit_lib.string_ops.all;
-- use vunit_lib.dictionary.all;
-- use vunit_lib.path.all;
-- use vunit_lib.print_pkg.all;
-- use vunit_lib.log_levels_pkg.all;
-- use vunit_lib.logger_pkg.all;
-- use vunit_lib.log_handler_pkg.all;
-- use vunit_lib.log_deprecated_pkg.all;
-- use vunit_lib.ansi_pkg.all;
-- use vunit_lib.checker_pkg.all;
-- use vunit_lib.check_pkg.all;
-- use vunit_lib.check_deprecated_pkg.all;
-- use vunit_lib.run_types_pkg.all;
-- use vunit_lib.run_deprecated_pkg.all;

--library xil_defaultlib;
--use xil_defaultlib.string_ops.all;
--use xil_defaultlib.codec_pkg.all;
--use xil_defaultlib.codec_builder_pkg.all;
--use xil_defaultlib.types_pkg.all;
--use xil_defaultlib.integer_vector_ptr_pkg.all;
-- use vunit_lib.queue_pkg.all;
-- use vunit_lib.core_pkg.all;
-- use vunit_lib.log_levels_pkg.all;
-- use vunit_lib.file_pkg.all;
-- use vunit_lib.log_handler_pkg.all;
-- use vunit_lib.logger_pkg.all;
-- use vunit_lib.checker_pkg.all;
-- use vunit_lib.check_pkg.all;
-- use vunit_lib.dictionary.all;
-- use vunit_lib.run_types_pkg.all;
-- use vunit_lib.runner_pkg.all;
-- use vunit_lib.run_pkg.all;


entity mux_tb is
  --vunit
--  generic (runner_cfg : string);
end;

architecture bench of mux_tb is
begin
  main : process
    type integer_vector_t is array (natural range <>) of integer;
    type integer_vector_access_t is access integer_vector_t;
    type integer_vector_access_vector_t is array (natural range <>) of integer_vector_access_t;
    type integer_vector_access_vector_access_t is access integer_vector_access_vector_t;
    variable ptrs : integer_vector_access_vector_access_t;
    variable old_ptrs : integer_vector_access_vector_access_t;
--     variable example : integer_vector_ptr_t := new_integer_vector_ptr(10);
    -- constant null_logger : logger_t := (p_data => null_ptr);
    -- variable logger : logger_t := new_logger(0, "vunit", null_logger);
  begin

  old_ptrs := new integer_vector_access_vector_t'(0 => null);
  ptrs := new integer_vector_access_vector_t'(0 to old_ptrs'length + 2**16 => null);
  for i in old_ptrs'range loop
    ptrs(i) := old_ptrs(i);
  end loop;


    -- test_runner_setup(runner, runner_cfg);
    -- while test_suite loop
    --   if run("test_alive") then
    --     -- -- info("Hello world test_alive");
    --     wait for 100 ns;
    --     -- test_runner_cleanup(runner);
    --     assert FALSE Report "********************* It's OKs 0!" severity FAILURE;
    --
    --   elsif run("test_0") then
    --     -- -- info("Hello world test_0");
    --     wait for 100 ns;
    --     -- test_runner_cleanup(runner);
    --     -- assert FALSE Report "********************* It's OKs! 1" severity FAILURE;
    --     test_runner_cleanup(runner);
    --
    --   end if;
    -- end loop;
    assert FALSE Report "********************* It's OKs! 1" severity FAILURE;

    -- while test_suite loop
    --   if run("test_alive") then
    --     std.env.finish;
    --
    --
    --   elsif run("test_0") then
    --     std.env.finish;
    --
    --   end if;
    -- end loop;
    -- std.env.finish;
  end process;

  -- main : process
  -- begin
  --   report("************************************* Init... *************************************");
  --   wait for 100 ns;
  --   report("************************************* End... *************************************");
  --   std.env.finish;
  --
  -- end process;

  -- clk_process :process
  -- begin
  --   clk <= '1';
  --   wait for clk_period/2;
  --   clk <= '0';
  --   wait for clk_period/2;
  -- end process;

end;
