-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Aug  2 13:03:58 2020
-- Host        : ThinkPad running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Driver_HDMI_0_sim_netlist.vhdl
-- Design      : Driver_HDMI_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI is
  port (
    RGB_VDE : out STD_LOGIC;
    Set_X : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Set_Y : out STD_LOGIC_VECTOR ( 11 downto 0 );
    RGB_HSync : out STD_LOGIC;
    RGB_VSync : out STD_LOGIC;
    Video_Mode : in STD_LOGIC;
    clk : in STD_LOGIC;
    Rst : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI is
  signal HSync_Cnt1 : STD_LOGIC;
  signal HSync_Cnt1_carry_i_1_n_0 : STD_LOGIC;
  signal HSync_Cnt1_carry_i_2_n_0 : STD_LOGIC;
  signal HSync_Cnt1_carry_i_3_n_0 : STD_LOGIC;
  signal HSync_Cnt1_carry_i_4_n_0 : STD_LOGIC;
  signal HSync_Cnt1_carry_n_1 : STD_LOGIC;
  signal HSync_Cnt1_carry_n_2 : STD_LOGIC;
  signal HSync_Cnt1_carry_n_3 : STD_LOGIC;
  signal \HSync_Cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[4]_i_4_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[4]_i_5_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[8]_i_2_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \HSync_Cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal HSync_Cnt_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \HSync_Cnt_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \HSync_Cnt_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \HSync_Cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \HSync_Cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal H_De : STD_LOGIC;
  signal H_De0 : STD_LOGIC;
  signal H_De0_carry_i_1_n_0 : STD_LOGIC;
  signal H_De0_carry_i_2_n_0 : STD_LOGIC;
  signal H_De0_carry_i_3_n_0 : STD_LOGIC;
  signal H_De0_carry_i_4_n_0 : STD_LOGIC;
  signal H_De0_carry_n_1 : STD_LOGIC;
  signal H_De0_carry_n_2 : STD_LOGIC;
  signal H_De0_carry_n_3 : STD_LOGIC;
  signal H_De_i_1_n_0 : STD_LOGIC;
  signal \^rgb_hsync\ : STD_LOGIC;
  signal RGB_HSync0 : STD_LOGIC;
  signal RGB_HSync0_carry_i_1_n_0 : STD_LOGIC;
  signal RGB_HSync0_carry_i_2_n_0 : STD_LOGIC;
  signal RGB_HSync0_carry_i_3_n_0 : STD_LOGIC;
  signal RGB_HSync0_carry_i_4_n_0 : STD_LOGIC;
  signal RGB_HSync0_carry_n_1 : STD_LOGIC;
  signal RGB_HSync0_carry_n_2 : STD_LOGIC;
  signal RGB_HSync0_carry_n_3 : STD_LOGIC;
  signal RGB_HSync_i_1_n_0 : STD_LOGIC;
  signal RGB_HSync_i_2_n_0 : STD_LOGIC;
  signal RGB_VDE0 : STD_LOGIC;
  signal \^rgb_vsync\ : STD_LOGIC;
  signal RGB_VSync0 : STD_LOGIC;
  signal RGB_VSync0_carry_i_1_n_0 : STD_LOGIC;
  signal RGB_VSync0_carry_i_2_n_0 : STD_LOGIC;
  signal RGB_VSync0_carry_i_3_n_0 : STD_LOGIC;
  signal RGB_VSync0_carry_i_4_n_0 : STD_LOGIC;
  signal RGB_VSync0_carry_n_1 : STD_LOGIC;
  signal RGB_VSync0_carry_n_2 : STD_LOGIC;
  signal RGB_VSync0_carry_n_3 : STD_LOGIC;
  signal \RGB_VSync0_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \RGB_VSync0_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \RGB_VSync0_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \RGB_VSync0_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal RGB_VSync_i_1_n_0 : STD_LOGIC;
  signal Set_X0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \Set_X0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \Set_X0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \Set_X0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \Set_X0_carry__0_n_2\ : STD_LOGIC;
  signal \Set_X0_carry__0_n_3\ : STD_LOGIC;
  signal Set_X0_carry_i_1_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_2_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_3_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_4_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_5_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_6_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_7_n_0 : STD_LOGIC;
  signal Set_X0_carry_i_8_n_0 : STD_LOGIC;
  signal Set_X0_carry_n_0 : STD_LOGIC;
  signal Set_X0_carry_n_1 : STD_LOGIC;
  signal Set_X0_carry_n_2 : STD_LOGIC;
  signal Set_X0_carry_n_3 : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__1_n_2\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry__1_n_3\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \Set_X0_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal Set_Y0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \Set_Y0_carry__0_n_2\ : STD_LOGIC;
  signal \Set_Y0_carry__0_n_3\ : STD_LOGIC;
  signal \Set_Y0_carry_i_1__0_n_0\ : STD_LOGIC;
  signal Set_Y0_carry_i_1_n_0 : STD_LOGIC;
  signal \Set_Y0_carry_i_2__0_n_0\ : STD_LOGIC;
  signal Set_Y0_carry_i_2_n_0 : STD_LOGIC;
  signal \Set_Y0_carry_i_3__0_n_0\ : STD_LOGIC;
  signal Set_Y0_carry_i_3_n_0 : STD_LOGIC;
  signal \Set_Y0_carry_i_4__0_n_0\ : STD_LOGIC;
  signal Set_Y0_carry_i_4_n_0 : STD_LOGIC;
  signal Set_Y0_carry_i_5_n_0 : STD_LOGIC;
  signal Set_Y0_carry_i_6_n_0 : STD_LOGIC;
  signal Set_Y0_carry_i_7_n_0 : STD_LOGIC;
  signal Set_Y0_carry_n_0 : STD_LOGIC;
  signal Set_Y0_carry_n_1 : STD_LOGIC;
  signal Set_Y0_carry_n_2 : STD_LOGIC;
  signal Set_Y0_carry_n_3 : STD_LOGIC;
  signal \Set_Y[11]_i_2_n_0\ : STD_LOGIC;
  signal \Set_Y[11]_i_3_n_0\ : STD_LOGIC;
  signal \Set_Y[11]_i_4_n_0\ : STD_LOGIC;
  signal \Set_Y[11]_i_5_n_0\ : STD_LOGIC;
  signal \Set_Y[3]_i_2_n_0\ : STD_LOGIC;
  signal \Set_Y[3]_i_3_n_0\ : STD_LOGIC;
  signal \Set_Y[7]_i_2_n_0\ : STD_LOGIC;
  signal \Set_Y[7]_i_3_n_0\ : STD_LOGIC;
  signal \Set_Y[7]_i_4_n_0\ : STD_LOGIC;
  signal \Set_Y[7]_i_5_n_0\ : STD_LOGIC;
  signal \Set_Y_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \Set_Y_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \Set_Y_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \Set_Y_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \Set_Y_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \Set_Y_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \Set_Y_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \Set_Y_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \Set_Y_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \Set_Y_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \Set_Y_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal VSync_Cnt0 : STD_LOGIC;
  signal VSync_Cnt0_carry_i_1_n_0 : STD_LOGIC;
  signal VSync_Cnt0_carry_i_2_n_0 : STD_LOGIC;
  signal VSync_Cnt0_carry_i_3_n_0 : STD_LOGIC;
  signal VSync_Cnt0_carry_i_4_n_0 : STD_LOGIC;
  signal VSync_Cnt0_carry_n_1 : STD_LOGIC;
  signal VSync_Cnt0_carry_n_2 : STD_LOGIC;
  signal VSync_Cnt0_carry_n_3 : STD_LOGIC;
  signal VSync_Cnt10_out : STD_LOGIC;
  signal \VSync_Cnt1_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \VSync_Cnt1_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \VSync_Cnt1_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \VSync_Cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[4]_i_4_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[4]_i_5_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[8]_i_2_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \VSync_Cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal VSync_Cnt_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \VSync_Cnt_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \VSync_Cnt_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \VSync_Cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \VSync_Cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal V_De0 : STD_LOGIC;
  signal V_De0_carry_i_1_n_0 : STD_LOGIC;
  signal V_De0_carry_i_2_n_0 : STD_LOGIC;
  signal V_De0_carry_i_3_n_0 : STD_LOGIC;
  signal V_De0_carry_i_4_n_0 : STD_LOGIC;
  signal V_De0_carry_n_1 : STD_LOGIC;
  signal V_De0_carry_n_2 : STD_LOGIC;
  signal V_De0_carry_n_3 : STD_LOGIC;
  signal V_De_i_1_n_0 : STD_LOGIC;
  signal V_De_reg_n_0 : STD_LOGIC;
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_5_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_1__1_n_0\ : STD_LOGIC;
  signal \i__carry_i_1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_2__1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_3__1_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_4__1_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_5_n_0\ : STD_LOGIC;
  signal \i__carry_i_6_n_0\ : STD_LOGIC;
  signal \i__carry_i_7_n_0\ : STD_LOGIC;
  signal NLW_HSync_Cnt1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_HSync_Cnt_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_H_De0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_RGB_HSync0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_RGB_VSync0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_RGB_VSync0_inferred__0/i__carry_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_Set_X0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Set_X0_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_Set_X0_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Set_X0_inferred__0/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_Set_X0_inferred__0/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_Set_Y0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Set_Y0_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_Set_Y0_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Set_Y_reg[11]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_VSync_Cnt0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_VSync_Cnt1_inferred__0/i__carry_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_VSync_Cnt_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_V_De0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of RGB_VDE_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of V_De_i_1 : label is "soft_lutpair0";
begin
  RGB_HSync <= \^rgb_hsync\;
  RGB_VSync <= \^rgb_vsync\;
HSync_Cnt1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => HSync_Cnt1,
      CO(2) => HSync_Cnt1_carry_n_1,
      CO(1) => HSync_Cnt1_carry_n_2,
      CO(0) => HSync_Cnt1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_HSync_Cnt1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => HSync_Cnt1_carry_i_1_n_0,
      S(2) => HSync_Cnt1_carry_i_2_n_0,
      S(1) => HSync_Cnt1_carry_i_3_n_0,
      S(0) => HSync_Cnt1_carry_i_4_n_0
    );
