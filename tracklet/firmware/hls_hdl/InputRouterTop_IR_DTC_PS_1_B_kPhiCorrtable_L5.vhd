-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5_rom is 
    generic(
             DWIDTH     : integer := 16; 
             AWIDTH     : integer := 7; 
             MEM_SIZE    : integer := 128
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


architecture rtl of InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
signal addr1_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 7=> "0000000000000000", 8 => "0000000011000010", 9 => "0000000010001010", 
    10 => "0000000001010011", 11 => "0000000000011011", 12 => "1111111111100101", 
    13 => "1111111110101101", 14 => "1111111101110110", 15 => "1111111100111110", 
    16 => "0000000100100011", 17 => "0000000011010000", 18 => "0000000001111101", 
    19 => "0000000000101001", 20 => "1111111111010111", 21 => "1111111110000011", 
    22 => "1111111100110000", 23 => "1111111011011101", 24 => "0000000110110101", 
    25 => "0000000100111000", 26 => "0000000010111011", 27 => "0000000000111110", 
    28 => "1111111111000010", 29 => "1111111101000101", 30 => "1111111011001000", 
    31 => "1111111001001011", 32 => "0000001000010111", 33 => "0000000101111110", 
    34 => "0000000011100101", 35 => "0000000001001100", 36 => "1111111110110100", 
    37 => "1111111100011011", 38 => "1111111010000010", 39 => "1111110111101001", 
    40 => "0000001100001010", 41 => "0000001000101011", 42 => "0000000101001101", 
    43 => "0000000001101111", 44 => "1111111110010001", 45 => "1111111010110011", 
    46 => "1111110111010101", 47 => "1111110011110110", 48 => "0000001111100101", 
    49 => "0000001011001000", 50 => "0000000110101011", 51 => "0000000010001110", 
    52 => "1111111101110010", 53 => "1111111001010101", 54 => "1111110100111000", 
    55 => "1111110000011011", 56 => "0000010000101110", 57 => "0000001011111100", 
    58 => "0000000111001010", 59 => "0000000010011000", 60 => "1111111101101000", 
    61 => "1111111000110110", 62 => "1111110100000100", 63 => "1111101111010010", 
    64 => "0101010101101011", 65 => "0011110100000011", 66 => "0010010010011011", 
    67 => "0000110000110011", 68 => "1111001111001101", 69 => "1101101101100101", 
    70 => "1100001011111101", 71 => "1010101010010101", 72 => "1111101111010010", 
    73 => "1111110100000100", 74 => "1111111000110110", 75 => "1111111101101000", 
    76 => "0000000010011000", 77 => "0000000111001010", 78 => "0000001011111100", 
    79 => "0000010000101110", 80 => "1111110000011011", 81 => "1111110100111000", 
    82 => "1111111001010101", 83 => "1111111101110010", 84 => "0000000010001110", 
    85 => "0000000110101011", 86 => "0000001011001000", 87 => "0000001111100101", 
    88 => "1111110011110110", 89 => "1111110111010101", 90 => "1111111010110011", 
    91 => "1111111110010001", 92 => "0000000001101111", 93 => "0000000101001101", 
    94 => "0000001000101011", 95 => "0000001100001010", 96 => "1111110111101001", 
    97 => "1111111010000010", 98 => "1111111100011011", 99 => "1111111110110100", 
    100 => "0000000001001100", 101 => "0000000011100101", 102 => "0000000101111110", 
    103 => "0000001000010111", 104 => "1111111001001011", 105 => "1111111011001000", 
    106 => "1111111101000101", 107 => "1111111111000010", 108 => "0000000000111110", 
    109 => "0000000010111011", 110 => "0000000100111000", 111 => "0000000110110101", 
    112 => "1111111011011101", 113 => "1111111100110000", 114 => "1111111110000011", 
    115 => "1111111111010111", 116 => "0000000000101001", 117 => "0000000001111101", 
    118 => "0000000011010000", 119 => "0000000100100011", 120 => "1111111100111110", 
    121 => "1111111101110110", 122 => "1111111110101101", 123 => "1111111111100101", 
    124 => "0000000000011011", 125 => "0000000001010011", 126 => "0000000010001010", 
    127 => "0000000011000010" );


begin 


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
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
        if (ce1 = '1') then 
            q1 <= mem(CONV_INTEGER(addr1_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5 is
    generic (
        DataWidth : INTEGER := 16;
        AddressRange : INTEGER := 128;
        AddressWidth : INTEGER := 7);
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

architecture arch of InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5 is
    component InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5_rom is
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
    InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5_rom_U :  component InputRouterTop_IR_DTC_PS_1_B_kPhiCorrtable_L5_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        q1 => q1);

end architecture;


