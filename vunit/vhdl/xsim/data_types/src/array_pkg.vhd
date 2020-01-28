-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2020, Lars Asplund lars.anders.asplund@gmail.com

-- @TODO > 32-bit ieee signed/unsigned

use std.textio.all;
use work.types_pkg.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package array_pkg is
  type integer_vector_ptr_t is record
    ref : index_t;
  end record;
  constant null_integer_vector_ptr : integer_vector_ptr_t := (ref => -1);

  type integer_array_t is record
    -- All fields are considered private, use functions to access these
    length : integer;
    width : integer;
    height : integer;
    depth : integer;
    bit_width : natural;
    is_signed : boolean;
    lower_limit : integer;
    upper_limit : integer;
    data : integer_vector_access_vector_access_t;
  end record;

  type array_t is protected
      impure function height return integer;
      impure function width return integer;
      impure function depth return integer;
      impure function length return integer;
      impure function bit_width return integer;
      impure function is_signed return boolean;
      impure function lower_limit return integer;
      impure function upper_limit return integer;
      procedure load_csv(file_name : string;
                         bit_width : natural := 32;
                         is_signed : boolean := true);
      impure function get(idx : integer) return integer;
      impure function get(x,y : integer) return integer;
      procedure set(idx : integer; value : integer);
      procedure set(x,y : integer; value : integer);
  end protected;

end package;

package body array_pkg is

  type array_t is protected body
      variable my_arr : integer_array_t;
      variable height_var : integer := 1;
      variable width_var : integer := 1;
      variable depth_var : integer := 1;
      variable length_var : integer := 1;

      impure function length return integer is
          begin
            return length_var;
          end function;

          impure function width return integer is
          begin
            return width_var;
          end function;

          impure function height return integer is
          begin
            return height_var;
          end function;

          impure function depth return integer is
          begin
            return depth_var;
          end function;

          impure function bit_width return integer is
          begin
            return my_arr.bit_width;
          end function;

          impure function is_signed return boolean is
          begin
            return my_arr.is_signed;
          end function;

          impure function lower_limit return integer is
          begin
            return my_arr.lower_limit;
          end function;

          impure function upper_limit return integer is
          begin
            return my_arr.upper_limit;
          end function;

          impure function get(idx : integer) return integer is
          begin
            return my_arr.data(idx)(0);
          end function;

          impure function get(x, y : integer) return integer is
          begin
            return my_arr.data(x)(y);
          end function;

          procedure set(idx : integer; value : integer)  is
          begin
            my_arr.data(idx)(0) := value;
          end procedure;

          procedure set(x,y : integer; value : integer)  is
          begin
            my_arr.data(x)(y) := value;
          end procedure;

          -- procedure set_height(value : integer)  is
          -- begin
          --   height_var := value;
          -- end procedure;

          impure function load_csv_internal (
            file_name : string;
            bit_width : natural := 32;
            is_signed : boolean := true
          ) return integer_vector_access_vector_access_t is
            file     fread   : text;
            variable l       : line;
            variable tmp     : integer;
            variable ctmp    : character;
            variable is_good : boolean;

            variable acc : integer_vector_access_vector_access_t;
            variable m : integer := 0;
            variable n : integer := 0;
            begin
              height_var := 5;
              -- width_var  := 0;
              acc := new integer_vector_access_vector_t'(0 to 524288-1 => null);
              file_open(fread, file_name, read_mode);
              while not endfile(fread) loop
                acc(m) := new integer_vector_t'(0 to 128-1 => 0);
                readline(fread, l);
                -- height_var := height_var + 1;
                n := 0;
                loop
                  read(l, tmp, is_good);
                  exit when not is_good;
                  -- width_var := width_var + 1;
                  acc(m)(n) := tmp;
                  read(l, ctmp, is_good);
                  exit when not is_good;
                  n := n + 1;
                end loop;
                m := m + 1;
              end loop;
              -- set_height(10);
              file_close(fread);
              return acc;
          end;

          procedure load_csv(file_name : string;
                             bit_width : natural := 32;
                             is_signed : boolean := true) is
            variable is_good : boolean := false;
          begin
            -- deallocate(my_arr);
            my_arr.data := load_csv_internal(file_name, bit_width, is_signed);
          end procedure;
  end protected body;


end package body;