HSync_Cnt1_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0810"
    )
        port map (
      I0 => HSync_Cnt_reg(9),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(11),
      I3 => HSync_Cnt_reg(10),
      O => HSync_Cnt1_carry_i_1_n_0
    );
HSync_Cnt1_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0120"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => HSync_Cnt_reg(8),
      I2 => Video_Mode,
      I3 => HSync_Cnt_reg(7),
      O => HSync_Cnt1_carry_i_2_n_0
    );
HSync_Cnt1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0090"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(5),
      I2 => HSync_Cnt_reg(4),
      I3 => HSync_Cnt_reg(3),
      O => HSync_Cnt1_carry_i_3_n_0
    );
HSync_Cnt1_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2008"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(2),
      I3 => HSync_Cnt_reg(1),
      O => HSync_Cnt1_carry_i_4_n_0
    );
\HSync_Cnt[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[0]_i_2_n_0\
    );
\HSync_Cnt[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(3),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[0]_i_3_n_0\
    );
\HSync_Cnt[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[0]_i_4_n_0\
    );
\HSync_Cnt[0]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(1),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[0]_i_5_n_0\
    );
\HSync_Cnt[0]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[0]_i_6_n_0\
    );
\HSync_Cnt[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(7),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[4]_i_2_n_0\
    );
\HSync_Cnt[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[4]_i_3_n_0\
    );
\HSync_Cnt[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(5),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[4]_i_4_n_0\
    );
\HSync_Cnt[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(4),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[4]_i_5_n_0\
    );
\HSync_Cnt[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(11),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[8]_i_2_n_0\
    );
\HSync_Cnt[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(10),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[8]_i_3_n_0\
    );
\HSync_Cnt[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(9),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[8]_i_4_n_0\
    );
\HSync_Cnt[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(8),
      I1 => HSync_Cnt1,
      O => \HSync_Cnt[8]_i_5_n_0\
    );
\HSync_Cnt_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[0]_i_1_n_7\,
      Q => HSync_Cnt_reg(0)
    );
