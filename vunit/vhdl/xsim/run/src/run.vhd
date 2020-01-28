-- Run package provides test runner functionality to VHDL 2002+ testbenches
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2019, Lars Asplund lars.anders.asplund@gmail.com

-- use work.logger_pkg.all;
-- use work.log_levels_pkg.all;
-- use work.log_handler_pkg.all;
-- use work.ansi_pkg.enable_colors;
use work.string_ops.all;
use work.dictionary.all;
-- use work.path.all;
use work.core_pkg;
use std.textio.all;

package body run_pkg is

  impure function run (
    constant name : string)
    return boolean is
  begin
    core_pkg.test_start(name);
    -- check_if_test(runner_cfg);
    return true;
    -- if get_test_suite_completed(runner_state) then
    --   set_running_test_case(runner_state, "");
    --   return false;
    -- elsif get_run_all(runner_state) then
    --   if not has_run(name) then
    --     register_run(name);
    --     info(runner_trace_logger, "Test case: " & name);
    --     if has_active_python_runner(runner_state) then
    --       core_pkg.test_start(name);
    --     end if;
    --     set_running_test_case(runner_state, name);
    --     return true;
    --   end if;
    -- elsif get_test_case_name(runner_state, get_active_test_case_index(runner_state)) = name then
    --   info(runner_trace_logger, "Test case: " & name);
    --   if has_active_python_runner(runner_state) then
    --     core_pkg.test_start(name);
    --   end if;
    --   set_running_test_case(runner_state, name);
    --   return true;
    -- end if;
    --
    -- set_running_test_case(runner_state, "");
    -- return false;
  end;

  -- procedure notify(signal runner : inout runner_sync_t;
  --                  idx : natural := runner_event_idx) is
  -- begin
  --   if runner(idx) /= runner_event then
  --     runner(idx) <= runner_event;
  --     wait until runner(idx) = runner_event;
  --     runner(idx) <= idle_runner;
  --   end if;
  -- end procedure notify;

  procedure test_runner_setup (
    signal runner : inout runner_sync_t;
    constant runner_cfg : in string := runner_cfg_default) is
    -- variable test_case_candidates : lines_t;
    -- variable selected_enabled_test_cases : line;
  begin
    -- -- fake active python runner key is only used during testing in tb_run.vhd
    -- -- to avoid creating vunit_results file
    -- set_active_python_runner(runner_state,
    --                          (active_python_runner(runner_cfg) and not has_key(runner_cfg, "fake active python runner")));
    --
    -- if has_active_python_runner(runner_state) then
      core_pkg.setup(output_path(runner_cfg) & "vunit_results");
    -- end if;
    --
    --
    -- if has_active_python_runner(runner_state) then
    --   hide(runner_trace_logger, display_handler, info);
    -- end if;
    --
    -- if has_key(runner_cfg, "use_color") and boolean'value(get(runner_cfg, "use_color")) then
    --   enable_colors;
    -- end if;
    --
    -- if not active_python_runner(runner_cfg) then
    --   set_stop_level(failure);
    -- end if;
    --
    -- set_phase(runner_state, test_runner_setup);
    -- runner(runner_exit_status_idx) <= runner_exit_with_errors;
    -- notify(runner);
    --
    -- trace(runner_trace_logger, "Entering test runner setup phase.");
    -- entry_gate(runner);
    --
    -- if selected_enabled_test_cases /= null then
    --   deallocate(selected_enabled_test_cases);
    -- end if;
    --
    -- if has_key(runner_cfg, "enabled_test_cases") then
    --   write(selected_enabled_test_cases, get(runner_cfg, "enabled_test_cases"));
    -- else
    --   write(selected_enabled_test_cases, string'("__all__"));
    -- end if;
    -- test_case_candidates := split(replace(selected_enabled_test_cases.all, ",,", "__comma__"), ",");
    --
    -- set_cfg(runner_state, runner_cfg);
    --
    -- set_run_all(runner_state, strip(test_case_candidates(0).all) = "__all__");
    -- if get_run_all(runner_state) then
    --   set_num_of_test_cases(runner_state, unknown_num_of_test_cases_c);
    -- else
    --   set_num_of_test_cases(runner_state, 0);
    --   for i in 1 to test_case_candidates'length loop
    --     if strip(test_case_candidates(i - 1).all) /= "" then
    --       inc_num_of_test_cases(runner_state);
    --
    --       set_test_case_name(runner_state,
    --                          get_num_of_test_cases(runner_state),
    --                          replace(strip(test_case_candidates(i - 1).all), "__comma__", ","));
    --     end if;
    --   end loop;
    -- end if;
    -- exit_gate(runner);
    -- set_phase(runner_state, test_suite_setup);
    -- notify(runner);
    -- trace(runner_trace_logger, "Entering test suite setup phase.");
    -- entry_gate(runner);
  end test_runner_setup;

  procedure test_runner_cleanup (
    signal runner: inout runner_sync_t;
    external_failure : boolean := false;
    allow_disabled_errors : boolean := false;
    allow_disabled_failures : boolean := false;
    fail_on_warning : boolean := false) is
  begin
  --   failure_if(runner_trace_logger, external_failure, "External failure.");
  --
  --   set_phase(runner_state, test_runner_cleanup);
  --   notify(runner);
  --   trace(runner_trace_logger, "Entering test runner cleanup phase.");
  --   entry_gate(runner);
  --   exit_gate(runner);
  --   set_phase(runner_state, test_runner_exit);
  --   notify(runner);
  --   trace(runner_trace_logger, "Entering test runner exit phase.");
  --
  --   if not final_log_check(allow_disabled_errors => allow_disabled_errors,
  --                          allow_disabled_failures => allow_disabled_failures,
  --                          fail_on_warning => fail_on_warning) then
  --     return;
  --   end if;
  --
    runner(runner_exit_status_idx) <= runner_exit_without_errors;
  --   notify(runner);
  --
  --   if has_active_python_runner(runner_state) then
      core_pkg.test_suite_done;
  --   end if;
  --
  --   if not p_simulation_exit_is_disabled(runner_state) then
      core_pkg.stop(0);
  --   end if;

  end procedure test_runner_cleanup;


  -- impure function check_if_test (
  --   constant runner_cfg : string)
  --   return string is
  --     variable tests : lines_t;
  --     variable tests_str : string;
  --     variable num_tests : integer := 0;
  -- begin
  --   tests_str := get(runner_cfg, "output path");
  --   for i in 0 to tests_str'length-1 loop
  --     if ( tests_str(i) = ',' ) then
  --       num_tests := num_tests + 1;
  --     end if;
  --   end loop;
  --
  --   report("Numero de tests: " & integer'image(num_tests));
  -- end;

  impure function output_path (
    constant runner_cfg : string)
    return string is
  begin
    return get(runner_cfg, "output path");
    -- if has_key(runner_cfg, "output path") then
    --   return get(runner_cfg, "output path");
    -- else
    --   return "";
    -- end if;
  end;

  -- impure function enabled_test_cases (
  --   constant runner_cfg : string)
  --   return test_cases_t is
  -- begin
  --   if has_key(runner_cfg, "enabled_test_cases") then
  --     return get(runner_cfg, "enabled_test_cases");
  --   else
  --     return "__all__";
  --   end if;
  -- end;
  --
  -- impure function tb_path (
  --   constant runner_cfg : string)
  --   return string is
  -- begin
  --   if has_key(runner_cfg, "tb path") then
  --     return get(runner_cfg, "tb path");
  --   else
  --     return "";
  --   end if;
  -- end;

end package body run_pkg;
