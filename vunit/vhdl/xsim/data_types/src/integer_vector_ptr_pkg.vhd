-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2019, Lars Asplund lars.anders.asplund@gmail.com
--
-- The purpose of this package is to provide an integer vector access type (pointer)
-- that can itself be used in arrays and returned from functions unlike a
-- real access type. This is achieved by letting the actual value be a handle
-- into a singleton datastructure of integer vector access types.
--
use std.textio.all;
use work.types_pkg.all;

package integer_vector_pkg is

  impure function load_csv (
    tam : integer;
    file_name : string
  ) return boolean;

end package;
package body integer_vector_pkg is

  impure function load_csv (
    tam : integer;
    file_name : string
  ) return boolean is
    file file_pointer:      text;
    variable line_content:  real;
    variable line_num:      line;
    variable filestatus:    file_open_status;
    variable i : integer := 0;
    variable acc : extintvec_access_vector_access_t;


    -- type integer_vector_t is array (natural range <>) of integer;
    type integer_vector_access_tt is access integer_vector;
    variable acc2 : integer_vector_access_tt;
  begin
    -- acc := new extintvec_access_vector_t'(0 to 20 => null);
    file_open (filestatus, file_pointer, file_name, READ_MODE);
    while not ENDFILE (file_pointer) loop
        readline (file_pointer, line_num);
        read (line_num, line_content);
        report("Vale: " & integer'image(i));
        i := i + 1;
    end loop;
    if (i>4) then
      acc2 := new integer_vector'(0 to 4 => 4);
    else
      acc2 := new integer_vector'(0 to 0 => 4);
    end if;
    report("length!!! = " & integer'image(acc2'length));
    report("i!!! = " & integer'image(i));
    report("acc2!!! = " & integer'image(acc2(0)));
    return true;
  end;


  -- impure function to_integer_vector_ptr (
  --   value : val_t
  -- ) return ptr_t is begin
  --   -- @TODO maybe assert that the ref is valid
  --   return (ref => value);
  -- end;
  --
  -- function decode (
  --   code : string
  -- ) return ptr_t is
  --   variable ret_val : ptr_t;
  --   variable index   : positive := code'left;
  -- begin
  --   decode(code, index, ret_val);
  --   return ret_val;
  -- end;

end package body;
