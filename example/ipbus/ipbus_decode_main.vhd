-- Address decode logic for ipbus fabric
-- 
-- This file has been AUTOGENERATED from the address table - do not hand edit
-- 
-- We assume the synthesis tool is clever enough to recognise exclusive conditions
-- in the if statement.
-- 
-- Dave Newbold, February 2011

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

package ipbus_decode_main is

  constant IPBUS_SEL_WIDTH: positive := 1;
  subtype ipbus_sel_t is std_logic_vector(IPBUS_SEL_WIDTH - 1 downto 0);
  function ipbus_sel_main(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t;

-- START automatically  generated VHDL the Fri Jul  3 13:37:08 2020 
  constant N_SLV_COMMON_IDVERSION: integer := 0;
  constant N_SLAVES: integer := 1;
-- END automatically generated VHDL

    
end ipbus_decode_main;

package body ipbus_decode_main is

  function ipbus_sel_main(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t is
    variable sel: ipbus_sel_t;
  begin

-- START automatically  generated VHDL the Fri Jul  3 13:37:08 2020 
    if    std_match(addr, "--------------------------------") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_COMMON_IDVERSION, IPBUS_SEL_WIDTH)); -- common_IdVersion / base 0x00000000 / mask 0x00000000
-- END automatically generated VHDL

    else
        sel := ipbus_sel_t(to_unsigned(N_SLAVES, IPBUS_SEL_WIDTH));
    end if;

    return sel;

  end function ipbus_sel_main;

end ipbus_decode_main;

