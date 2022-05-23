-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity VMRouterTop_L5PHIB_lut_1_rom is 
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


architecture rtl of VMRouterTop_L5PHIB_lut_1_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
signal addr1_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 11=> "000000", 12 to 15=> "000001", 16 to 24=> "000000", 25 to 31=> "000001", 32 to 38=> "000000", 
    39 to 44=> "000001", 45 to 47=> "000010", 48 to 51=> "000000", 52 to 57=> "000001", 58 to 63=> "000010", 
    64 => "000000", 65 to 69=> "000001", 70 to 76=> "000010", 77 to 79=> "000011", 80 to 82=> "000001", 
    83 to 89=> "000010", 90 to 95=> "000011", 96 to 101=> "000010", 102 to 108=> "000011", 109 to 111=> "000100", 
    112 to 114=> "000010", 115 to 121=> "000011", 122 to 127=> "000100", 128 to 133=> "000011", 134 to 140=> "000100", 
    141 to 143=> "000101", 144 to 146=> "000011", 147 to 153=> "000100", 154 to 159=> "000101", 160 to 165=> "000100", 
    166 to 172=> "000101", 173 to 175=> "000110", 176 to 178=> "000100", 179 to 185=> "000101", 186 to 191=> "000110", 
    192 to 197=> "000101", 198 to 205=> "000110", 206 to 207=> "000111", 208 to 210=> "000101", 211 to 217=> "000110", 
    218 to 223=> "000111", 224 to 229=> "000110", 230 to 237=> "000111", 238 to 239=> "001000", 240 to 241=> "000110", 
    242 to 249=> "000111", 250 to 255=> "001000", 256 to 261=> "000111", 262 to 269=> "001000", 270 to 271=> "001001", 
    272 to 273=> "000111", 274 to 281=> "001000", 282 to 287=> "001001", 288 to 293=> "001000", 294 to 301=> "001001", 
    302 to 303=> "001010", 304 to 305=> "001000", 306 to 313=> "001001", 314 to 319=> "001010", 320 to 325=> "001001", 
    326 to 334=> "001010", 335 => "001011", 336 to 337=> "001001", 338 to 345=> "001010", 346 to 351=> "001011", 
    352 to 357=> "001010", 358 to 366=> "001011", 367 => "001100", 368 => "001010", 369 to 377=> "001011", 
    378 to 383=> "001100", 384 to 389=> "001011", 390 to 398=> "001100", 399 => "001101", 400 => "001011", 
    401 to 409=> "001100", 410 to 415=> "001101", 416 to 421=> "001100", 422 to 431=> "001101", 432 => "001100", 
    433 to 442=> "001101", 443 to 447=> "001110", 448 to 452=> "001101", 453 to 474=> "001110", 475 to 479=> "001111", 
    480 to 484=> "001110", 485 to 506=> "001111", 507 to 511=> "010000", 512 to 516=> "001111", 517 to 538=> "010000", 
    539 to 543=> "010001", 544 to 548=> "010000", 549 to 570=> "010001", 571 to 575=> "010010", 576 to 580=> "010001", 
    581 to 603=> "010010", 604 to 607=> "010011", 608 to 611=> "010010", 612 to 635=> "010011", 636 to 639=> "010100", 
    640 to 643=> "010011", 644 to 667=> "010100", 668 to 671=> "010101", 672 to 675=> "010100", 676 to 700=> "010101", 
    701 to 703=> "010110", 704 to 706=> "010101", 707 to 732=> "010110", 733 to 735=> "010111", 736 to 738=> "010110", 
    739 to 765=> "010111", 766 to 767=> "011000", 768 to 769=> "010111", 770 to 798=> "011000", 799 => "011001", 
    800 => "011000", 801 to 831=> "011001", 832 to 863=> "011010", 864 to 895=> "011011", 896 to 927=> "011100", 
    928 to 959=> "011101", 960 to 991=> "011110", 992 to 1023=> "011111", 1024 to 1055=> "100000", 1056 to 1087=> "100001", 
    1088 to 1119=> "100010", 1120 to 1151=> "100011", 1152 to 1183=> "100100", 1184 to 1215=> "100101", 1216 to 1231=> "100110", 
    1232 => "100111", 1233 to 1247=> "100110", 1248 to 1262=> "100111", 1263 => "100110", 1264 to 1265=> "101000", 
    1266 to 1279=> "100111", 1280 to 1293=> "101000", 1294 to 1295=> "100111", 1296 to 1298=> "101001", 1299 to 1311=> "101000", 
    1312 to 1324=> "101001", 1325 to 1327=> "101000", 1328 to 1330=> "101010", 1331 to 1343=> "101001", 1344 to 1356=> "101010", 
    1357 to 1359=> "101001", 1360 to 1363=> "101011", 1364 to 1375=> "101010", 1376 to 1387=> "101011", 1388 to 1391=> "101010", 
    1392 to 1395=> "101100", 1396 to 1407=> "101011", 1408 to 1419=> "101100", 1420 to 1423=> "101011", 1424 to 1427=> "101101", 
    1428 to 1439=> "101100", 1440 to 1451=> "101101", 1452 to 1455=> "101100", 1456 to 1460=> "101110", 1461 to 1471=> "101101", 
    1472 to 1482=> "101110", 1483 to 1487=> "101101", 1488 to 1492=> "101111", 1493 to 1503=> "101110", 1504 to 1514=> "101111", 
    1515 to 1519=> "101110", 1520 to 1524=> "110000", 1525 to 1535=> "101111", 1536 to 1546=> "110000", 1547 to 1551=> "101111", 
    1552 to 1556=> "110001", 1557 to 1567=> "110000", 1568 to 1578=> "110001", 1579 to 1583=> "110000", 1584 to 1588=> "110010", 
    1589 to 1599=> "110001", 1600 => "110011", 1601 to 1610=> "110010", 1611 to 1615=> "110001", 1616 to 1621=> "110011", 
    1622 to 1631=> "110010", 1632 => "110100", 1633 to 1641=> "110011", 1642 to 1647=> "110010", 1648 to 1653=> "110100", 
    1654 to 1662=> "110011", 1663 => "110010", 1664 => "110101", 1665 to 1673=> "110100", 1674 to 1679=> "110011", 
    1680 to 1685=> "110101", 1686 to 1694=> "110100", 1695 => "110011", 1696 to 1697=> "110110", 1698 to 1705=> "110101", 
    1706 to 1711=> "110100", 1712 to 1717=> "110110", 1718 to 1726=> "110101", 1727 => "110100", 1728 to 1729=> "110111", 
    1730 to 1737=> "110110", 1738 to 1743=> "110101", 1744 to 1749=> "110111", 1750 to 1757=> "110110", 1758 to 1759=> "110101", 
    1760 to 1761=> "111000", 1762 to 1769=> "110111", 1770 to 1775=> "110110", 1776 to 1781=> "111000", 1782 to 1789=> "110111", 
    1790 to 1791=> "110110", 1792 to 1793=> "111001", 1794 to 1801=> "111000", 1802 to 1807=> "110111", 1808 to 1813=> "111001", 
    1814 to 1821=> "111000", 1822 to 1823=> "110111", 1824 to 1826=> "111010", 1827 to 1833=> "111001", 1834 to 1839=> "111000", 
    1840 to 1845=> "111010", 1846 to 1853=> "111001", 1854 to 1855=> "111000", 1856 to 1858=> "111011", 1859 to 1865=> "111010", 
    1866 to 1871=> "111001", 1872 to 1877=> "111011", 1878 to 1884=> "111010", 1885 to 1887=> "111001", 1888 to 1890=> "111100", 
    1891 to 1897=> "111011", 1898 to 1903=> "111010", 1904 to 1909=> "111100", 1910 to 1916=> "111011", 1917 to 1919=> "111010", 
    1920 to 1922=> "111101", 1923 to 1929=> "111100", 1930 to 1935=> "111011", 1936 to 1941=> "111101", 1942 to 1948=> "111100", 
    1949 to 1951=> "111011", 1952 to 1954=> "111110", 1955 to 1961=> "111101", 1962 to 1967=> "111100", 1968 => "111111", 
    1969 to 1973=> "111110", 1974 to 1980=> "111101", 1981 to 1983=> "111100", 1984 to 1987=> "111111", 1988 to 1993=> "111110", 
    1994 to 1999=> "111101", 2000 to 2006=> "111111", 2007 to 2012=> "111110", 2013 to 2015=> "111101", 2016 to 2024=> "111111", 
    2025 to 2031=> "111110", 2032 to 2043=> "111111", 2044 to 2047=> "111110" );


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

entity VMRouterTop_L5PHIB_lut_1 is
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

architecture arch of VMRouterTop_L5PHIB_lut_1 is
    component VMRouterTop_L5PHIB_lut_1_rom is
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
    VMRouterTop_L5PHIB_lut_1_rom_U :  component VMRouterTop_L5PHIB_lut_1_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        q1 => q1);

end architecture;


