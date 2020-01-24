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

library vunit_lib;
-- use vunit_lib.string_ops.all;
-- use vunit_lib.codec_pkg.all;
-- use vunit_lib.codec_builder_pkg.all;
use vunit_lib.types_pkg.all;
-- use vunit_lib.external_string_pkg.all;
-- use vunit_lib.string_ptr_pkg.all;
use vunit_lib.integer_vector_ptr_pkg.all;
-- use vunit_lib.queue_pkg.all;
-- use vunit_lib.core_pkg.all;
-- use vunit_lib.log_levels_pkg.all;
-- use vunit_lib.file_pkg.all;
-- use vunit_lib.log_handler_pkg.all;
use vunit_lib.logger_pkg.all;
-- use vunit_lib.checker_pkg.all;
-- use vunit_lib.check_pkg.all;
-- use vunit_lib.dictionary.all;
use vunit_lib.run_types_pkg.all;
use vunit_lib.runner_pkg.all;
use vunit_lib.run_pkg.all;

entity mux_tb is
  --vunit
  generic (runner_cfg : string);
end;

architecture bench of mux_tb is
begin
  main : process

  -- procedure sample_reallocate_ptrs (
  --   acc    : inout integer_vector_access_vector_access_t;
  --   length : integer
  -- ) is
  --   variable old : integer_vector_access_vector_access_t := acc;
  -- begin
  --   acc := new integer_vector_access_vector_t'(0 to length-1 => null);
  --   acc(0) := new integer_vector_t'(0 to length-1 => 0);
  -- end;













  -- variable example : integer_vector_ptr_t := new_integer_vector_ptr(10);



    -- variable val : integer;
    -- constant null_logger : logger_t := (p_data => null_ptr);
    -- variable logger : logger_t := new_logger(0, "vunit", null_logger);
    -- variable logger : logger_t;
    -- variable runner_state : runner_t := get_runner_state;
    -- variable data : integer_vector_ptr_t := runner_state.p_data;
    -- variable ptrs : integer_vector_access_vector_access_t;

    variable pu : boolean;
  begin

    -- set(example,0,5);
    -- report("Valor --> " & integer'image(get(example,0)) );



    -- sample_reallocate_ptrs(ptrs,10);
    -- ptrs(0)(0) := 3;
    -- runner_state.p_data.ref := 0;
    -- report(integer'image(to_integer(new_integer_vector_ptr)));

    -- report("****************************************");
    -- report(integer'image(3));
    -- report(integer'image(to_integer(new_integer_vector_ptr)));
    --
    -- logger := (p_data => new_integer_vector_ptr(9));
    -- set(logger.p_data, 0, 0);
    -- pepito := 20;
    -- aux := new_integer_vector_ptr(10);
    -- ptrs(0) := new integer_vector_t'(0 to 9 => 0);
    -- st.ptrs(0)(0) := 2;

    -- ptrs := new integer_vector_access_vector_access_t'(0 => null);


    -- set(aux, 0, 0);

    -- init_test_case_iteration(runner_state);
    -- runner_state.p_data

    -- set(example,0,4);


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
    pu := test_suite;
        assert FALSE Report "********************* It's OKs! 1" severity FAILURE;
    --   end if;
    -- end loop;

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
