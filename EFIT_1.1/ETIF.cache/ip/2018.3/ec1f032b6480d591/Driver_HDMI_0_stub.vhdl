-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Aug  2 13:03:58 2020
-- Host        : ThinkPad running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Driver_HDMI_0_stub.vhdl
-- Design      : Driver_HDMI_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,Rst,Video_Mode,RGB_In[23:0],RGB_Data[23:0],RGB_HSync,RGB_VSync,RGB_VDE,Set_X[11:0],Set_Y[11:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Driver_HDMI,Vivado 2018.3";
begin
end;
