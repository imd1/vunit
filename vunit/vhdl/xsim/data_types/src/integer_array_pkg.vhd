-- This Source Code Form is subjeinteger_array_pkgct to the terms of the Mozilla Public
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

package integer_array_pkg is
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
    max_width : integer;
    max_height : integer;
    is_1d : boolean;
    is_2d : boolean;
    x_pointer : integer;
    y_pointer : integer;
    data : integer_vector_access_vector_access_t;
  end record;

  impure function new_1d (
    length    : integer := 0;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t;

  impure function new_2d (
    width     : integer := 0;
    height    : integer := 0;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t;

  impure function load_csv (
    file_name : string;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t;

  impure function get (
    arr : integer_array_t;
    idx : integer
  ) return integer;

  impure function get (
    arr : integer_array_t;
    x,y : integer
  ) return integer;
  -- procedure set(idx : integer; value : integer);
  -- procedure set(x,y : integer; value : integer);

  procedure append (
    variable arr : inout integer_array_t;
    value        : integer
  );

  procedure save_csv (
    arr       : integer_array_t;
    file_name : string
  );

end package;

package body integer_array_pkg is

  impure function new_1d (
    length    : integer := 0;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t is
    variable aux : integer_array_t;
    variable acc : integer_vector_access_vector_access_t;
  begin
    acc := new integer_vector_access_vector_t'(0 to 2*524288-1 => null);
    for x in 0 to length-1 loop
      acc(x) := new integer_vector_t'(0 to 0 => 0);
    end loop;
    aux.data   := acc;
    aux.height := length;
    aux.width  := 1;
    aux.is_1d := true;
    aux.is_2d := false;
    aux.x_pointer := 0;
    aux.y_pointer := length - 1;
    return aux;
  end;

  impure function new_2d (
    width     : integer := 0;
    height    : integer := 0;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t is
    variable aux : integer_array_t;
    variable acc : integer_vector_access_vector_access_t;
  begin
    acc := new integer_vector_access_vector_t'(0 to 2*524288-1 => null);
    for x in 0 to height-1 loop
      acc(x) := new integer_vector_t'(0 to 32768-1 => 0);
    end loop;
    aux.data   := acc;
    aux.height := height;
    aux.width  := width;
    aux.is_1d := false;
    aux.is_2d := true;
    aux.x_pointer := 0;
    aux.y_pointer := 0;
    return aux;
  end;

  impure function get (
    arr : integer_array_t;
    idx : integer
  ) return integer is begin
    assert idx<arr.height report "1d X=" & integer'image(idx) & " > array height=" & integer'image(arr.height) severity error;
    return arr.data(idx)(0);
  end;

  impure function get (
    arr  : integer_array_t;
    x, y : integer
  ) return integer is begin
    assert x<arr.width report "2d X=" & integer'image(x) & " > array width=" & integer'image(arr.width) severity error;
    assert y<arr.height report "2d Y=" & integer'image(y) & " > array height=" & integer'image(arr.height) severity error;
    return arr.data(y)(x);
  end;

  procedure append (
    variable arr : inout integer_array_t;
    value        : integer
  ) is begin
    if (arr.is_1d = true) then
      arr.y_pointer := arr.y_pointer + 1;
      arr.height    := arr.height + 1;
      arr.data(arr.y_pointer) := new integer_vector_t'(0 to 0 => value);
    end if;
  end;

  impure function load_csv_internal (
    file_name : string;
    bit_width : natural := 32;
    is_signed : boolean := true
  ) return integer_array_t is
      file     fread   : text;
      variable l       : line;
      variable tmp     : integer;
      variable ctmp    : character;
      variable is_good : boolean;

      variable acc : integer_vector_access_vector_access_t;
      variable m : integer := 0;
      variable n : integer := 0;

      variable aux : integer_array_t;
      constant max_width  : integer := 32768;
      constant max_height : integer := 2*524288;
    begin
      aux.max_width  := max_width;
      aux.max_height := max_height;
      acc := new integer_vector_access_vector_t'(0 to 2*524288-1 => null);
      file_open(fread, file_name, read_mode);
      while not endfile(fread) loop
        acc(m) := new integer_vector_t'(0 to 32768-1 => 0);
        readline(fread, l);
        n := 0;
        loop
          read(l, tmp, is_good);
          exit when not is_good;
          acc(m)(n) := tmp;
          read(l, ctmp, is_good);
          n := n + 1;
          exit when not is_good;
        end loop;
        m := m + 1;
      end loop;
      file_close(fread);

      -- 1d
      if (n = 1) then
        aux.height := m;
        aux.width  := 1;
        aux.is_1d := true;
        aux.is_2d := false;
        aux.y_pointer := n;
        aux.x_pointer := 1;
      -- 2d
      else
        aux.height := m;
        aux.width  := n;
        aux.is_1d := false;
        aux.is_2d := true;
        aux.y_pointer := m;
        aux.x_pointer := n;
      end if;
      aux.data := acc;
      return aux;
  end;

  impure function load_csv (
    file_name : string;
    bit_width : natural := 32;
    is_signed : boolean := true)
  return integer_array_t is
    variable aux : integer_array_t;
  begin
    return load_csv_internal(file_name, bit_width, is_signed);
  end function;

  procedure save_csv (
    arr       : integer_array_t;
    file_name : string
  ) is
    file fwrite : text;
    variable l : line;
  begin
    if (arr.is_1d = false) then
      file_open(fwrite, file_name, write_mode);
      for y in 0 to arr.height-1 loop
        for x in 0 to arr.width-1 loop
          write(l, integer'image(get(arr, x, y)));
          if x /= arr.width-1 then
            write(l, ',');
          end if;
        end loop;
        writeline(fwrite, l);
      end loop;
      file_close(fwrite);
    else
      file_open(fwrite, file_name, write_mode);
      for y in 0 to arr.height-1 loop
        write(l, integer'image(get(arr,y)));
        writeline(fwrite, l);
      end loop;
      file_close(fwrite);
    end if;
  end;

end package body;
