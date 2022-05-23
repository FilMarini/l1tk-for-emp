
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1_DSP48_23 is
port (
    a: in std_logic_vector(16 - 1 downto 0);
    b: in std_logic_vector(18 - 1 downto 0);
    p: out std_logic_vector(31 - 1 downto 0));

end entity;

architecture behav of TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1_DSP48_23 is
    signal a_cvt: unsigned(16 - 1 downto 0);
    signal b_cvt: signed(18 - 1 downto 0);
    signal p_cvt: signed(31 - 1 downto 0);


begin

    a_cvt <= unsigned(a);
    b_cvt <= signed(b);
    p_cvt <= signed (resize(unsigned (signed ('0' & a_cvt) * signed (b_cvt)), 31));
    p <= std_logic_vector(p_cvt);

end architecture;
Library IEEE;
use IEEE.std_logic_1164.all;

entity TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1 is
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER);
    port (
        din0 : IN STD_LOGIC_VECTOR(din0_WIDTH - 1 DOWNTO 0);
        din1 : IN STD_LOGIC_VECTOR(din1_WIDTH - 1 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR(dout_WIDTH - 1 DOWNTO 0));
end entity;

architecture arch of TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1 is
    component TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1_DSP48_23 is
        port (
            a : IN STD_LOGIC_VECTOR;
            b : IN STD_LOGIC_VECTOR;
            p : OUT STD_LOGIC_VECTOR);
    end component;



begin
    TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1_DSP48_23_U :  component TrackletCalculator_L1L2F_mul_mul_16ns_18s_31_1_1_DSP48_23
    port map (
        a => din0,
        b => din1,
        p => dout);

end architecture;


