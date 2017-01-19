library IEEE;

use IEEE.std_logic_1164.all;

use IEEE.std_logic_unsigned.all;

use IEEE.std_logic_arith.all;

-- Designed by Yoshinao Kobayashi 20161225

-- Fmax 327.33MHz Restricted Fmax 250MHz

-- Total combination function 51

-- Dedecated registers 26

-- Plane ALgorithm

entity Collatz is

port(

    SysClk  :in std_logic:='0';

    reset   :in std_logic:='0';

    Go  :in std_logic:='0';

    Din     :in std_logic_vector(7 downto 0):=(others => '0');

    monA    :out std_logic_vector(15 downto 0):=(others => '0');

    Dout    :out std_logic_vector(7 downto 0):=(others => '0');

    monC    :out std_logic_vector(1 downto 0):=(others => '0');

    Done    :out std_logic:='0'

    );

end Collatz;

architecture RTL of Collatz is

    signal Areg     :std_logic_vector(15 downto 0) :=(others => '0') ;

    signal Breg     :std_logic_vector(7 downto 0) :=(others => '0') ;

    signal CCycle   :std_logic_vector(1 downto 0) :="00";

    signal NoData   :std_logic:='0';

    signal ToBeEnd  :std_logic:='0';

begin

    process begin

    wait until rising_edge(SysClk);

    if reset = '1'then

        CCycle <= "00";

    else

        case CCycle(0) is

        when '0' =>

            if Go='1' then

                CCycle(0)<='1';

            end if ;

        when '1' =>

            if (CCycle(1)='1' and ToBeEnd='1') then

                CCycle(0) <= '0';

            end if ;

        when others =>

            CCycle(0)<='0';

        end case ;

        CCycle(1) <= CCycle(0);

    end if;

    if (CCycle = "01") then

        Areg <= "00000000" & Din;

    elsif CCycle="11" then

        if (Areg(0)='0' or NoData='1') then

            Areg <= ('0' & Areg(15 downto 1));

        else

            Areg <= (Areg(14 downto 0) & '1') + Areg;

        end if ;

    end if;

    if CCycle="01" then

    BReg <= "00000000";

    elsif(CCycle ="11" and NoData='0') then

    BReg <= BReg + 1;

    end if;

    end process;

    Done <= '1' when CCycle = "10" else '0';

    Dout <= Breg;

    monA <= Areg;

    monC <= CCycle;

    NoData <='1' when (Areg = "0000000000000000" or Areg = "0000000000000001") else '0';

    ToBeEnd <='1' when (Areg = "0000000000000000" or Areg = "0000000000000001" or Areg = "0000000000000010")else '0';

end RTL ;
