-- =====================================================================
--  Title       : State machine
--
--  File Name   : RAM.vhd
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

entity RAM is
    generic(
        AW          : integer := 10;                             -- Address length
        DW          : integer := 8                               -- Data length
    );
    port(
    -- System --
        CLK         : in    std_logic;                          --(p) System clock
        nRST        : in    std_logic;                          --(n) Reset

    -- Control --
        WR          : in    std_logic;                          --(p) Memory write pulse
        ADDR        : in    std_logic_vector(AW-1 downto 0);    --(p) Memory address

    -- Data --
        WDAT        : in    std_logic_vector(DW-1 downto 0);    --(p) Write data
        RDAT        : out   std_logic_vector(DW-1 downto 0)     --(p) Read data
        );
end RAM;

architecture RTL of RAM is

-- Internal signals --
signal dat_i        : std_logic_vector(WDAT'range);             --(p) Data

-- Data array --
type AryRamTyp      is array (0 to 2**AW-1) of std_logic_vector(WDAT'range);
signal ary_ram      : AryRamTyp;                                --(p) RAM data array

begin
-- ***********************************************************
--  RAM
-- ***********************************************************
process (CLK) begin
    if (CLK'event and CLK = '1') then
        if (WR = '1') then
            ary_ram(CONV_INTEGER(ADDR)) <= WDAT;
        end if;
    end if;
end process;

process (CLK, nRST) begin
    if (nRST = '0') then
        dat_i <= (others => '0');
    elsif (CLK'event and CLK = '1') then
        dat_i <= ary_ram(CONV_INTEGER(ADDR));
    end if;
end process;

RDAT <= dat_i;


end RTL;    -- RAM