\HSync_Cnt_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \HSync_Cnt_reg[0]_i_1_n_0\,
      CO(2) => \HSync_Cnt_reg[0]_i_1_n_1\,
      CO(1) => \HSync_Cnt_reg[0]_i_1_n_2\,
      CO(0) => \HSync_Cnt_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \HSync_Cnt[0]_i_2_n_0\,
      O(3) => \HSync_Cnt_reg[0]_i_1_n_4\,
      O(2) => \HSync_Cnt_reg[0]_i_1_n_5\,
      O(1) => \HSync_Cnt_reg[0]_i_1_n_6\,
      O(0) => \HSync_Cnt_reg[0]_i_1_n_7\,
      S(3) => \HSync_Cnt[0]_i_3_n_0\,
      S(2) => \HSync_Cnt[0]_i_4_n_0\,
      S(1) => \HSync_Cnt[0]_i_5_n_0\,
      S(0) => \HSync_Cnt[0]_i_6_n_0\
    );
\HSync_Cnt_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[8]_i_1_n_5\,
      Q => HSync_Cnt_reg(10)
    );
\HSync_Cnt_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[8]_i_1_n_4\,
      Q => HSync_Cnt_reg(11)
    );
\HSync_Cnt_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[0]_i_1_n_6\,
      Q => HSync_Cnt_reg(1)
    );
\HSync_Cnt_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[0]_i_1_n_5\,
      Q => HSync_Cnt_reg(2)
    );
\HSync_Cnt_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[0]_i_1_n_4\,
      Q => HSync_Cnt_reg(3)
    );
\HSync_Cnt_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[4]_i_1_n_7\,
      Q => HSync_Cnt_reg(4)
    );
\HSync_Cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \HSync_Cnt_reg[0]_i_1_n_0\,
      CO(3) => \HSync_Cnt_reg[4]_i_1_n_0\,
      CO(2) => \HSync_Cnt_reg[4]_i_1_n_1\,
      CO(1) => \HSync_Cnt_reg[4]_i_1_n_2\,
      CO(0) => \HSync_Cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \HSync_Cnt_reg[4]_i_1_n_4\,
      O(2) => \HSync_Cnt_reg[4]_i_1_n_5\,
      O(1) => \HSync_Cnt_reg[4]_i_1_n_6\,
      O(0) => \HSync_Cnt_reg[4]_i_1_n_7\,
      S(3) => \HSync_Cnt[4]_i_2_n_0\,
      S(2) => \HSync_Cnt[4]_i_3_n_0\,
      S(1) => \HSync_Cnt[4]_i_4_n_0\,
      S(0) => \HSync_Cnt[4]_i_5_n_0\
    );
\HSync_Cnt_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[4]_i_1_n_6\,
      Q => HSync_Cnt_reg(5)
    );
\HSync_Cnt_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[4]_i_1_n_5\,
      Q => HSync_Cnt_reg(6)
    );
\HSync_Cnt_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[4]_i_1_n_4\,
      Q => HSync_Cnt_reg(7)
    );
\HSync_Cnt_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[8]_i_1_n_7\,
      Q => HSync_Cnt_reg(8)
    );
\HSync_Cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \HSync_Cnt_reg[4]_i_1_n_0\,
      CO(3) => \NLW_HSync_Cnt_reg[8]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \HSync_Cnt_reg[8]_i_1_n_1\,
      CO(1) => \HSync_Cnt_reg[8]_i_1_n_2\,
      CO(0) => \HSync_Cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \HSync_Cnt_reg[8]_i_1_n_4\,
      O(2) => \HSync_Cnt_reg[8]_i_1_n_5\,
      O(1) => \HSync_Cnt_reg[8]_i_1_n_6\,
      O(0) => \HSync_Cnt_reg[8]_i_1_n_7\,
      S(3) => \HSync_Cnt[8]_i_2_n_0\,
      S(2) => \HSync_Cnt[8]_i_3_n_0\,
      S(1) => \HSync_Cnt[8]_i_4_n_0\,
      S(0) => \HSync_Cnt[8]_i_5_n_0\
    );
\HSync_Cnt_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => \HSync_Cnt_reg[8]_i_1_n_6\,
      Q => HSync_Cnt_reg(9)
    );
H_De0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => H_De0,
      CO(2) => H_De0_carry_n_1,
      CO(1) => H_De0_carry_n_2,
      CO(0) => H_De0_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_H_De0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => H_De0_carry_i_1_n_0,
      S(2) => H_De0_carry_i_2_n_0,
      S(1) => H_De0_carry_i_3_n_0,
      S(0) => H_De0_carry_i_4_n_0
    );
H_De0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => HSync_Cnt_reg(11),
      I1 => HSync_Cnt_reg(10),
      I2 => HSync_Cnt_reg(9),
      O => H_De0_carry_i_1_n_0
    );
H_De0_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0900"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(7),
      I3 => HSync_Cnt_reg(8),
      O => H_De0_carry_i_2_n_0
    );
H_De0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0090"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(5),
      I2 => HSync_Cnt_reg(4),
      I3 => HSync_Cnt_reg(3),
      O => H_De0_carry_i_3_n_0
    );
H_De0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2008"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(2),
      I3 => HSync_Cnt_reg(1),
      O => H_De0_carry_i_4_n_0
    );
H_De_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => H_De0,
      I1 => HSync_Cnt1,
      I2 => H_De,
      O => H_De_i_1_n_0
    );
H_De_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => H_De_i_1_n_0,
      Q => H_De
    );
RGB_HSync0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => RGB_HSync0,
      CO(2) => RGB_HSync0_carry_n_1,
      CO(1) => RGB_HSync0_carry_n_2,
      CO(0) => RGB_HSync0_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_RGB_HSync0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => RGB_HSync0_carry_i_1_n_0,
      S(2) => RGB_HSync0_carry_i_2_n_0,
      S(1) => RGB_HSync0_carry_i_3_n_0,
      S(0) => RGB_HSync0_carry_i_4_n_0
    );
RGB_HSync0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => HSync_Cnt_reg(11),
      I1 => HSync_Cnt_reg(10),
      I2 => HSync_Cnt_reg(9),
      O => RGB_HSync0_carry_i_1_n_0
    );
