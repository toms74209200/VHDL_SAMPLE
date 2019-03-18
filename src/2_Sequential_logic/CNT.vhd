-- =====================================================================
--  Title       : Counter
--
--  File Name   : CNT.vhd
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

entity CNT is
    port(
    -- System --
        CLK         : in    std_logic;                      --(p) System clock
        nRST        : in    std_logic;                      --(n) System reset

    -- Output --
        OUT_CNT     : out   std_logic_vector(3 downto 0)    --(p) Output count
        );
end CNT;

architecture RTL of CNT is

-- Internal signals --
signal cnt_i        : std_logic_vector(OUT_CNT'range);      --(p) Output count

begin

-- ***********************************************************
--  Counter
-- ***********************************************************
process (CLK, nRST) begin
    if (nRST = '0') then
        cnt_i <= (others => '0');
    elsif (CLK'event and CLK = '1') then
        if (cnt_i = X"F") then
            cnt_i <= (others => '0');
        else
            cnt_i <= cnt_i + 1;
        end if;
    end if;
end process;

OUT_CNT <= cnt_i;


end RTL;    -- CNT