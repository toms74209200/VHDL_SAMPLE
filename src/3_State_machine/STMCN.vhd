-- =====================================================================
--  Title       : State machine
--
--  File Name   : STMCN.vhd
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

entity STMCN is
    port(
    -- System --
        CLK         : in    std_logic;                      --(p) System clock
        nRST        : in    std_logic;                      --(n) System reset

    -- Control --
        INIT_STR    : in    std_logic;                      --(p) Initialization start pulse
        ST_STR      : in    std_logic;                      --(p) State machine start pulse
        PLS         : in    std_logic;                      --(p) State machine control pulse

    -- Output --
        MODE        : out   std_logic_vector(2 downto 0)    --(p) Out state
        );
end STMCN;

architecture RTL of STMCN is

-- Parameter --
constant CntNum     : integer := 9;                         -- State machine count

-- Internal signals --
signal mode_i       : std_logic_vector(MODE'range);         --(p) Out state
signal cnt_i        : integer range 0 to CntNum;            --(p) State machine count

-- State machine --
type main_state is (
    WakeUp,     -- Device wake up
    Init,       -- Initialization
    Idle,       -- Idle
    StateA,     -- State A
    StateB,     -- State B
    TurnAround  -- Turn around idle
);
signal main_st      : main_state;

begin
--
-- ***********************************************************
--  State machine
-- ***********************************************************
process (CLK, nRST) begin
    if (nRST = '0') then
        main_st <= WakeUp;
    elsif (CLK'event and CLK = '1') then
        case (main_st) is
        -- Device wake up --
            when WakeUp =>
                if (INIT_STR = '1') then
                    main_st <= Init;
                else
                    main_st <= main_st;
                end if;
        -- Initialization --
            when Init =>
                main_st <= Idle;
        -- State A --
            when StateA =>
                if (INIT_STR = '1') then
                    main_st <= Init;
                elsif (cnt_i = CntNum) then
                    main_st <= StateB;
                else
                    main_st <= main_st;
                end if;
        -- State B --
            when StateB =>
                if (INIT_STR = '1') then
                    main_st <= Init;
                elsif (PLS = '1') then
                    main_st <= TurnAround;
                else
                    main_st <= main_st;
                end if;
        -- Turn around --
            when TurnAround =>
                main_st <= Idle;
        -- Other --
            when others =>
                main_st <= Idle;
        end case;
    end if;
end process;


-- ***********************************************************
--  Out state
-- ***********************************************************
process (CLK, nRST) begin
    if (nRST = '0') then
        mode_i <= (others => '0');
    elsif (CLK'event and CLK = '1') then
        case (main_st) is
            when WakeUp     => mode_i <= "000";
            when Init       => mode_i <= "001";
            when Idle       => mode_i <= "010";
            when StateA     => mode_i <= "011";
            when StateB     => mode_i <= "100";
            when TurnAround => mode_i <= "101";
            when others     => mode_i <= "111";
        end case;
    end if;
end process;

MODE <= mode_i;


-- ***********************************************************
--  Counter
-- ***********************************************************
process (CLK, nRST) begin
    if (nRST = '0') then
        cnt_i <= 0;
    elsif (CLK'event and CLK = '1') then
        if (cnt_i = CntNum) then
            cnt_i <= 0;
        else
            cnt_i <= cnt_i + 1;
        end if;
    end if;
end process;


end RTL;    -- STMCN