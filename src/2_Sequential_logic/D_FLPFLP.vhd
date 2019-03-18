-- =====================================================================
--  Title       : D-FlipFlop
--
--  File Name   : D_FLPFLP.vhd
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

entity D_FLPFLP is
    port(
    -- System --
        CLK         : in    std_logic;                      --(p) System clock
        nRST        : in    std_logic;                      --(n) System reset

    -- Input --
        IN_S        : in    std_logic;                      --(p) Input S
        IN_D        : in    std_logic;                      --(p) Input D

    -- Output --
        OUT_Q       : out   std_logic                       --(p) Output Q
        );
end D_FLPFLP;

architecture RTL of D_FLPFLP is

-- Internal signals --
signal out_q_i      : std_logic;                            --(p) Output q

begin

-- ***********************************************************
--  Counter
-- ***********************************************************
process (CLK, nRST) begin
    if (nRST = '0') then
        out_q_i <= '0';
    elsif (CLK'event and CLK = '1') then
        if (IN_S = '1') then
            out_q_i <= IN_D;
        else
            out_q_i <= out_q_i;
        end if;
    end if;
end process;

OUT_Q <= out_q_i;


end RTL;    -- D_FLPFLP