RGB_HSync0_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => HSync_Cnt_reg(8),
      I1 => HSync_Cnt_reg(7),
      I2 => HSync_Cnt_reg(6),
      O => RGB_HSync0_carry_i_2_n_0
    );
RGB_HSync0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0041"
    )
        port map (
      I0 => HSync_Cnt_reg(5),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(4),
      I3 => HSync_Cnt_reg(3),
      O => RGB_HSync0_carry_i_3_n_0
    );
RGB_HSync0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0280"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(2),
      I3 => HSync_Cnt_reg(1),
      O => RGB_HSync0_carry_i_4_n_0
    );
RGB_HSync_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => VSync_Cnt0,
      I1 => RGB_HSync0,
      I2 => \^rgb_hsync\,
      O => RGB_HSync_i_1_n_0
    );
RGB_HSync_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Rst,
      O => RGB_HSync_i_2_n_0
    );
RGB_HSync_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => RGB_HSync_i_1_n_0,
      Q => \^rgb_hsync\
    );
RGB_VDE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => H_De,
      I1 => V_De_reg_n_0,
      O => RGB_VDE0
    );
RGB_VDE_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => RGB_VDE0,
      Q => RGB_VDE
    );
RGB_VSync0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => RGB_VSync0,
      CO(2) => RGB_VSync0_carry_n_1,
      CO(1) => RGB_VSync0_carry_n_2,
      CO(0) => RGB_VSync0_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_RGB_VSync0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => RGB_VSync0_carry_i_1_n_0,
      S(2) => RGB_VSync0_carry_i_2_n_0,
      S(1) => RGB_VSync0_carry_i_3_n_0,
      S(0) => RGB_VSync0_carry_i_4_n_0
    );
RGB_VSync0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(11),
      I1 => VSync_Cnt_reg(10),
      I2 => VSync_Cnt_reg(9),
      O => RGB_VSync0_carry_i_1_n_0
    );
RGB_VSync0_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt_reg(7),
      I2 => VSync_Cnt_reg(6),
      O => RGB_VSync0_carry_i_2_n_0
    );
RGB_VSync0_carry_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(5),
      I1 => VSync_Cnt_reg(4),
      I2 => VSync_Cnt_reg(3),
      O => RGB_VSync0_carry_i_3_n_0
    );
RGB_VSync0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0240"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(2),
      I3 => VSync_Cnt_reg(1),
      O => RGB_VSync0_carry_i_4_n_0
    );
\RGB_VSync0_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \RGB_VSync0_inferred__0/i__carry_n_0\,
      CO(2) => \RGB_VSync0_inferred__0/i__carry_n_1\,
      CO(1) => \RGB_VSync0_inferred__0/i__carry_n_2\,
      CO(0) => \RGB_VSync0_inferred__0/i__carry_n_3\,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_RGB_VSync0_inferred__0/i__carry_O_UNCONNECTED\(3 downto 0),
      S(3) => \i__carry_i_1__1_n_0\,
      S(2) => \i__carry_i_2__1_n_0\,
      S(1) => \i__carry_i_3__0_n_0\,
      S(0) => \i__carry_i_4_n_0\
    );
RGB_VSync_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F7A0"
    )
        port map (
      I0 => VSync_Cnt0,
      I1 => \RGB_VSync0_inferred__0/i__carry_n_0\,
      I2 => RGB_VSync0,
      I3 => \^rgb_vsync\,
      O => RGB_VSync_i_1_n_0
    );
RGB_VSync_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => RGB_VSync_i_1_n_0,
      Q => \^rgb_vsync\
    );
Set_X0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => Set_X0_carry_n_0,
      CO(2) => Set_X0_carry_n_1,
      CO(1) => Set_X0_carry_n_2,
      CO(0) => Set_X0_carry_n_3,
      CYINIT => '1',
      DI(3) => Set_X0_carry_i_1_n_0,
      DI(2) => Set_X0_carry_i_2_n_0,
      DI(1) => Set_X0_carry_i_3_n_0,
      DI(0) => Set_X0_carry_i_4_n_0,
      O(3 downto 0) => NLW_Set_X0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => Set_X0_carry_i_5_n_0,
      S(2) => Set_X0_carry_i_6_n_0,
      S(1) => Set_X0_carry_i_7_n_0,
      S(0) => Set_X0_carry_i_8_n_0
    );
\Set_X0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => Set_X0_carry_n_0,
      CO(3 downto 2) => \NLW_Set_X0_carry__0_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \Set_X0_carry__0_n_2\,
      CO(0) => \Set_X0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \Set_X0_carry__0_i_1_n_0\,
      DI(0) => HSync_Cnt_reg(9),
      O(3 downto 0) => \NLW_Set_X0_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => B"00",
      S(1) => \Set_X0_carry__0_i_2_n_0\,
      S(0) => \Set_X0_carry__0_i_3_n_0\
    );
\Set_X0_carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => HSync_Cnt_reg(10),
      I1 => HSync_Cnt_reg(11),
      O => \Set_X0_carry__0_i_1_n_0\
    );
\Set_X0_carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(10),
      I1 => HSync_Cnt_reg(11),
      O => \Set_X0_carry__0_i_2_n_0\
    );
\Set_X0_carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(8),
      I1 => HSync_Cnt_reg(9),
      O => \Set_X0_carry__0_i_3_n_0\
    );
Set_X0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F2"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(7),
      O => Set_X0_carry_i_1_n_0
    );
Set_X0_carry_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(5),
      I1 => Video_Mode,
      O => Set_X0_carry_i_2_n_0
    );
Set_X0_carry_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(2),
      I2 => HSync_Cnt_reg(3),
      O => Set_X0_carry_i_3_n_0
    );
Set_X0_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(1),
      O => Set_X0_carry_i_4_n_0
    );
Set_X0_carry_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"09"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(7),
      O => Set_X0_carry_i_5_n_0
    );
Set_X0_carry_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"82"
    )
        port map (
      I0 => HSync_Cnt_reg(4),
      I1 => HSync_Cnt_reg(5),
      I2 => Video_Mode,
      O => Set_X0_carry_i_6_n_0
    );
