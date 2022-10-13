-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity VMRouterTop_L6PHIB_lut_1_rom is 
    generic(
             DWIDTH     : integer := 6; 
             AWIDTH     : integer := 11; 
             MEM_SIZE    : integer := 2048
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          addr1      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce1       : in std_logic; 
          q1         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of VMRouterTop_L6PHIB_lut_1_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
signal addr1_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 13=> "000000", 14 to 15=> "000001", 16 to 25=> "000000", 26 to 31=> "000001", 32 to 37=> "000000", 
    38 to 45=> "000001", 46 to 47=> "000010", 48 to 49=> "000000", 50 to 57=> "000001", 58 to 63=> "000010", 
    64 to 69=> "000001", 70 to 77=> "000010", 78 to 79=> "000011", 80 to 81=> "000001", 82 to 89=> "000010", 
    90 to 95=> "000011", 96 to 101=> "000010", 102 to 109=> "000011", 110 to 111=> "000100", 112 to 113=> "000010", 
    114 to 121=> "000011", 122 to 127=> "000100", 128 to 133=> "000011", 134 to 141=> "000100", 142 to 143=> "000101", 
    144 to 145=> "000011", 146 to 153=> "000100", 154 to 159=> "000101", 160 to 165=> "000100", 166 to 174=> "000101", 
    175 => "000110", 176 to 177=> "000100", 178 to 185=> "000101", 186 to 191=> "000110", 192 to 197=> "000101", 
    198 to 206=> "000110", 207 => "000111", 208 => "000101", 209 to 217=> "000110", 218 to 223=> "000111", 
    224 to 229=> "000110", 230 to 238=> "000111", 239 => "001000", 240 => "000110", 241 to 249=> "000111", 
    250 to 255=> "001000", 256 to 261=> "000111", 262 to 271=> "001000", 272 => "000111", 273 to 282=> "001000", 
    283 to 287=> "001001", 288 to 292=> "001000", 293 to 314=> "001001", 315 to 319=> "001010", 320 to 324=> "001001", 
    325 to 346=> "001010", 347 to 351=> "001011", 352 to 356=> "001010", 357 to 378=> "001011", 379 to 383=> "001100", 
    384 to 388=> "001011", 389 to 410=> "001100", 411 to 415=> "001101", 416 to 420=> "001100", 421 to 442=> "001101", 
    443 to 447=> "001110", 448 to 452=> "001101", 453 to 474=> "001110", 475 to 479=> "001111", 480 to 484=> "001110", 
    485 to 507=> "001111", 508 to 511=> "010000", 512 to 515=> "001111", 516 to 539=> "010000", 540 to 543=> "010001", 
    544 to 547=> "010000", 548 to 571=> "010001", 572 to 575=> "010010", 576 to 579=> "010001", 580 to 603=> "010010", 
    604 to 607=> "010011", 608 to 611=> "010010", 612 to 636=> "010011", 637 to 639=> "010100", 640 to 642=> "010011", 
    643 to 668=> "010100", 669 to 671=> "010101", 672 to 674=> "010100", 675 to 701=> "010101", 702 to 703=> "010110", 
    704 to 705=> "010101", 706 to 733=> "010110", 734 to 735=> "010111", 736 to 737=> "010110", 738 to 766=> "010111", 
    767 => "011000", 768 => "010111", 769 to 799=> "011000", 800 to 831=> "011001", 832 to 863=> "011010", 
    864 to 895=> "011011", 896 to 927=> "011100", 928 to 959=> "011101", 960 to 991=> "011110", 992 to 1023=> "011111", 
    1024 to 1055=> "100000", 1056 to 1087=> "100001", 1088 to 1119=> "100010", 1120 to 1151=> "100011", 1152 to 1183=> "100100", 
    1184 to 1215=> "100101", 1216 to 1247=> "100110", 1248 to 1263=> "100111", 1264 => "101000", 1265 to 1279=> "100111", 
    1280 to 1294=> "101000", 1295 => "100111", 1296 to 1297=> "101001", 1298 to 1311=> "101000", 1312 to 1325=> "101001", 
    1326 to 1327=> "101000", 1328 to 1329=> "101010", 1330 to 1343=> "101001", 1344 to 1357=> "101010", 1358 to 1359=> "101001", 
    1360 to 1362=> "101011", 1363 to 1375=> "101010", 1376 to 1388=> "101011", 1389 to 1391=> "101010", 1392 to 1394=> "101100", 
    1395 to 1407=> "101011", 1408 to 1420=> "101100", 1421 to 1423=> "101011", 1424 to 1427=> "101101", 1428 to 1439=> "101100", 
    1440 to 1451=> "101101", 1452 to 1455=> "101100", 1456 to 1459=> "101110", 1460 to 1471=> "101101", 1472 to 1483=> "101110", 
    1484 to 1487=> "101101", 1488 to 1491=> "101111", 1492 to 1503=> "101110", 1504 to 1515=> "101111", 1516 to 1519=> "101110", 
    1520 to 1523=> "110000", 1524 to 1535=> "101111", 1536 to 1547=> "110000", 1548 to 1551=> "101111", 1552 to 1556=> "110001", 
    1557 to 1567=> "110000", 1568 to 1578=> "110001", 1579 to 1583=> "110000", 1584 to 1588=> "110010", 1589 to 1599=> "110001", 
    1600 to 1610=> "110010", 1611 to 1615=> "110001", 1616 to 1620=> "110011", 1621 to 1631=> "110010", 1632 to 1642=> "110011", 
    1643 to 1647=> "110010", 1648 to 1652=> "110100", 1653 to 1663=> "110011", 1664 to 1674=> "110100", 1675 to 1679=> "110011", 
    1680 to 1684=> "110101", 1685 to 1695=> "110100", 1696 to 1706=> "110101", 1707 to 1711=> "110100", 1712 to 1716=> "110110", 
    1717 to 1727=> "110101", 1728 to 1738=> "110110", 1739 to 1743=> "110101", 1744 to 1748=> "110111", 1749 to 1759=> "110110", 
    1760 => "111000", 1761 to 1770=> "110111", 1771 to 1775=> "110110", 1776 to 1781=> "111000", 1782 to 1791=> "110111", 
    1792 => "111001", 1793 to 1801=> "111000", 1802 to 1807=> "110111", 1808 to 1813=> "111001", 1814 to 1822=> "111000", 
    1823 => "110111", 1824 => "111010", 1825 to 1833=> "111001", 1834 to 1839=> "111000", 1840 to 1845=> "111010", 
    1846 to 1854=> "111001", 1855 => "111000", 1856 to 1857=> "111011", 1858 to 1865=> "111010", 1866 to 1871=> "111001", 
    1872 to 1877=> "111011", 1878 to 1886=> "111010", 1887 => "111001", 1888 to 1889=> "111100", 1890 to 1897=> "111011", 
    1898 to 1903=> "111010", 1904 to 1909=> "111100", 1910 to 1917=> "111011", 1918 to 1919=> "111010", 1920 to 1921=> "111101", 
    1922 to 1929=> "111100", 1930 to 1935=> "111011", 1936 to 1941=> "111101", 1942 to 1949=> "111100", 1950 to 1951=> "111011", 
    1952 to 1953=> "111110", 1954 to 1961=> "111101", 1962 to 1967=> "111100", 1968 to 1973=> "111110", 1974 to 1981=> "111101", 
    1982 to 1983=> "111100", 1984 to 1985=> "111111", 1986 to 1993=> "111110", 1994 to 1999=> "111101", 2000 to 2005=> "111111", 
    2006 to 2013=> "111110", 2014 to 2015=> "111101", 2016 to 2025=> "111111", 2026 to 2031=> "111110", 2032 to 2045=> "111111", 
    2046 to 2047=> "111110" );


