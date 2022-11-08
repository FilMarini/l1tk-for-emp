LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.FIXED_PKG.ALL;

library work;
use work.kfout_data_formats.all;
use work.kfout_config.all;

USE work.DataType.all;
USE work.ArrayTypes.all;

use work.hybrid_config.all;
use work.hybrid_data_types.all;
use work.hybrid_data_formats.all;

USE work.constants.ALL;
USE work.BDTTypes.ALL;

use work.tracktransform_helper.all;


ENTITY kfout_trackQuality IS
PORT(
  clk          : IN STD_LOGIC; -- The algorithm clock
  TTTracksIn   : IN Vector;
  TTTracksOut  : OUT Vector
);
END kfout_trackQuality;

ARCHITECTURE RTL OF kfout_trackQuality IS

    SIGNAL Output : VECTOR( TTTracksIn'LENGTH - 1 DOWNTO 0 ):= NullVector( TTTracksIn'LENGTH );
    CONSTANT frame_delay : INTEGER := MVALatency - 2; --Constant latency of algorithm steps

BEGIN
  g1 : FOR i IN 0 TO TTTracksIn'LENGTH-1 GENERATE

    SIGNAL input_features : txArray(0 to nFeatures-1) := (others => to_tx(0)); 
    SIGNAL input_valid : boolean := FALSE;

    SIGNAL ty_out : tyArray(0 to nClasses-1) := (others => to_ty(0));
    SIGNAL ty_vld : boolArray(0 to nClasses-1) := (others => False);

    SIGNAL InputPipe : VECTOR( 0 TO frame_delay - 1 ):= NullVector( frame_delay );

    SIGNAL s_temp_phi       : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_tanl      : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_z0        : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_bendchi2  : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_nstub     : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_ninterior : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_chi2rphi  : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    SIGNAL s_temp_chi2rz    : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');

    BEGIN

    BDTentity : ENTITY work.BDTTop
    PORT MAP(
        clk => clk,
        X => input_features,
        X_vld => input_valid,
        y => ty_out,
        y_vld => ty_vld
    );

    PROCESS (clk)

    VARIABLE temp_tanl      : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_z0        : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_bendchi2  : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_nstub     : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_ninterior : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_chi2rphi  : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    VARIABLE temp_chi2rz    : SFIXED( 5 DOWNTO -5 ) := (OTHERS => '0');
    
    BEGIN
        IF RISING_EDGE(clk) THEN

            s_temp_tanl <= temp_tanl;
            s_temp_z0 <= temp_z0;
            s_temp_bendchi2 <= temp_bendchi2;
            s_temp_nstub <= temp_nstub;
            s_temp_ninterior <= temp_ninterior;
            s_temp_chi2rphi <= temp_chi2rphi;
            s_temp_chi2rz <= temp_chi2rz;

            temp_tanl      := resize((TO_SFIXED(SIGNED(TTTracksIn( i ).TanL),17,-1)/4096),5,-5);
            temp_z0        := resize((TO_SFIXED(SIGNED(TTTracksIn( i ).z0),13,-1)/2048),5,-5);
            temp_bendchi2  := resize((TO_SFIXED(SIGNED(TTTracksIn( i ).bendChi2),4,-1)),5,-5);
            temp_nstub     := resize((TO_SFIXED(Nstub(STD_LOGIC_VECTOR(TTTracksIn( i ).HitPattern)),4,-1)),5,-5);
            temp_ninterior := resize((TO_SFIXED(Ninterior(STD_LOGIC_VECTOR(TTTracksIn( i ).HitPattern)),4,-1)),5,-5);
            temp_chi2rphi  := resize((TO_SFIXED(SIGNED(TTTracksIn( i ).chi2rphi),5,-1)),5,-5);
            temp_chi2rz    := resize((TO_SFIXED(SIGNED(TTTracksIn( i ).chi2rz),5,-1)),5,-5);

            input_valid <= TO_BOOLEAN(TTTracksIn( i ).Trackvalid);
            input_features( 0 ) <= to_signed(s_temp_tanl,      input_features( 0 )'length);
            input_features( 1 ) <= to_signed(s_temp_z0,        input_features( 1 )'length);
            input_features( 2 ) <= to_signed(s_temp_bendChi2,  input_features( 2 )'length);
            input_features( 3 ) <= to_signed(s_temp_nstub,     input_features( 3 )'length);
            input_features( 4 ) <= to_signed(s_temp_ninterior, input_features( 4 )'length);
            input_features( 5 ) <= to_signed(s_temp_chi2rphi,  input_features( 5 )'length);
            input_features( 6 ) <= to_signed(s_temp_chi2rz,    input_features( 6 )'length);

            InputPipe <= TTTracksIn( i ) & InputPipe( 0 TO frame_delay - 2 );

            Output( i ).TrackValid <=  InputPipe( frame_delay - 1 ).TrackValid;
            Output( i ).DataValid  <=  InputPipe( frame_delay - 1 ).DataValid;
            Output( i ).extraMVA   <=  InputPipe( frame_delay - 1 ).extraMVA;
            Output( i ).HitPattern <=  InputPipe( frame_delay - 1 ).HitPattern;
            Output( i ).BendChi2   <=  InputPipe( frame_delay - 1 ).BendChi2;
            Output( i ).Chi2RPhi   <=  InputPipe( frame_delay - 1 ).Chi2RPhi;
            Output( i ).Chi2RZ     <=  InputPipe( frame_delay - 1 ).Chi2RZ;
            Output( i ).D0         <=  InputPipe( frame_delay - 1 ).D0;
            Output( i ).Z0         <=  InputPipe( frame_delay - 1 ).Z0;
            Output( i ).TanL       <=  InputPipe( frame_delay - 1 ).TanL;
            Output( i ).Phi0       <=  InputPipe( frame_delay - 1 ).Phi0;
            Output( i ).InvR       <=  InputPipe( frame_delay - 1 ).InvR;
            Output( i ).SortKey    <=  InputPipe( frame_delay - 1 ).SortKey;

            Output( i ).FrameValid <=  InputPipe( frame_delay - 1 ).FrameValid;
            Output( i ).reset <=  InputPipe( frame_delay - 1 ).reset;


            IF ty_vld(0) THEN
                Output( i ).TQMVA      <=  MVAPacker((TO_SFIXED(ty_out( 0 ),5,-5)),MVAbins);
            ELSE
                Output( i ).TQMVA      <=  TO_UNSIGNED( 0, widthTQMVA );
            END IF;


        END IF;

    END PROCESS;

END GENERATE;

TTTracksOut <= Output;

END rtl;