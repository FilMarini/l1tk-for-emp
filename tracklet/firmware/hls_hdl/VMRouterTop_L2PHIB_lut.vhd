-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity VMRouterTop_L2PHIB_lut_rom is 
    generic(
             DWIDTH     : integer := 6; 
             AWIDTH     : integer := 11; 
             MEM_SIZE    : integer := 2048
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of VMRouterTop_L2PHIB_lut_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 9=> "000000", 10 to 12=> "000001", 13 to 15=> "000010", 16 to 24=> "000000", 25 to 26=> "000001", 
    27 to 29=> "000010", 30 to 31=> "000011", 32 to 38=> "000000", 39 to 41=> "000001", 42 to 44=> "000010", 
    45 to 47=> "000011", 48 to 53=> "000000", 54 to 56=> "000001", 57 to 58=> "000010", 59 to 61=> "000011", 
    62 to 63=> "000100", 64 to 68=> "000000", 69 to 70=> "000001", 71 to 73=> "000010", 74 to 76=> "000011", 
    77 to 79=> "000100", 80 to 83=> "000000", 84 to 85=> "000001", 86 to 88=> "000010", 89 to 91=> "000011", 
    92 to 94=> "000100", 95 => "000101", 96 to 97=> "000000", 98 to 100=> "000001", 101 to 102=> "000010", 
    103 to 105=> "000011", 106 to 108=> "000100", 109 to 111=> "000101", 112 => "000000", 113 to 114=> "000001", 
    115 to 117=> "000010", 118 to 120=> "000011", 121 to 123=> "000100", 124 to 126=> "000101", 127 => "000110", 
    128 to 129=> "000001", 130 to 132=> "000010", 133 to 134=> "000011", 135 to 137=> "000100", 138 to 140=> "000101", 
    141 to 143=> "000110", 144 => "000001", 145 to 146=> "000010", 147 to 149=> "000011", 150 to 152=> "000100", 
    153 to 155=> "000101", 156 to 158=> "000110", 159 => "000111", 160 to 161=> "000010", 162 to 163=> "000011", 
    164 to 166=> "000100", 167 to 169=> "000101", 170 to 173=> "000110", 174 to 175=> "000111", 176 to 178=> "000011", 
    179 to 181=> "000100", 182 to 184=> "000101", 185 to 187=> "000110", 188 to 190=> "000111", 191 => "001000", 
    192 to 193=> "000011", 194 to 195=> "000100", 196 to 198=> "000101", 199 to 201=> "000110", 202 to 205=> "000111", 
    206 to 207=> "001000", 208 to 210=> "000100", 211 to 213=> "000101", 214 to 216=> "000110", 217 to 219=> "000111", 
    220 to 223=> "001000", 224 => "000100", 225 to 227=> "000101", 228 to 230=> "000110", 231 to 233=> "000111", 
    234 to 237=> "001000", 238 to 239=> "001001", 240 to 242=> "000101", 243 to 245=> "000110", 246 to 248=> "000111", 
    249 to 251=> "001000", 252 to 255=> "001001", 256 => "000101", 257 to 259=> "000110", 260 to 262=> "000111", 
    263 to 266=> "001000", 267 to 269=> "001001", 270 to 271=> "001010", 272 to 273=> "000110", 274 to 277=> "000111", 
    278 to 280=> "001000", 281 to 284=> "001001", 285 to 287=> "001010", 288 => "000110", 289 to 291=> "000111", 
    292 to 294=> "001000", 295 to 298=> "001001", 299 to 302=> "001010", 303 => "001011", 304 to 305=> "000111", 
    306 to 308=> "001000", 309 to 312=> "001001", 313 to 316=> "001010", 317 to 319=> "001011", 320 => "000111", 
    321 to 323=> "001000", 324 to 326=> "001001", 327 to 330=> "001010", 331 to 334=> "001011", 335 => "001100", 
    336 to 337=> "001000", 338 to 340=> "001001", 341 to 344=> "001010", 345 to 348=> "001011", 349 to 351=> "001100", 
    352 to 354=> "001001", 355 to 358=> "001010", 359 to 362=> "001011", 363 to 366=> "001100", 367 => "001101", 
    368 to 369=> "001001", 370 to 372=> "001010", 373 to 376=> "001011", 377 to 380=> "001100", 381 to 383=> "001101", 
    384 to 386=> "001010", 387 to 390=> "001011", 391 to 394=> "001100", 395 to 399=> "001101", 400 => "001010", 
    401 to 404=> "001011", 405 to 408=> "001100", 409 to 413=> "001101", 414 to 415=> "001110", 416 to 418=> "001011", 
    419 to 422=> "001100", 423 to 426=> "001101", 427 to 431=> "001110", 432 => "001011", 433 to 436=> "001100", 
    437 to 440=> "001101", 441 to 445=> "001110", 446 to 447=> "001111", 448 to 450=> "001100", 451 to 454=> "001101", 
    455 to 458=> "001110", 459 to 463=> "001111", 464 => "001100", 465 to 468=> "001101", 469 to 472=> "001110", 
    473 to 477=> "001111", 478 to 479=> "010000", 480 to 481=> "001101", 482 to 486=> "001110", 487 to 491=> "001111", 
    492 to 495=> "010000", 496 to 500=> "001110", 501 to 504=> "001111", 505 to 510=> "010000", 511 => "010001", 
    512 to 513=> "001110", 514 to 518=> "001111", 519 to 523=> "010000", 524 to 527=> "010001", 528 to 531=> "001111", 
    532 to 536=> "010000", 537 to 542=> "010001", 543 => "010010", 544 to 545=> "001111", 546 to 550=> "010000", 
    551 to 555=> "010001", 556 to 559=> "010010", 560 to 563=> "010000", 564 to 568=> "010001", 569 to 575=> "010010", 
    576 => "010000", 577 to 582=> "010001", 583 to 588=> "010010", 589 to 591=> "010011", 592 to 595=> "010001", 
    596 to 601=> "010010", 602 to 607=> "010011", 608 => "010001", 609 to 613=> "010010", 614 to 620=> "010011", 
    621 to 623=> "010100", 624 to 626=> "010010", 627 to 633=> "010011", 634 to 639=> "010100", 640 to 645=> "010011", 
    646 to 652=> "010100", 653 to 655=> "010101", 656 to 658=> "010011", 659 to 665=> "010100", 666 to 671=> "010101", 
    672 to 677=> "010100", 678 to 685=> "010101", 686 to 687=> "010110", 688 to 690=> "010100", 691 to 697=> "010101", 
    698 to 703=> "010110", 704 to 709=> "010101", 710 to 718=> "010110", 719 => "010111", 720 to 721=> "010101", 
    722 to 729=> "010110", 730 to 735=> "010111", 736 to 741=> "010110", 742 to 750=> "010111", 751 => "011000", 
    752 => "010110", 753 to 761=> "010111", 762 to 767=> "011000", 768 to 773=> "010111", 774 to 783=> "011000", 
    784 => "010111", 785 to 794=> "011000", 795 to 799=> "011001", 800 to 804=> "011000", 805 to 826=> "011001", 
    827 to 831=> "011010", 832 to 836=> "011001", 837 to 859=> "011010", 860 to 863=> "011011", 864 to 867=> "011010", 
    868 to 892=> "011011", 893 to 895=> "011100", 896 to 898=> "011011", 899 to 926=> "011100", 927 => "011101", 
    928 => "011100", 929 to 959=> "011101", 960 to 991=> "011110", 992 to 1023=> "011111", 1024 to 1055=> "100000", 
    1056 to 1087=> "100001", 1088 to 1103=> "100010", 1104 => "100011", 1105 to 1119=> "100010", 1120 to 1134=> "100011", 
    1135 => "100010", 1136 to 1138=> "100100", 1139 to 1151=> "100011", 1152 to 1164=> "100100", 1165 to 1167=> "100011", 
    1168 to 1171=> "100101", 1172 to 1183=> "100100", 1184 to 1195=> "100101", 1196 to 1199=> "100100", 1200 to 1204=> "100110", 
    1205 to 1215=> "100101", 1216 to 1226=> "100110", 1227 to 1231=> "100101", 1232 to 1236=> "100111", 1237 to 1247=> "100110", 
    1248 => "101000", 1249 to 1258=> "100111", 1259 to 1263=> "100110", 1264 to 1269=> "101000", 1270 to 1279=> "100111", 
    1280 => "101001", 1281 to 1289=> "101000", 1290 to 1295=> "100111", 1296 to 1301=> "101001", 1302 to 1310=> "101000", 
    1311 => "100111", 1312 to 1313=> "101010", 1314 to 1321=> "101001", 1322 to 1327=> "101000", 1328 to 1333=> "101010", 
    1334 to 1342=> "101001", 1343 => "101000", 1344 to 1346=> "101011", 1347 to 1353=> "101010", 1354 to 1359=> "101001", 
    1360 to 1365=> "101011", 1366 to 1373=> "101010", 1374 to 1375=> "101001", 1376 to 1378=> "101100", 1379 to 1385=> "101011", 
    1386 to 1391=> "101010", 1392 to 1397=> "101100", 1398 to 1404=> "101011", 1405 to 1407=> "101010", 1408 to 1410=> "101101", 
    1411 to 1417=> "101100", 1418 to 1423=> "101011", 1424 => "101110", 1425 to 1429=> "101101", 1430 to 1436=> "101100", 
    1437 to 1439=> "101011", 1440 to 1443=> "101110", 1444 to 1449=> "101101", 1450 to 1455=> "101100", 1456 => "101111", 
    1457 to 1462=> "101110", 1463 to 1468=> "101101", 1469 to 1471=> "101100", 1472 to 1475=> "101111", 1476 to 1480=> "101110", 
    1481 to 1487=> "101101", 1488 to 1489=> "110000", 1490 to 1494=> "101111", 1495 to 1499=> "101110", 1500 to 1503=> "101101", 
    1504 to 1507=> "110000", 1508 to 1512=> "101111", 1513 to 1518=> "101110", 1519 => "101101", 1520 to 1521=> "110001", 
    1522 to 1526=> "110000", 1527 to 1531=> "101111", 1532 to 1535=> "101110", 1536 to 1540=> "110001", 1541 to 1544=> "110000", 
    1545 to 1550=> "101111", 1551 => "101110", 1552 to 1553=> "110010", 1554 to 1558=> "110001", 1559 to 1563=> "110000", 
    1564 to 1567=> "101111", 1568 => "110011", 1569 to 1572=> "110010", 1573 to 1576=> "110001", 1577 to 1581=> "110000", 
    1582 to 1583=> "101111", 1584 to 1586=> "110011", 1587 to 1590=> "110010", 1591 to 1594=> "110001", 1595 to 1599=> "110000", 
    1600 => "110100", 1601 to 1604=> "110011", 1605 to 1608=> "110010", 1609 to 1613=> "110001", 1614 to 1615=> "110000", 
    1616 to 1618=> "110100", 1619 to 1622=> "110011", 1623 to 1626=> "110010", 1627 to 1631=> "110001", 1632 => "110101", 
    1633 to 1636=> "110100", 1637 to 1640=> "110011", 1641 to 1645=> "110010", 1646 to 1647=> "110001", 1648 to 1650=> "110101", 
    1651 to 1654=> "110100", 1655 to 1658=> "110011", 1659 to 1663=> "110010", 1664 to 1665=> "110110", 1666 to 1668=> "110101", 
    1669 to 1672=> "110100", 1673 to 1676=> "110011", 1677 to 1679=> "110010", 1680 to 1682=> "110110", 1683 to 1686=> "110101", 
    1687 to 1690=> "110100", 1691 to 1694=> "110011", 1695 => "110010", 1696 to 1697=> "110111", 1698 to 1700=> "110110", 
    1701 to 1704=> "110101", 1705 to 1708=> "110100", 1709 to 1711=> "110011", 1712 => "111000", 1713 to 1715=> "110111", 
    1716 to 1718=> "110110", 1719 to 1722=> "110101", 1723 to 1726=> "110100", 1727 => "110011", 1728 to 1729=> "111000", 
    1730 to 1732=> "110111", 1733 to 1736=> "110110", 1737 to 1740=> "110101", 1741 to 1743=> "110100", 1744 => "111001", 
    1745 to 1747=> "111000", 1748 to 1750=> "110111", 1751 to 1754=> "110110", 1755 to 1758=> "110101", 1759 => "110100", 
    1760 to 1761=> "111001", 1762 to 1765=> "111000", 1766 to 1768=> "110111", 1769 to 1772=> "110110", 1773 to 1775=> "110101", 
    1776 => "111010", 1777 to 1779=> "111001", 1780 to 1782=> "111000", 1783 to 1786=> "110111", 1787 to 1789=> "110110", 
    1790 to 1791=> "110101", 1792 to 1794=> "111010", 1795 to 1797=> "111001", 1798 to 1800=> "111000", 1801 to 1803=> "110111", 
    1804 to 1807=> "110110", 1808 => "111011", 1809 to 1811=> "111010", 1812 to 1814=> "111001", 1815 to 1817=> "111000", 
    1818 to 1821=> "110111", 1822 to 1823=> "110110", 1824 to 1826=> "111011", 1827 to 1829=> "111010", 1830 to 1832=> "111001", 
    1833 to 1835=> "111000", 1836 to 1839=> "110111", 1840 to 1841=> "111100", 1842 to 1843=> "111011", 1844 to 1846=> "111010", 
    1847 to 1849=> "111001", 1850 to 1853=> "111000", 1854 to 1855=> "110111", 1856 to 1858=> "111100", 1859 to 1861=> "111011", 
    1862 to 1864=> "111010", 1865 to 1867=> "111001", 1868 to 1870=> "111000", 1871 => "110111", 1872 to 1873=> "111101", 
    1874 to 1875=> "111100", 1876 to 1878=> "111011", 1879 to 1881=> "111010", 1882 to 1885=> "111001", 1886 to 1887=> "111000", 
    1888 => "111110", 1889 to 1890=> "111101", 1891 to 1893=> "111100", 1894 to 1896=> "111011", 1897 to 1899=> "111010", 
    1900 to 1902=> "111001", 1903 => "111000", 1904 to 1905=> "111110", 1906 to 1908=> "111101", 1909 to 1910=> "111100", 
    1911 to 1913=> "111011", 1914 to 1916=> "111010", 1917 to 1919=> "111001", 1920 => "111111", 1921 to 1922=> "111110", 
    1923 to 1925=> "111101", 1926 to 1928=> "111100", 1929 to 1931=> "111011", 1932 to 1934=> "111010", 1935 => "111001", 
    1936 to 1937=> "111111", 1938 to 1940=> "111110", 1941 to 1942=> "111101", 1943 to 1945=> "111100", 1946 to 1948=> "111011", 
    1949 to 1951=> "111010", 1952 to 1955=> "111111", 1956 to 1957=> "111110", 1958 to 1960=> "111101", 1961 to 1963=> "111100", 
    1964 to 1966=> "111011", 1967 => "111010", 1968 to 1972=> "111111", 1973 to 1974=> "111110", 1975 to 1977=> "111101", 
    1978 to 1980=> "111100", 1981 to 1983=> "111011", 1984 to 1989=> "111111", 1990 to 1992=> "111110", 1993 to 1994=> "111101", 
    1995 to 1997=> "111100", 1998 to 1999=> "111011", 2000 to 2006=> "111111", 2007 to 2009=> "111110", 2010 to 2012=> "111101", 
    2013 to 2015=> "111100", 2016 to 2024=> "111111", 2025 to 2026=> "111110", 2027 to 2029=> "111101", 2030 to 2031=> "111100", 
    2032 to 2041=> "111111", 2042 to 2044=> "111110", 2045 to 2047=> "111101" );


signal q0_t0 : std_logic_vector(DWIDTH-1 downto 0);
signal q0_t1 : std_logic_vector(DWIDTH-1 downto 0);
begin 

q0 <= q0_t1;

p_IO_pipeline_reg : process (clk)  
begin
    if (clk'event and clk = '1') then
      if (ce0 = '1') then 
        q0_t1 <= q0_t0;
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

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0_t0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity VMRouterTop_L2PHIB_lut is
    generic (
        DataWidth : INTEGER := 6;
        AddressRange : INTEGER := 2048;
        AddressWidth : INTEGER := 11);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of VMRouterTop_L2PHIB_lut is
    component VMRouterTop_L2PHIB_lut_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    VMRouterTop_L2PHIB_lut_rom_U :  component VMRouterTop_L2PHIB_lut_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