signal q0_t0 : std_logic_vector(DWIDTH-1 downto 0);
signal q0_t1 : std_logic_vector(DWIDTH-1 downto 0);
signal q1_t0 : std_logic_vector(DWIDTH-1 downto 0);
signal q1_t1 : std_logic_vector(DWIDTH-1 downto 0);
begin 

q0 <= q0_t1;
q1 <= q1_t1;

p_IO_pipeline_reg : process (clk)  
begin
    if (clk'event and clk = '1') then
      if (ce0 = '1') then 
        q0_t1 <= q0_t0;
      end if;
      if (ce1 = '1') then 
        q1_t1 <= q1_t0;
      end if;
    end if;
end process;

memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

memory_access_guard_1: process (addr1) 
begin
      addr1_tmp <= addr1;
--synthesis translate_off
      if (CONV_INTEGER(addr1) > mem_size-1) then
           addr1_tmp <= (others => '0');
      else 
           addr1_tmp <= addr1;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0_t0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
        if (ce1 = '1') then 
            q1_t0 <= mem(CONV_INTEGER(addr1_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity VMRouterTop_L6PHIB_lut_1 is
    generic (
        DataWidth : INTEGER := 6;
        AddressRange : INTEGER := 2048;
        AddressWidth : INTEGER := 11);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0);
        address1 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of VMRouterTop_L6PHIB_lut_1 is
    component VMRouterTop_L6PHIB_lut_1_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR;
            addr1 : IN STD_LOGIC_VECTOR;
            ce1 : IN STD_LOGIC;
            q1 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    VMRouterTop_L6PHIB_lut_1_rom_U :  component VMRouterTop_L6PHIB_lut_1_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        q1 => q1);

end architecture;


