-- =====================================================================
--  Title       : 2-in AND logic
--
--  File Name   : AND_2IN.vhd
--  Project     : Sample
--  Block       : 
--  Tree        : 
--  Designer    : Suzuki,T. - HDK co.
--  Created     : 2019/03/13
--  Copyright   : 2019 HDK co.
--  License     : MIT License.
--                http://opensource.org/licenses/mit-license.php
-- =====================================================================
--  Rev.    Date        Designer    Change Description
-- ---------------------------------------------------------------------
--  v0.1    19/03/13    Suzuki,T.   First
-- =====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity AND_2IN is
    port(
        IN_A        : in    std_logic;      --(p) A input
        IN_B        : in    std_logic;      --(p) B input
        
        OUT_Y       : out   std_logic       --(p) Y output
        );
end AND_2IN;

architecture RTL of AND_2IN is

-- Internal signals --
signal out_y_i : std_logic;                 --(p) Logic output

begin

-- ***********************************************************
--  2-IN AND
-- ***********************************************************
out_y_i <= IN_A and IN_B;

OUT_Y <= out_y_i;


end RTL;    -- AND_2IN