Set_X0_carry_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(3),
      O => Set_X0_carry_i_7_n_0
    );
Set_X0_carry_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => HSync_Cnt_reg(1),
      I2 => Video_Mode,
      O => Set_X0_carry_i_8_n_0
    );
\Set_X0_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Set_X0_inferred__0/i__carry_n_0\,
      CO(2) => \Set_X0_inferred__0/i__carry_n_1\,
      CO(1) => \Set_X0_inferred__0/i__carry_n_2\,
      CO(0) => \Set_X0_inferred__0/i__carry_n_3\,
      CYINIT => HSync_Cnt_reg(0),
      DI(3) => \i__carry_i_1__0_n_0\,
      DI(2) => \i__carry_i_2__0_n_0\,
      DI(1) => \i__carry_i_3__1_n_0\,
      DI(0) => Video_Mode,
      O(3 downto 0) => Set_X0(4 downto 1),
      S(3) => \i__carry_i_4__1_n_0\,
      S(2) => \i__carry_i_5_n_0\,
      S(1) => \i__carry_i_6_n_0\,
      S(0) => \i__carry_i_7_n_0\
    );
\Set_X0_inferred__0/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \Set_X0_inferred__0/i__carry_n_0\,
      CO(3) => \Set_X0_inferred__0/i__carry__0_n_0\,
      CO(2) => \Set_X0_inferred__0/i__carry__0_n_1\,
      CO(1) => \Set_X0_inferred__0/i__carry__0_n_2\,
      CO(0) => \Set_X0_inferred__0/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => HSync_Cnt_reg(7),
      DI(1) => \i__carry__0_i_1_n_0\,
      DI(0) => \i__carry__0_i_2_n_0\,
      O(3 downto 0) => Set_X0(8 downto 5),
      S(3) => HSync_Cnt_reg(8),
      S(2) => \i__carry__0_i_3_n_0\,
      S(1) => \i__carry__0_i_4_n_0\,
      S(0) => \i__carry__0_i_5_n_0\
    );
\Set_X0_inferred__0/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Set_X0_inferred__0/i__carry__0_n_0\,
      CO(3 downto 2) => \NLW_Set_X0_inferred__0/i__carry__1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \Set_X0_inferred__0/i__carry__1_n_2\,
      CO(0) => \Set_X0_inferred__0/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => HSync_Cnt_reg(10 downto 9),
      O(3) => \NLW_Set_X0_inferred__0/i__carry__1_O_UNCONNECTED\(3),
      O(2 downto 0) => Set_X0(11 downto 9),
      S(3) => '0',
      S(2) => \i__carry__1_i_1_n_0\,
      S(1) => \i__carry__1_i_2_n_0\,
      S(0) => \i__carry__1_i_3_n_0\
    );
\Set_X[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      O => Set_X0(0)
    );
\Set_X_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(0),
      Q => Set_X(0)
    );
\Set_X_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(10),
      Q => Set_X(10)
    );
\Set_X_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(11),
      Q => Set_X(11)
    );
\Set_X_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(1),
      Q => Set_X(1)
    );
\Set_X_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(2),
      Q => Set_X(2)
    );
\Set_X_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(3),
      Q => Set_X(3)
    );
\Set_X_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(4),
      Q => Set_X(4)
    );
\Set_X_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(5),
      Q => Set_X(5)
    );
\Set_X_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(6),
      Q => Set_X(6)
    );
\Set_X_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(7),
      Q => Set_X(7)
    );
\Set_X_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(8),
      Q => Set_X(8)
    );
\Set_X_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_X0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_X0(9),
      Q => Set_X(9)
    );
Set_Y0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => Set_Y0_carry_n_0,
      CO(2) => Set_Y0_carry_n_1,
      CO(1) => Set_Y0_carry_n_2,
      CO(0) => Set_Y0_carry_n_3,
      CYINIT => '1',
      DI(3) => Set_Y0_carry_i_1_n_0,
      DI(2) => Set_Y0_carry_i_2_n_0,
      DI(1) => '0',
      DI(0) => Set_Y0_carry_i_3_n_0,
      O(3 downto 0) => NLW_Set_Y0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => \Set_Y0_carry_i_4__0_n_0\,
      S(2) => Set_Y0_carry_i_5_n_0,
      S(1) => Set_Y0_carry_i_6_n_0,
      S(0) => Set_Y0_carry_i_7_n_0
    );
\Set_Y0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => Set_Y0_carry_n_0,
      CO(3 downto 2) => \NLW_Set_Y0_carry__0_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \Set_Y0_carry__0_n_2\,
      CO(0) => \Set_Y0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \Set_Y0_carry_i_1__0_n_0\,
      DI(0) => \Set_Y0_carry_i_2__0_n_0\,
      O(3 downto 0) => \NLW_Set_Y0_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => B"00",
      S(1) => \Set_Y0_carry_i_3__0_n_0\,
      S(0) => Set_Y0_carry_i_4_n_0
    );
Set_Y0_carry_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => VSync_Cnt_reg(6),
      I1 => VSync_Cnt_reg(7),
      O => Set_Y0_carry_i_1_n_0
    );
\Set_Y0_carry_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => VSync_Cnt_reg(10),
      I1 => VSync_Cnt_reg(11),
      O => \Set_Y0_carry_i_1__0_n_0\
    );
Set_Y0_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C8"
    )
        port map (
      I0 => VSync_Cnt_reg(4),
      I1 => VSync_Cnt_reg(5),
      I2 => Video_Mode,
      O => Set_Y0_carry_i_2_n_0
    );
\Set_Y0_carry_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt_reg(9),
      O => \Set_Y0_carry_i_2__0_n_0\
    );
Set_Y0_carry_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F2"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(1),
      O => Set_Y0_carry_i_3_n_0
    );
\Set_Y0_carry_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(10),
      I1 => VSync_Cnt_reg(11),
      O => \Set_Y0_carry_i_3__0_n_0\
    );
Set_Y0_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt_reg(9),
      O => Set_Y0_carry_i_4_n_0
    );
