-- =====================================================================
--  Title       : Component
--
--  File Name   : CMPNNT.vhd
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

entity CMPNNT is
    port(
        IN_A        : in    std_logic_vector(3 downto 0);   --(p) A input
        IN_B        : in    std_logic_vector(3 downto 0);   --(p) B input
        
        OUT_X       : out   std_logic_vector(3 downto 0);   --(p) X Output
        OUT_Y       : out   std_logic_vector(3 downto 0)    --(p) Y output
        );
end CMPNNT;

architecture RTL of CMPNNT is

-- Internal signals --
signal out_x_i      : std_logic_vector(OUT_X'range);        --(p) Logic output
signal out_y_i      : std_logic_vector(OUT_Y'range);        --(p) Logic output

-- Component --
component AND_2IN
    port(
        IN_A        : in    std_logic;      --(p) A input
        IN_B        : in    std_logic;      --(p) B input

        OUT_Y       : out   std_logic       --(p) Y output
    );
end component;

begin

-- ***********************************************************
--  Component AND
-- ***********************************************************
ARY_AND_2IN : for i in IN_A'range generate
    U_AND_2IN : AND_2IN
    port map(
        IN_A    => IN_A(i),
        IN_B    => IN_B(i),

        OUT_Y   => out_x_i(i)
    );
end generate;

OUT_X <= out_x_i;


-- ***********************************************************
--  Vector AND
-- ***********************************************************
out_y_i <= IN_A and IN_B;

OUT_Y <= out_y_i;


end RTL;    -- CMPNNT