\Set_Y0_carry_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(6),
      I1 => VSync_Cnt_reg(7),
      O => \Set_Y0_carry_i_4__0_n_0\
    );
Set_Y0_carry_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"24"
    )
        port map (
      I0 => VSync_Cnt_reg(4),
      I1 => VSync_Cnt_reg(5),
      I2 => Video_Mode,
      O => Set_Y0_carry_i_5_n_0
    );
Set_Y0_carry_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => VSync_Cnt_reg(2),
      I1 => VSync_Cnt_reg(3),
      O => Set_Y0_carry_i_6_n_0
    );
Set_Y0_carry_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"09"
    )
        port map (
      I0 => Video_Mode,
      I1 => VSync_Cnt_reg(0),
      I2 => VSync_Cnt_reg(1),
      O => Set_Y0_carry_i_7_n_0
    );
\Set_Y[11]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(11),
      O => \Set_Y[11]_i_2_n_0\
    );
\Set_Y[11]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(10),
      O => \Set_Y[11]_i_3_n_0\
    );
\Set_Y[11]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(9),
      O => \Set_Y[11]_i_4_n_0\
    );
\Set_Y[11]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      O => \Set_Y[11]_i_5_n_0\
    );
\Set_Y[3]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(1),
      O => \Set_Y[3]_i_2_n_0\
    );
\Set_Y[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      O => \Set_Y[3]_i_3_n_0\
    );
\Set_Y[7]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(7),
      O => \Set_Y[7]_i_2_n_0\
    );
\Set_Y[7]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(6),
      O => \Set_Y[7]_i_3_n_0\
    );
\Set_Y[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => VSync_Cnt_reg(5),
      I1 => Video_Mode,
      O => \Set_Y[7]_i_4_n_0\
    );
\Set_Y[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => VSync_Cnt_reg(4),
      I1 => Video_Mode,
      O => \Set_Y[7]_i_5_n_0\
    );
\Set_Y_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(0),
      Q => Set_Y(0)
    );
\Set_Y_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(10),
      Q => Set_Y(10)
    );
\Set_Y_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(11),
      Q => Set_Y(11)
    );
\Set_Y_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Set_Y_reg[7]_i_1_n_0\,
      CO(3) => \NLW_Set_Y_reg[11]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \Set_Y_reg[11]_i_1_n_1\,
      CO(1) => \Set_Y_reg[11]_i_1_n_2\,
      CO(0) => \Set_Y_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => VSync_Cnt_reg(10 downto 8),
      O(3 downto 0) => Set_Y0(11 downto 8),
      S(3) => \Set_Y[11]_i_2_n_0\,
      S(2) => \Set_Y[11]_i_3_n_0\,
      S(1) => \Set_Y[11]_i_4_n_0\,
      S(0) => \Set_Y[11]_i_5_n_0\
    );
\Set_Y_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(1),
      Q => Set_Y(1)
    );
\Set_Y_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(2),
      Q => Set_Y(2)
    );
\Set_Y_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(3),
      Q => Set_Y(3)
    );
\Set_Y_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Set_Y_reg[3]_i_1_n_0\,
      CO(2) => \Set_Y_reg[3]_i_1_n_1\,
      CO(1) => \Set_Y_reg[3]_i_1_n_2\,
      CO(0) => \Set_Y_reg[3]_i_1_n_3\,
      CYINIT => '1',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => VSync_Cnt_reg(1 downto 0),
      O(3 downto 0) => Set_Y0(3 downto 0),
      S(3 downto 2) => VSync_Cnt_reg(3 downto 2),
      S(1) => \Set_Y[3]_i_2_n_0\,
      S(0) => \Set_Y[3]_i_3_n_0\
    );
\Set_Y_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(4),
      Q => Set_Y(4)
    );
\Set_Y_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(5),
      Q => Set_Y(5)
    );
\Set_Y_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(6),
      Q => Set_Y(6)
    );
\Set_Y_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(7),
      Q => Set_Y(7)
    );
\Set_Y_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Set_Y_reg[3]_i_1_n_0\,
      CO(3) => \Set_Y_reg[7]_i_1_n_0\,
      CO(2) => \Set_Y_reg[7]_i_1_n_1\,
      CO(1) => \Set_Y_reg[7]_i_1_n_2\,
      CO(0) => \Set_Y_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => VSync_Cnt_reg(7 downto 4),
      O(3 downto 0) => Set_Y0(7 downto 4),
      S(3) => \Set_Y[7]_i_2_n_0\,
      S(2) => \Set_Y[7]_i_3_n_0\,
      S(1) => \Set_Y[7]_i_4_n_0\,
      S(0) => \Set_Y[7]_i_5_n_0\
    );
\Set_Y_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(8),
      Q => Set_Y(8)
    );
\Set_Y_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \Set_Y0_carry__0_n_2\,
      CLR => RGB_HSync_i_2_n_0,
      D => Set_Y0(9),
      Q => Set_Y(9)
    );
VSync_Cnt0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => VSync_Cnt0,
      CO(2) => VSync_Cnt0_carry_n_1,
      CO(1) => VSync_Cnt0_carry_n_2,
      CO(0) => VSync_Cnt0_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_VSync_Cnt0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => VSync_Cnt0_carry_i_1_n_0,
      S(2) => VSync_Cnt0_carry_i_2_n_0,
      S(1) => VSync_Cnt0_carry_i_3_n_0,
      S(0) => VSync_Cnt0_carry_i_4_n_0
    );
VSync_Cnt0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => HSync_Cnt_reg(11),
      I1 => HSync_Cnt_reg(10),
      I2 => HSync_Cnt_reg(9),
      O => VSync_Cnt0_carry_i_1_n_0
    );
VSync_Cnt0_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => HSync_Cnt_reg(6),
      I1 => HSync_Cnt_reg(8),
      I2 => HSync_Cnt_reg(7),
      O => VSync_Cnt0_carry_i_2_n_0
    );
VSync_Cnt0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0180"
    )
        port map (
      I0 => HSync_Cnt_reg(3),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(5),
      I3 => HSync_Cnt_reg(4),
      O => VSync_Cnt0_carry_i_3_n_0
    );
VSync_Cnt0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0880"
    )
        port map (
      I0 => HSync_Cnt_reg(0),
      I1 => HSync_Cnt_reg(2),
      I2 => Video_Mode,
      I3 => HSync_Cnt_reg(1),
      O => VSync_Cnt0_carry_i_4_n_0
    );
\VSync_Cnt1_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => VSync_Cnt10_out,
      CO(2) => \VSync_Cnt1_inferred__0/i__carry_n_1\,
      CO(1) => \VSync_Cnt1_inferred__0/i__carry_n_2\,
      CO(0) => \VSync_Cnt1_inferred__0/i__carry_n_3\,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_VSync_Cnt1_inferred__0/i__carry_O_UNCONNECTED\(3 downto 0),
      S(3) => \i__carry_i_1_n_0\,
      S(2) => \i__carry_i_2_n_0\,
      S(1) => \i__carry_i_3_n_0\,
      S(0) => \i__carry_i_4__0_n_0\
    );
\VSync_Cnt[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[0]_i_2_n_0\
    );
\VSync_Cnt[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(3),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[0]_i_3_n_0\
    );
\VSync_Cnt[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(2),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[0]_i_4_n_0\
    );
\VSync_Cnt[0]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(1),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[0]_i_5_n_0\
    );
\VSync_Cnt[0]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[0]_i_6_n_0\
    );
\VSync_Cnt[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(7),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[4]_i_2_n_0\
    );
\VSync_Cnt[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(6),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[4]_i_3_n_0\
    );
\VSync_Cnt[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(5),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[4]_i_4_n_0\
    );
\VSync_Cnt[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(4),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[4]_i_5_n_0\
    );
\VSync_Cnt[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(11),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[8]_i_2_n_0\
    );
\VSync_Cnt[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(10),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[8]_i_3_n_0\
    );
\VSync_Cnt[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(9),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[8]_i_4_n_0\
    );
\VSync_Cnt[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt10_out,
      O => \VSync_Cnt[8]_i_5_n_0\
    );
\VSync_Cnt_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[0]_i_1_n_7\,
      Q => VSync_Cnt_reg(0)
    );
\VSync_Cnt_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \VSync_Cnt_reg[0]_i_1_n_0\,
      CO(2) => \VSync_Cnt_reg[0]_i_1_n_1\,
      CO(1) => \VSync_Cnt_reg[0]_i_1_n_2\,
      CO(0) => \VSync_Cnt_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \VSync_Cnt[0]_i_2_n_0\,
      O(3) => \VSync_Cnt_reg[0]_i_1_n_4\,
      O(2) => \VSync_Cnt_reg[0]_i_1_n_5\,
      O(1) => \VSync_Cnt_reg[0]_i_1_n_6\,
      O(0) => \VSync_Cnt_reg[0]_i_1_n_7\,
      S(3) => \VSync_Cnt[0]_i_3_n_0\,
      S(2) => \VSync_Cnt[0]_i_4_n_0\,
      S(1) => \VSync_Cnt[0]_i_5_n_0\,
      S(0) => \VSync_Cnt[0]_i_6_n_0\
    );
\VSync_Cnt_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[8]_i_1_n_5\,
      Q => VSync_Cnt_reg(10)
    );
\VSync_Cnt_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[8]_i_1_n_4\,
      Q => VSync_Cnt_reg(11)
    );
\VSync_Cnt_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[0]_i_1_n_6\,
      Q => VSync_Cnt_reg(1)
    );
\VSync_Cnt_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[0]_i_1_n_5\,
      Q => VSync_Cnt_reg(2)
    );
\VSync_Cnt_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[0]_i_1_n_4\,
      Q => VSync_Cnt_reg(3)
    );
\VSync_Cnt_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[4]_i_1_n_7\,
      Q => VSync_Cnt_reg(4)
    );
\VSync_Cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \VSync_Cnt_reg[0]_i_1_n_0\,
      CO(3) => \VSync_Cnt_reg[4]_i_1_n_0\,
      CO(2) => \VSync_Cnt_reg[4]_i_1_n_1\,
      CO(1) => \VSync_Cnt_reg[4]_i_1_n_2\,
      CO(0) => \VSync_Cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \VSync_Cnt_reg[4]_i_1_n_4\,
      O(2) => \VSync_Cnt_reg[4]_i_1_n_5\,
      O(1) => \VSync_Cnt_reg[4]_i_1_n_6\,
      O(0) => \VSync_Cnt_reg[4]_i_1_n_7\,
      S(3) => \VSync_Cnt[4]_i_2_n_0\,
      S(2) => \VSync_Cnt[4]_i_3_n_0\,
      S(1) => \VSync_Cnt[4]_i_4_n_0\,
      S(0) => \VSync_Cnt[4]_i_5_n_0\
    );
\VSync_Cnt_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[4]_i_1_n_6\,
      Q => VSync_Cnt_reg(5)
    );
\VSync_Cnt_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[4]_i_1_n_5\,
      Q => VSync_Cnt_reg(6)
    );
\VSync_Cnt_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[4]_i_1_n_4\,
      Q => VSync_Cnt_reg(7)
    );
\VSync_Cnt_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[8]_i_1_n_7\,
      Q => VSync_Cnt_reg(8)
    );
\VSync_Cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \VSync_Cnt_reg[4]_i_1_n_0\,
      CO(3) => \NLW_VSync_Cnt_reg[8]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \VSync_Cnt_reg[8]_i_1_n_1\,
      CO(1) => \VSync_Cnt_reg[8]_i_1_n_2\,
      CO(0) => \VSync_Cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \VSync_Cnt_reg[8]_i_1_n_4\,
      O(2) => \VSync_Cnt_reg[8]_i_1_n_5\,
      O(1) => \VSync_Cnt_reg[8]_i_1_n_6\,
      O(0) => \VSync_Cnt_reg[8]_i_1_n_7\,
      S(3) => \VSync_Cnt[8]_i_2_n_0\,
      S(2) => \VSync_Cnt[8]_i_3_n_0\,
      S(1) => \VSync_Cnt[8]_i_4_n_0\,
      S(0) => \VSync_Cnt[8]_i_5_n_0\
    );
\VSync_Cnt_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => VSync_Cnt0,
      CLR => RGB_HSync_i_2_n_0,
      D => \VSync_Cnt_reg[8]_i_1_n_6\,
      Q => VSync_Cnt_reg(9)
    );
V_De0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => V_De0,
      CO(2) => V_De0_carry_n_1,
      CO(1) => V_De0_carry_n_2,
      CO(0) => V_De0_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_V_De0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => V_De0_carry_i_1_n_0,
      S(2) => V_De0_carry_i_2_n_0,
      S(1) => V_De0_carry_i_3_n_0,
      S(0) => V_De0_carry_i_4_n_0
    );
V_De0_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(11),
      I1 => VSync_Cnt_reg(10),
      I2 => VSync_Cnt_reg(9),
      O => V_De0_carry_i_1_n_0
    );
V_De0_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt_reg(7),
      I2 => VSync_Cnt_reg(6),
      O => V_De0_carry_i_2_n_0
    );
V_De0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0820"
    )
        port map (
      I0 => VSync_Cnt_reg(3),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(5),
      I3 => VSync_Cnt_reg(4),
      O => V_De0_carry_i_3_n_0
    );
V_De0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0900"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(1),
      I3 => VSync_Cnt_reg(2),
      O => V_De0_carry_i_4_n_0
    );
V_De_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F7A0"
    )
        port map (
      I0 => VSync_Cnt0,
      I1 => VSync_Cnt10_out,
      I2 => V_De0,
      I3 => V_De_reg_n_0,
      O => V_De_i_1_n_0
    );
V_De_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => RGB_HSync_i_2_n_0,
      D => V_De_i_1_n_0,
      Q => V_De_reg_n_0
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => HSync_Cnt_reg(5),
      I1 => Video_Mode,
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => HSync_Cnt_reg(4),
      I1 => Video_Mode,
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2D"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(6),
      I2 => HSync_Cnt_reg(7),
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"87"
    )
        port map (
      I0 => HSync_Cnt_reg(5),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(6),
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__0_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
        port map (
      I0 => HSync_Cnt_reg(4),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(5),
      O => \i__carry__0_i_5_n_0\
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(11),
      O => \i__carry__1_i_1_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(10),
      O => \i__carry__1_i_2_n_0\
    );
\i__carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(9),
      O => \i__carry__1_i_3_n_0\
    );
\i__carry_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0120"
    )
        port map (
      I0 => VSync_Cnt_reg(9),
      I1 => VSync_Cnt_reg(11),
      I2 => Video_Mode,
      I3 => VSync_Cnt_reg(10),
      O => \i__carry_i_1_n_0\
    );
\i__carry_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => HSync_Cnt_reg(3),
      I1 => Video_Mode,
      O => \i__carry_i_1__0_n_0\
    );
\i__carry_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(11),
      I1 => VSync_Cnt_reg(10),
      I2 => VSync_Cnt_reg(9),
      O => \i__carry_i_1__1_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2002"
    )
        port map (
      I0 => VSync_Cnt_reg(6),
      I1 => VSync_Cnt_reg(8),
      I2 => Video_Mode,
      I3 => VSync_Cnt_reg(7),
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      O => \i__carry_i_2__0_n_0\
    );
\i__carry_i_2__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => VSync_Cnt_reg(8),
      I1 => VSync_Cnt_reg(7),
      I2 => VSync_Cnt_reg(6),
      O => \i__carry_i_2__1_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0900"
    )
        port map (
      I0 => VSync_Cnt_reg(3),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(4),
      I3 => VSync_Cnt_reg(5),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => VSync_Cnt_reg(3),
      I1 => VSync_Cnt_reg(5),
      I2 => VSync_Cnt_reg(4),
      O => \i__carry_i_3__0_n_0\
    );
\i__carry_i_3__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      O => \i__carry_i_3__1_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0009"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(2),
      I3 => VSync_Cnt_reg(1),
      O => \i__carry_i_4_n_0\
    );
\i__carry_i_4__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0900"
    )
        port map (
      I0 => VSync_Cnt_reg(0),
      I1 => Video_Mode,
      I2 => VSync_Cnt_reg(1),
      I3 => VSync_Cnt_reg(2),
      O => \i__carry_i_4__0_n_0\
    );
\i__carry_i_4__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => HSync_Cnt_reg(3),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(4),
      O => \i__carry_i_4__1_n_0\
    );
\i__carry_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      I1 => Video_Mode,
      I2 => HSync_Cnt_reg(3),
      O => \i__carry_i_5_n_0\
    );
\i__carry_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => HSync_Cnt_reg(2),
      I1 => Video_Mode,
      O => \i__carry_i_6_n_0\
    );
\i__carry_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => Video_Mode,
      I1 => HSync_Cnt_reg(1),
      O => \i__carry_i_7_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    Video_Mode : in STD_LOGIC;
    RGB_In : in STD_LOGIC_VECTOR ( 23 downto 0 );
    RGB_Data : out STD_LOGIC_VECTOR ( 23 downto 0 );
    RGB_HSync : out STD_LOGIC;
    RGB_VSync : out STD_LOGIC;
    RGB_VDE : out STD_LOGIC;
    Set_X : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Set_Y : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "Driver_HDMI_0,Driver_HDMI,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "Driver_HDMI,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \^rgb_in\ : STD_LOGIC_VECTOR ( 23 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of Rst : signal is "xilinx.com:signal:reset:1.0 Rst RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of Rst : signal is "XIL_INTERFACENAME Rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET Rst, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
begin
  RGB_Data(23 downto 0) <= \^rgb_in\(23 downto 0);
  \^rgb_in\(23 downto 0) <= RGB_In(23 downto 0);
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI
     port map (
      RGB_HSync => RGB_HSync,
      RGB_VDE => RGB_VDE,
      RGB_VSync => RGB_VSync,
      Rst => Rst,
      Set_X(11 downto 0) => Set_X(11 downto 0),
      Set_Y(11 downto 0) => Set_Y(11 downto 0),
      Video_Mode => Video_Mode,
      clk => clk
    );
end STRUCTURE;
