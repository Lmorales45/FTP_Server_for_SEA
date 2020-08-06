// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Aug  2 13:03:58 2020
// Host        : ThinkPad running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Driver_HDMI_0_sim_netlist.v
// Design      : Driver_HDMI_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI
   (RGB_VDE,
    Set_X,
    Set_Y,
    RGB_HSync,
    RGB_VSync,
    Video_Mode,
    clk,
    Rst);
  output RGB_VDE;
  output [11:0]Set_X;
  output [11:0]Set_Y;
  output RGB_HSync;
  output RGB_VSync;
  input Video_Mode;
  input clk;
  input Rst;

  wire HSync_Cnt1;
  wire HSync_Cnt1_carry_i_1_n_0;
  wire HSync_Cnt1_carry_i_2_n_0;
  wire HSync_Cnt1_carry_i_3_n_0;
  wire HSync_Cnt1_carry_i_4_n_0;
  wire HSync_Cnt1_carry_n_1;
  wire HSync_Cnt1_carry_n_2;
  wire HSync_Cnt1_carry_n_3;
  wire \HSync_Cnt[0]_i_2_n_0 ;
  wire \HSync_Cnt[0]_i_3_n_0 ;
  wire \HSync_Cnt[0]_i_4_n_0 ;
  wire \HSync_Cnt[0]_i_5_n_0 ;
  wire \HSync_Cnt[0]_i_6_n_0 ;
  wire \HSync_Cnt[4]_i_2_n_0 ;
  wire \HSync_Cnt[4]_i_3_n_0 ;
  wire \HSync_Cnt[4]_i_4_n_0 ;
  wire \HSync_Cnt[4]_i_5_n_0 ;
  wire \HSync_Cnt[8]_i_2_n_0 ;
  wire \HSync_Cnt[8]_i_3_n_0 ;
  wire \HSync_Cnt[8]_i_4_n_0 ;
  wire \HSync_Cnt[8]_i_5_n_0 ;
  wire [11:0]HSync_Cnt_reg;
  wire \HSync_Cnt_reg[0]_i_1_n_0 ;
  wire \HSync_Cnt_reg[0]_i_1_n_1 ;
  wire \HSync_Cnt_reg[0]_i_1_n_2 ;
  wire \HSync_Cnt_reg[0]_i_1_n_3 ;
  wire \HSync_Cnt_reg[0]_i_1_n_4 ;
  wire \HSync_Cnt_reg[0]_i_1_n_5 ;
  wire \HSync_Cnt_reg[0]_i_1_n_6 ;
  wire \HSync_Cnt_reg[0]_i_1_n_7 ;
  wire \HSync_Cnt_reg[4]_i_1_n_0 ;
  wire \HSync_Cnt_reg[4]_i_1_n_1 ;
  wire \HSync_Cnt_reg[4]_i_1_n_2 ;
  wire \HSync_Cnt_reg[4]_i_1_n_3 ;
  wire \HSync_Cnt_reg[4]_i_1_n_4 ;
  wire \HSync_Cnt_reg[4]_i_1_n_5 ;
  wire \HSync_Cnt_reg[4]_i_1_n_6 ;
  wire \HSync_Cnt_reg[4]_i_1_n_7 ;
  wire \HSync_Cnt_reg[8]_i_1_n_1 ;
  wire \HSync_Cnt_reg[8]_i_1_n_2 ;
  wire \HSync_Cnt_reg[8]_i_1_n_3 ;
  wire \HSync_Cnt_reg[8]_i_1_n_4 ;
  wire \HSync_Cnt_reg[8]_i_1_n_5 ;
  wire \HSync_Cnt_reg[8]_i_1_n_6 ;
  wire \HSync_Cnt_reg[8]_i_1_n_7 ;
  wire H_De;
  wire H_De0;
  wire H_De0_carry_i_1_n_0;
  wire H_De0_carry_i_2_n_0;
  wire H_De0_carry_i_3_n_0;
  wire H_De0_carry_i_4_n_0;
  wire H_De0_carry_n_1;
  wire H_De0_carry_n_2;
  wire H_De0_carry_n_3;
  wire H_De_i_1_n_0;
  wire RGB_HSync;
  wire RGB_HSync0;
  wire RGB_HSync0_carry_i_1_n_0;
  wire RGB_HSync0_carry_i_2_n_0;
  wire RGB_HSync0_carry_i_3_n_0;
  wire RGB_HSync0_carry_i_4_n_0;
  wire RGB_HSync0_carry_n_1;
  wire RGB_HSync0_carry_n_2;
  wire RGB_HSync0_carry_n_3;
  wire RGB_HSync_i_1_n_0;
  wire RGB_HSync_i_2_n_0;
  wire RGB_VDE;
  wire RGB_VDE0;
  wire RGB_VSync;
  wire RGB_VSync0;
  wire RGB_VSync0_carry_i_1_n_0;
  wire RGB_VSync0_carry_i_2_n_0;
  wire RGB_VSync0_carry_i_3_n_0;
  wire RGB_VSync0_carry_i_4_n_0;
  wire RGB_VSync0_carry_n_1;
  wire RGB_VSync0_carry_n_2;
  wire RGB_VSync0_carry_n_3;
  wire \RGB_VSync0_inferred__0/i__carry_n_0 ;
  wire \RGB_VSync0_inferred__0/i__carry_n_1 ;
  wire \RGB_VSync0_inferred__0/i__carry_n_2 ;
  wire \RGB_VSync0_inferred__0/i__carry_n_3 ;
  wire RGB_VSync_i_1_n_0;
  wire Rst;
  wire [11:0]Set_X;
  wire [11:0]Set_X0;
  wire Set_X0_carry__0_i_1_n_0;
  wire Set_X0_carry__0_i_2_n_0;
  wire Set_X0_carry__0_i_3_n_0;
  wire Set_X0_carry__0_n_2;
  wire Set_X0_carry__0_n_3;
  wire Set_X0_carry_i_1_n_0;
  wire Set_X0_carry_i_2_n_0;
  wire Set_X0_carry_i_3_n_0;
  wire Set_X0_carry_i_4_n_0;
  wire Set_X0_carry_i_5_n_0;
  wire Set_X0_carry_i_6_n_0;
  wire Set_X0_carry_i_7_n_0;
  wire Set_X0_carry_i_8_n_0;
  wire Set_X0_carry_n_0;
  wire Set_X0_carry_n_1;
  wire Set_X0_carry_n_2;
  wire Set_X0_carry_n_3;
  wire \Set_X0_inferred__0/i__carry__0_n_0 ;
  wire \Set_X0_inferred__0/i__carry__0_n_1 ;
  wire \Set_X0_inferred__0/i__carry__0_n_2 ;
  wire \Set_X0_inferred__0/i__carry__0_n_3 ;
  wire \Set_X0_inferred__0/i__carry__1_n_2 ;
  wire \Set_X0_inferred__0/i__carry__1_n_3 ;
  wire \Set_X0_inferred__0/i__carry_n_0 ;
  wire \Set_X0_inferred__0/i__carry_n_1 ;
  wire \Set_X0_inferred__0/i__carry_n_2 ;
  wire \Set_X0_inferred__0/i__carry_n_3 ;
  wire [11:0]Set_Y;
  wire [11:0]Set_Y0;
  wire Set_Y0_carry__0_n_2;
  wire Set_Y0_carry__0_n_3;
  wire Set_Y0_carry_i_1__0_n_0;
  wire Set_Y0_carry_i_1_n_0;
  wire Set_Y0_carry_i_2__0_n_0;
  wire Set_Y0_carry_i_2_n_0;
  wire Set_Y0_carry_i_3__0_n_0;
  wire Set_Y0_carry_i_3_n_0;
  wire Set_Y0_carry_i_4__0_n_0;
  wire Set_Y0_carry_i_4_n_0;
  wire Set_Y0_carry_i_5_n_0;
  wire Set_Y0_carry_i_6_n_0;
  wire Set_Y0_carry_i_7_n_0;
  wire Set_Y0_carry_n_0;
  wire Set_Y0_carry_n_1;
  wire Set_Y0_carry_n_2;
  wire Set_Y0_carry_n_3;
  wire \Set_Y[11]_i_2_n_0 ;
  wire \Set_Y[11]_i_3_n_0 ;
  wire \Set_Y[11]_i_4_n_0 ;
  wire \Set_Y[11]_i_5_n_0 ;
  wire \Set_Y[3]_i_2_n_0 ;
  wire \Set_Y[3]_i_3_n_0 ;
  wire \Set_Y[7]_i_2_n_0 ;
  wire \Set_Y[7]_i_3_n_0 ;
  wire \Set_Y[7]_i_4_n_0 ;
  wire \Set_Y[7]_i_5_n_0 ;
  wire \Set_Y_reg[11]_i_1_n_1 ;
  wire \Set_Y_reg[11]_i_1_n_2 ;
  wire \Set_Y_reg[11]_i_1_n_3 ;
  wire \Set_Y_reg[3]_i_1_n_0 ;
  wire \Set_Y_reg[3]_i_1_n_1 ;
  wire \Set_Y_reg[3]_i_1_n_2 ;
  wire \Set_Y_reg[3]_i_1_n_3 ;
  wire \Set_Y_reg[7]_i_1_n_0 ;
  wire \Set_Y_reg[7]_i_1_n_1 ;
  wire \Set_Y_reg[7]_i_1_n_2 ;
  wire \Set_Y_reg[7]_i_1_n_3 ;
  wire VSync_Cnt0;
  wire VSync_Cnt0_carry_i_1_n_0;
  wire VSync_Cnt0_carry_i_2_n_0;
  wire VSync_Cnt0_carry_i_3_n_0;
  wire VSync_Cnt0_carry_i_4_n_0;
  wire VSync_Cnt0_carry_n_1;
  wire VSync_Cnt0_carry_n_2;
  wire VSync_Cnt0_carry_n_3;
  wire VSync_Cnt10_out;
  wire \VSync_Cnt1_inferred__0/i__carry_n_1 ;
  wire \VSync_Cnt1_inferred__0/i__carry_n_2 ;
  wire \VSync_Cnt1_inferred__0/i__carry_n_3 ;
  wire \VSync_Cnt[0]_i_2_n_0 ;
  wire \VSync_Cnt[0]_i_3_n_0 ;
  wire \VSync_Cnt[0]_i_4_n_0 ;
  wire \VSync_Cnt[0]_i_5_n_0 ;
  wire \VSync_Cnt[0]_i_6_n_0 ;
  wire \VSync_Cnt[4]_i_2_n_0 ;
  wire \VSync_Cnt[4]_i_3_n_0 ;
  wire \VSync_Cnt[4]_i_4_n_0 ;
  wire \VSync_Cnt[4]_i_5_n_0 ;
  wire \VSync_Cnt[8]_i_2_n_0 ;
  wire \VSync_Cnt[8]_i_3_n_0 ;
  wire \VSync_Cnt[8]_i_4_n_0 ;
  wire \VSync_Cnt[8]_i_5_n_0 ;
  wire [11:0]VSync_Cnt_reg;
  wire \VSync_Cnt_reg[0]_i_1_n_0 ;
  wire \VSync_Cnt_reg[0]_i_1_n_1 ;
  wire \VSync_Cnt_reg[0]_i_1_n_2 ;
  wire \VSync_Cnt_reg[0]_i_1_n_3 ;
  wire \VSync_Cnt_reg[0]_i_1_n_4 ;
  wire \VSync_Cnt_reg[0]_i_1_n_5 ;
  wire \VSync_Cnt_reg[0]_i_1_n_6 ;
  wire \VSync_Cnt_reg[0]_i_1_n_7 ;
  wire \VSync_Cnt_reg[4]_i_1_n_0 ;
  wire \VSync_Cnt_reg[4]_i_1_n_1 ;
  wire \VSync_Cnt_reg[4]_i_1_n_2 ;
  wire \VSync_Cnt_reg[4]_i_1_n_3 ;
  wire \VSync_Cnt_reg[4]_i_1_n_4 ;
  wire \VSync_Cnt_reg[4]_i_1_n_5 ;
  wire \VSync_Cnt_reg[4]_i_1_n_6 ;
  wire \VSync_Cnt_reg[4]_i_1_n_7 ;
  wire \VSync_Cnt_reg[8]_i_1_n_1 ;
  wire \VSync_Cnt_reg[8]_i_1_n_2 ;
  wire \VSync_Cnt_reg[8]_i_1_n_3 ;
  wire \VSync_Cnt_reg[8]_i_1_n_4 ;
  wire \VSync_Cnt_reg[8]_i_1_n_5 ;
  wire \VSync_Cnt_reg[8]_i_1_n_6 ;
  wire \VSync_Cnt_reg[8]_i_1_n_7 ;
  wire V_De0;
  wire V_De0_carry_i_1_n_0;
  wire V_De0_carry_i_2_n_0;
  wire V_De0_carry_i_3_n_0;
  wire V_De0_carry_i_4_n_0;
  wire V_De0_carry_n_1;
  wire V_De0_carry_n_2;
  wire V_De0_carry_n_3;
  wire V_De_i_1_n_0;
  wire V_De_reg_n_0;
  wire Video_Mode;
  wire clk;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_1__1_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_2__1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_3__1_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_4__1_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire [3:0]NLW_HSync_Cnt1_carry_O_UNCONNECTED;
  wire [3:3]\NLW_HSync_Cnt_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_H_De0_carry_O_UNCONNECTED;
  wire [3:0]NLW_RGB_HSync0_carry_O_UNCONNECTED;
  wire [3:0]NLW_RGB_VSync0_carry_O_UNCONNECTED;
  wire [3:0]\NLW_RGB_VSync0_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:0]NLW_Set_X0_carry_O_UNCONNECTED;
  wire [3:2]NLW_Set_X0_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_Set_X0_carry__0_O_UNCONNECTED;
  wire [3:2]\NLW_Set_X0_inferred__0/i__carry__1_CO_UNCONNECTED ;
  wire [3:3]\NLW_Set_X0_inferred__0/i__carry__1_O_UNCONNECTED ;
  wire [3:0]NLW_Set_Y0_carry_O_UNCONNECTED;
  wire [3:2]NLW_Set_Y0_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_Set_Y0_carry__0_O_UNCONNECTED;
  wire [3:3]\NLW_Set_Y_reg[11]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_VSync_Cnt0_carry_O_UNCONNECTED;
  wire [3:0]\NLW_VSync_Cnt1_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:3]\NLW_VSync_Cnt_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_V_De0_carry_O_UNCONNECTED;

  CARRY4 HSync_Cnt1_carry
       (.CI(1'b0),
        .CO({HSync_Cnt1,HSync_Cnt1_carry_n_1,HSync_Cnt1_carry_n_2,HSync_Cnt1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_HSync_Cnt1_carry_O_UNCONNECTED[3:0]),
        .S({HSync_Cnt1_carry_i_1_n_0,HSync_Cnt1_carry_i_2_n_0,HSync_Cnt1_carry_i_3_n_0,HSync_Cnt1_carry_i_4_n_0}));
  LUT4 #(
    .INIT(16'h0810)) 
    HSync_Cnt1_carry_i_1
       (.I0(HSync_Cnt_reg[9]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[11]),
        .I3(HSync_Cnt_reg[10]),
        .O(HSync_Cnt1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h0120)) 
    HSync_Cnt1_carry_i_2
       (.I0(HSync_Cnt_reg[6]),
        .I1(HSync_Cnt_reg[8]),
        .I2(Video_Mode),
        .I3(HSync_Cnt_reg[7]),
        .O(HSync_Cnt1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0090)) 
    HSync_Cnt1_carry_i_3
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[5]),
        .I2(HSync_Cnt_reg[4]),
        .I3(HSync_Cnt_reg[3]),
        .O(HSync_Cnt1_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h2008)) 
    HSync_Cnt1_carry_i_4
       (.I0(HSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[2]),
        .I3(HSync_Cnt_reg[1]),
        .O(HSync_Cnt1_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[0]_i_2 
       (.I0(HSync_Cnt_reg[0]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[0]_i_3 
       (.I0(HSync_Cnt_reg[3]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[0]_i_4 
       (.I0(HSync_Cnt_reg[2]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[0]_i_5 
       (.I0(HSync_Cnt_reg[1]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \HSync_Cnt[0]_i_6 
       (.I0(HSync_Cnt_reg[0]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[4]_i_2 
       (.I0(HSync_Cnt_reg[7]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[4]_i_3 
       (.I0(HSync_Cnt_reg[6]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[4]_i_4 
       (.I0(HSync_Cnt_reg[5]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[4]_i_5 
       (.I0(HSync_Cnt_reg[4]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[8]_i_2 
       (.I0(HSync_Cnt_reg[11]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[8]_i_3 
       (.I0(HSync_Cnt_reg[10]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[8]_i_4 
       (.I0(HSync_Cnt_reg[9]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \HSync_Cnt[8]_i_5 
       (.I0(HSync_Cnt_reg[8]),
        .I1(HSync_Cnt1),
        .O(\HSync_Cnt[8]_i_5_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[0]_i_1_n_7 ),
        .Q(HSync_Cnt_reg[0]));
  CARRY4 \HSync_Cnt_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\HSync_Cnt_reg[0]_i_1_n_0 ,\HSync_Cnt_reg[0]_i_1_n_1 ,\HSync_Cnt_reg[0]_i_1_n_2 ,\HSync_Cnt_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\HSync_Cnt[0]_i_2_n_0 }),
        .O({\HSync_Cnt_reg[0]_i_1_n_4 ,\HSync_Cnt_reg[0]_i_1_n_5 ,\HSync_Cnt_reg[0]_i_1_n_6 ,\HSync_Cnt_reg[0]_i_1_n_7 }),
        .S({\HSync_Cnt[0]_i_3_n_0 ,\HSync_Cnt[0]_i_4_n_0 ,\HSync_Cnt[0]_i_5_n_0 ,\HSync_Cnt[0]_i_6_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[8]_i_1_n_5 ),
        .Q(HSync_Cnt_reg[10]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[8]_i_1_n_4 ),
        .Q(HSync_Cnt_reg[11]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[0]_i_1_n_6 ),
        .Q(HSync_Cnt_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[0]_i_1_n_5 ),
        .Q(HSync_Cnt_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[0]_i_1_n_4 ),
        .Q(HSync_Cnt_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[4]_i_1_n_7 ),
        .Q(HSync_Cnt_reg[4]));
  CARRY4 \HSync_Cnt_reg[4]_i_1 
       (.CI(\HSync_Cnt_reg[0]_i_1_n_0 ),
        .CO({\HSync_Cnt_reg[4]_i_1_n_0 ,\HSync_Cnt_reg[4]_i_1_n_1 ,\HSync_Cnt_reg[4]_i_1_n_2 ,\HSync_Cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\HSync_Cnt_reg[4]_i_1_n_4 ,\HSync_Cnt_reg[4]_i_1_n_5 ,\HSync_Cnt_reg[4]_i_1_n_6 ,\HSync_Cnt_reg[4]_i_1_n_7 }),
        .S({\HSync_Cnt[4]_i_2_n_0 ,\HSync_Cnt[4]_i_3_n_0 ,\HSync_Cnt[4]_i_4_n_0 ,\HSync_Cnt[4]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[4]_i_1_n_6 ),
        .Q(HSync_Cnt_reg[5]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[4]_i_1_n_5 ),
        .Q(HSync_Cnt_reg[6]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[4]_i_1_n_4 ),
        .Q(HSync_Cnt_reg[7]));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[8]_i_1_n_7 ),
        .Q(HSync_Cnt_reg[8]));
  CARRY4 \HSync_Cnt_reg[8]_i_1 
       (.CI(\HSync_Cnt_reg[4]_i_1_n_0 ),
        .CO({\NLW_HSync_Cnt_reg[8]_i_1_CO_UNCONNECTED [3],\HSync_Cnt_reg[8]_i_1_n_1 ,\HSync_Cnt_reg[8]_i_1_n_2 ,\HSync_Cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\HSync_Cnt_reg[8]_i_1_n_4 ,\HSync_Cnt_reg[8]_i_1_n_5 ,\HSync_Cnt_reg[8]_i_1_n_6 ,\HSync_Cnt_reg[8]_i_1_n_7 }),
        .S({\HSync_Cnt[8]_i_2_n_0 ,\HSync_Cnt[8]_i_3_n_0 ,\HSync_Cnt[8]_i_4_n_0 ,\HSync_Cnt[8]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \HSync_Cnt_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\HSync_Cnt_reg[8]_i_1_n_6 ),
        .Q(HSync_Cnt_reg[9]));
  CARRY4 H_De0_carry
       (.CI(1'b0),
        .CO({H_De0,H_De0_carry_n_1,H_De0_carry_n_2,H_De0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_H_De0_carry_O_UNCONNECTED[3:0]),
        .S({H_De0_carry_i_1_n_0,H_De0_carry_i_2_n_0,H_De0_carry_i_3_n_0,H_De0_carry_i_4_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    H_De0_carry_i_1
       (.I0(HSync_Cnt_reg[11]),
        .I1(HSync_Cnt_reg[10]),
        .I2(HSync_Cnt_reg[9]),
        .O(H_De0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h0900)) 
    H_De0_carry_i_2
       (.I0(HSync_Cnt_reg[6]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[7]),
        .I3(HSync_Cnt_reg[8]),
        .O(H_De0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0090)) 
    H_De0_carry_i_3
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[5]),
        .I2(HSync_Cnt_reg[4]),
        .I3(HSync_Cnt_reg[3]),
        .O(H_De0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h2008)) 
    H_De0_carry_i_4
       (.I0(HSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[2]),
        .I3(HSync_Cnt_reg[1]),
        .O(H_De0_carry_i_4_n_0));
  LUT3 #(
    .INIT(8'hBA)) 
    H_De_i_1
       (.I0(H_De0),
        .I1(HSync_Cnt1),
        .I2(H_De),
        .O(H_De_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    H_De_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(H_De_i_1_n_0),
        .Q(H_De));
  CARRY4 RGB_HSync0_carry
       (.CI(1'b0),
        .CO({RGB_HSync0,RGB_HSync0_carry_n_1,RGB_HSync0_carry_n_2,RGB_HSync0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_RGB_HSync0_carry_O_UNCONNECTED[3:0]),
        .S({RGB_HSync0_carry_i_1_n_0,RGB_HSync0_carry_i_2_n_0,RGB_HSync0_carry_i_3_n_0,RGB_HSync0_carry_i_4_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    RGB_HSync0_carry_i_1
       (.I0(HSync_Cnt_reg[11]),
        .I1(HSync_Cnt_reg[10]),
        .I2(HSync_Cnt_reg[9]),
        .O(RGB_HSync0_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h04)) 
    RGB_HSync0_carry_i_2
       (.I0(HSync_Cnt_reg[8]),
        .I1(HSync_Cnt_reg[7]),
        .I2(HSync_Cnt_reg[6]),
        .O(RGB_HSync0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0041)) 
    RGB_HSync0_carry_i_3
       (.I0(HSync_Cnt_reg[5]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[4]),
        .I3(HSync_Cnt_reg[3]),
        .O(RGB_HSync0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h0280)) 
    RGB_HSync0_carry_i_4
       (.I0(HSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[2]),
        .I3(HSync_Cnt_reg[1]),
        .O(RGB_HSync0_carry_i_4_n_0));
  LUT3 #(
    .INIT(8'hBA)) 
    RGB_HSync_i_1
       (.I0(VSync_Cnt0),
        .I1(RGB_HSync0),
        .I2(RGB_HSync),
        .O(RGB_HSync_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    RGB_HSync_i_2
       (.I0(Rst),
        .O(RGB_HSync_i_2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    RGB_HSync_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(RGB_HSync_i_1_n_0),
        .Q(RGB_HSync));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    RGB_VDE_i_1
       (.I0(H_De),
        .I1(V_De_reg_n_0),
        .O(RGB_VDE0));
  FDCE #(
    .INIT(1'b0)) 
    RGB_VDE_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(RGB_VDE0),
        .Q(RGB_VDE));
  CARRY4 RGB_VSync0_carry
       (.CI(1'b0),
        .CO({RGB_VSync0,RGB_VSync0_carry_n_1,RGB_VSync0_carry_n_2,RGB_VSync0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_RGB_VSync0_carry_O_UNCONNECTED[3:0]),
        .S({RGB_VSync0_carry_i_1_n_0,RGB_VSync0_carry_i_2_n_0,RGB_VSync0_carry_i_3_n_0,RGB_VSync0_carry_i_4_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    RGB_VSync0_carry_i_1
       (.I0(VSync_Cnt_reg[11]),
        .I1(VSync_Cnt_reg[10]),
        .I2(VSync_Cnt_reg[9]),
        .O(RGB_VSync0_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    RGB_VSync0_carry_i_2
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt_reg[7]),
        .I2(VSync_Cnt_reg[6]),
        .O(RGB_VSync0_carry_i_2_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    RGB_VSync0_carry_i_3
       (.I0(VSync_Cnt_reg[5]),
        .I1(VSync_Cnt_reg[4]),
        .I2(VSync_Cnt_reg[3]),
        .O(RGB_VSync0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h0240)) 
    RGB_VSync0_carry_i_4
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[2]),
        .I3(VSync_Cnt_reg[1]),
        .O(RGB_VSync0_carry_i_4_n_0));
  CARRY4 \RGB_VSync0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\RGB_VSync0_inferred__0/i__carry_n_0 ,\RGB_VSync0_inferred__0/i__carry_n_1 ,\RGB_VSync0_inferred__0/i__carry_n_2 ,\RGB_VSync0_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_RGB_VSync0_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S({i__carry_i_1__1_n_0,i__carry_i_2__1_n_0,i__carry_i_3__0_n_0,i__carry_i_4_n_0}));
  LUT4 #(
    .INIT(16'hF7A0)) 
    RGB_VSync_i_1
       (.I0(VSync_Cnt0),
        .I1(\RGB_VSync0_inferred__0/i__carry_n_0 ),
        .I2(RGB_VSync0),
        .I3(RGB_VSync),
        .O(RGB_VSync_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    RGB_VSync_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(RGB_VSync_i_1_n_0),
        .Q(RGB_VSync));
  CARRY4 Set_X0_carry
       (.CI(1'b0),
        .CO({Set_X0_carry_n_0,Set_X0_carry_n_1,Set_X0_carry_n_2,Set_X0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({Set_X0_carry_i_1_n_0,Set_X0_carry_i_2_n_0,Set_X0_carry_i_3_n_0,Set_X0_carry_i_4_n_0}),
        .O(NLW_Set_X0_carry_O_UNCONNECTED[3:0]),
        .S({Set_X0_carry_i_5_n_0,Set_X0_carry_i_6_n_0,Set_X0_carry_i_7_n_0,Set_X0_carry_i_8_n_0}));
  CARRY4 Set_X0_carry__0
       (.CI(Set_X0_carry_n_0),
        .CO({NLW_Set_X0_carry__0_CO_UNCONNECTED[3:2],Set_X0_carry__0_n_2,Set_X0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Set_X0_carry__0_i_1_n_0,HSync_Cnt_reg[9]}),
        .O(NLW_Set_X0_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,Set_X0_carry__0_i_2_n_0,Set_X0_carry__0_i_3_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    Set_X0_carry__0_i_1
       (.I0(HSync_Cnt_reg[10]),
        .I1(HSync_Cnt_reg[11]),
        .O(Set_X0_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    Set_X0_carry__0_i_2
       (.I0(HSync_Cnt_reg[10]),
        .I1(HSync_Cnt_reg[11]),
        .O(Set_X0_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    Set_X0_carry__0_i_3
       (.I0(HSync_Cnt_reg[8]),
        .I1(HSync_Cnt_reg[9]),
        .O(Set_X0_carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'hF2)) 
    Set_X0_carry_i_1
       (.I0(HSync_Cnt_reg[6]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[7]),
        .O(Set_X0_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    Set_X0_carry_i_2
       (.I0(HSync_Cnt_reg[5]),
        .I1(Video_Mode),
        .O(Set_X0_carry_i_2_n_0));
  LUT3 #(
    .INIT(8'hF8)) 
    Set_X0_carry_i_3
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[2]),
        .I2(HSync_Cnt_reg[3]),
        .O(Set_X0_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    Set_X0_carry_i_4
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[1]),
        .O(Set_X0_carry_i_4_n_0));
  LUT3 #(
    .INIT(8'h09)) 
    Set_X0_carry_i_5
       (.I0(HSync_Cnt_reg[6]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[7]),
        .O(Set_X0_carry_i_5_n_0));
  LUT3 #(
    .INIT(8'h82)) 
    Set_X0_carry_i_6
       (.I0(HSync_Cnt_reg[4]),
        .I1(HSync_Cnt_reg[5]),
        .I2(Video_Mode),
        .O(Set_X0_carry_i_6_n_0));
  LUT3 #(
    .INIT(8'h06)) 
    Set_X0_carry_i_7
       (.I0(HSync_Cnt_reg[2]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[3]),
        .O(Set_X0_carry_i_7_n_0));
  LUT3 #(
    .INIT(8'h28)) 
    Set_X0_carry_i_8
       (.I0(HSync_Cnt_reg[0]),
        .I1(HSync_Cnt_reg[1]),
        .I2(Video_Mode),
        .O(Set_X0_carry_i_8_n_0));
  CARRY4 \Set_X0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\Set_X0_inferred__0/i__carry_n_0 ,\Set_X0_inferred__0/i__carry_n_1 ,\Set_X0_inferred__0/i__carry_n_2 ,\Set_X0_inferred__0/i__carry_n_3 }),
        .CYINIT(HSync_Cnt_reg[0]),
        .DI({i__carry_i_1__0_n_0,i__carry_i_2__0_n_0,i__carry_i_3__1_n_0,Video_Mode}),
        .O(Set_X0[4:1]),
        .S({i__carry_i_4__1_n_0,i__carry_i_5_n_0,i__carry_i_6_n_0,i__carry_i_7_n_0}));
  CARRY4 \Set_X0_inferred__0/i__carry__0 
       (.CI(\Set_X0_inferred__0/i__carry_n_0 ),
        .CO({\Set_X0_inferred__0/i__carry__0_n_0 ,\Set_X0_inferred__0/i__carry__0_n_1 ,\Set_X0_inferred__0/i__carry__0_n_2 ,\Set_X0_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,HSync_Cnt_reg[7],i__carry__0_i_1_n_0,i__carry__0_i_2_n_0}),
        .O(Set_X0[8:5]),
        .S({HSync_Cnt_reg[8],i__carry__0_i_3_n_0,i__carry__0_i_4_n_0,i__carry__0_i_5_n_0}));
  CARRY4 \Set_X0_inferred__0/i__carry__1 
       (.CI(\Set_X0_inferred__0/i__carry__0_n_0 ),
        .CO({\NLW_Set_X0_inferred__0/i__carry__1_CO_UNCONNECTED [3:2],\Set_X0_inferred__0/i__carry__1_n_2 ,\Set_X0_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,HSync_Cnt_reg[10:9]}),
        .O({\NLW_Set_X0_inferred__0/i__carry__1_O_UNCONNECTED [3],Set_X0[11:9]}),
        .S({1'b0,i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_X[0]_i_1 
       (.I0(HSync_Cnt_reg[0]),
        .O(Set_X0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[0] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[0]),
        .Q(Set_X[0]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[10] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[10]),
        .Q(Set_X[10]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[11] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[11]),
        .Q(Set_X[11]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[1] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[1]),
        .Q(Set_X[1]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[2] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[2]),
        .Q(Set_X[2]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[3] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[3]),
        .Q(Set_X[3]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[4] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[4]),
        .Q(Set_X[4]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[5] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[5]),
        .Q(Set_X[5]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[6] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[6]),
        .Q(Set_X[6]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[7] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[7]),
        .Q(Set_X[7]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[8] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[8]),
        .Q(Set_X[8]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_X_reg[9] 
       (.C(clk),
        .CE(Set_X0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_X0[9]),
        .Q(Set_X[9]));
  CARRY4 Set_Y0_carry
       (.CI(1'b0),
        .CO({Set_Y0_carry_n_0,Set_Y0_carry_n_1,Set_Y0_carry_n_2,Set_Y0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({Set_Y0_carry_i_1_n_0,Set_Y0_carry_i_2_n_0,1'b0,Set_Y0_carry_i_3_n_0}),
        .O(NLW_Set_Y0_carry_O_UNCONNECTED[3:0]),
        .S({Set_Y0_carry_i_4__0_n_0,Set_Y0_carry_i_5_n_0,Set_Y0_carry_i_6_n_0,Set_Y0_carry_i_7_n_0}));
  CARRY4 Set_Y0_carry__0
       (.CI(Set_Y0_carry_n_0),
        .CO({NLW_Set_Y0_carry__0_CO_UNCONNECTED[3:2],Set_Y0_carry__0_n_2,Set_Y0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Set_Y0_carry_i_1__0_n_0,Set_Y0_carry_i_2__0_n_0}),
        .O(NLW_Set_Y0_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,Set_Y0_carry_i_3__0_n_0,Set_Y0_carry_i_4_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    Set_Y0_carry_i_1
       (.I0(VSync_Cnt_reg[6]),
        .I1(VSync_Cnt_reg[7]),
        .O(Set_Y0_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    Set_Y0_carry_i_1__0
       (.I0(VSync_Cnt_reg[10]),
        .I1(VSync_Cnt_reg[11]),
        .O(Set_Y0_carry_i_1__0_n_0));
  LUT3 #(
    .INIT(8'hC8)) 
    Set_Y0_carry_i_2
       (.I0(VSync_Cnt_reg[4]),
        .I1(VSync_Cnt_reg[5]),
        .I2(Video_Mode),
        .O(Set_Y0_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    Set_Y0_carry_i_2__0
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt_reg[9]),
        .O(Set_Y0_carry_i_2__0_n_0));
  LUT3 #(
    .INIT(8'hF2)) 
    Set_Y0_carry_i_3
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[1]),
        .O(Set_Y0_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    Set_Y0_carry_i_3__0
       (.I0(VSync_Cnt_reg[10]),
        .I1(VSync_Cnt_reg[11]),
        .O(Set_Y0_carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    Set_Y0_carry_i_4
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt_reg[9]),
        .O(Set_Y0_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    Set_Y0_carry_i_4__0
       (.I0(VSync_Cnt_reg[6]),
        .I1(VSync_Cnt_reg[7]),
        .O(Set_Y0_carry_i_4__0_n_0));
  LUT3 #(
    .INIT(8'h24)) 
    Set_Y0_carry_i_5
       (.I0(VSync_Cnt_reg[4]),
        .I1(VSync_Cnt_reg[5]),
        .I2(Video_Mode),
        .O(Set_Y0_carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    Set_Y0_carry_i_6
       (.I0(VSync_Cnt_reg[2]),
        .I1(VSync_Cnt_reg[3]),
        .O(Set_Y0_carry_i_6_n_0));
  LUT3 #(
    .INIT(8'h09)) 
    Set_Y0_carry_i_7
       (.I0(Video_Mode),
        .I1(VSync_Cnt_reg[0]),
        .I2(VSync_Cnt_reg[1]),
        .O(Set_Y0_carry_i_7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[11]_i_2 
       (.I0(VSync_Cnt_reg[11]),
        .O(\Set_Y[11]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[11]_i_3 
       (.I0(VSync_Cnt_reg[10]),
        .O(\Set_Y[11]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[11]_i_4 
       (.I0(VSync_Cnt_reg[9]),
        .O(\Set_Y[11]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[11]_i_5 
       (.I0(VSync_Cnt_reg[8]),
        .O(\Set_Y[11]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[3]_i_2 
       (.I0(VSync_Cnt_reg[1]),
        .O(\Set_Y[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \Set_Y[3]_i_3 
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .O(\Set_Y[3]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[7]_i_2 
       (.I0(VSync_Cnt_reg[7]),
        .O(\Set_Y[7]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \Set_Y[7]_i_3 
       (.I0(VSync_Cnt_reg[6]),
        .O(\Set_Y[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \Set_Y[7]_i_4 
       (.I0(VSync_Cnt_reg[5]),
        .I1(Video_Mode),
        .O(\Set_Y[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \Set_Y[7]_i_5 
       (.I0(VSync_Cnt_reg[4]),
        .I1(Video_Mode),
        .O(\Set_Y[7]_i_5_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[0] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[0]),
        .Q(Set_Y[0]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[10] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[10]),
        .Q(Set_Y[10]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[11] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[11]),
        .Q(Set_Y[11]));
  CARRY4 \Set_Y_reg[11]_i_1 
       (.CI(\Set_Y_reg[7]_i_1_n_0 ),
        .CO({\NLW_Set_Y_reg[11]_i_1_CO_UNCONNECTED [3],\Set_Y_reg[11]_i_1_n_1 ,\Set_Y_reg[11]_i_1_n_2 ,\Set_Y_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,VSync_Cnt_reg[10:8]}),
        .O(Set_Y0[11:8]),
        .S({\Set_Y[11]_i_2_n_0 ,\Set_Y[11]_i_3_n_0 ,\Set_Y[11]_i_4_n_0 ,\Set_Y[11]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[1] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[1]),
        .Q(Set_Y[1]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[2] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[2]),
        .Q(Set_Y[2]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[3] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[3]),
        .Q(Set_Y[3]));
  CARRY4 \Set_Y_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\Set_Y_reg[3]_i_1_n_0 ,\Set_Y_reg[3]_i_1_n_1 ,\Set_Y_reg[3]_i_1_n_2 ,\Set_Y_reg[3]_i_1_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,VSync_Cnt_reg[1:0]}),
        .O(Set_Y0[3:0]),
        .S({VSync_Cnt_reg[3:2],\Set_Y[3]_i_2_n_0 ,\Set_Y[3]_i_3_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[4] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[4]),
        .Q(Set_Y[4]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[5] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[5]),
        .Q(Set_Y[5]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[6] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[6]),
        .Q(Set_Y[6]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[7] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[7]),
        .Q(Set_Y[7]));
  CARRY4 \Set_Y_reg[7]_i_1 
       (.CI(\Set_Y_reg[3]_i_1_n_0 ),
        .CO({\Set_Y_reg[7]_i_1_n_0 ,\Set_Y_reg[7]_i_1_n_1 ,\Set_Y_reg[7]_i_1_n_2 ,\Set_Y_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(VSync_Cnt_reg[7:4]),
        .O(Set_Y0[7:4]),
        .S({\Set_Y[7]_i_2_n_0 ,\Set_Y[7]_i_3_n_0 ,\Set_Y[7]_i_4_n_0 ,\Set_Y[7]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[8] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[8]),
        .Q(Set_Y[8]));
  FDCE #(
    .INIT(1'b0)) 
    \Set_Y_reg[9] 
       (.C(clk),
        .CE(Set_Y0_carry__0_n_2),
        .CLR(RGB_HSync_i_2_n_0),
        .D(Set_Y0[9]),
        .Q(Set_Y[9]));
  CARRY4 VSync_Cnt0_carry
       (.CI(1'b0),
        .CO({VSync_Cnt0,VSync_Cnt0_carry_n_1,VSync_Cnt0_carry_n_2,VSync_Cnt0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_VSync_Cnt0_carry_O_UNCONNECTED[3:0]),
        .S({VSync_Cnt0_carry_i_1_n_0,VSync_Cnt0_carry_i_2_n_0,VSync_Cnt0_carry_i_3_n_0,VSync_Cnt0_carry_i_4_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    VSync_Cnt0_carry_i_1
       (.I0(HSync_Cnt_reg[11]),
        .I1(HSync_Cnt_reg[10]),
        .I2(HSync_Cnt_reg[9]),
        .O(VSync_Cnt0_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    VSync_Cnt0_carry_i_2
       (.I0(HSync_Cnt_reg[6]),
        .I1(HSync_Cnt_reg[8]),
        .I2(HSync_Cnt_reg[7]),
        .O(VSync_Cnt0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0180)) 
    VSync_Cnt0_carry_i_3
       (.I0(HSync_Cnt_reg[3]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[5]),
        .I3(HSync_Cnt_reg[4]),
        .O(VSync_Cnt0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h0880)) 
    VSync_Cnt0_carry_i_4
       (.I0(HSync_Cnt_reg[0]),
        .I1(HSync_Cnt_reg[2]),
        .I2(Video_Mode),
        .I3(HSync_Cnt_reg[1]),
        .O(VSync_Cnt0_carry_i_4_n_0));
  CARRY4 \VSync_Cnt1_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({VSync_Cnt10_out,\VSync_Cnt1_inferred__0/i__carry_n_1 ,\VSync_Cnt1_inferred__0/i__carry_n_2 ,\VSync_Cnt1_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_VSync_Cnt1_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4__0_n_0}));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[0]_i_2 
       (.I0(VSync_Cnt_reg[0]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[0]_i_3 
       (.I0(VSync_Cnt_reg[3]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[0]_i_4 
       (.I0(VSync_Cnt_reg[2]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[0]_i_5 
       (.I0(VSync_Cnt_reg[1]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \VSync_Cnt[0]_i_6 
       (.I0(VSync_Cnt_reg[0]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[4]_i_2 
       (.I0(VSync_Cnt_reg[7]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[4]_i_3 
       (.I0(VSync_Cnt_reg[6]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[4]_i_4 
       (.I0(VSync_Cnt_reg[5]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[4]_i_5 
       (.I0(VSync_Cnt_reg[4]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[8]_i_2 
       (.I0(VSync_Cnt_reg[11]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[8]_i_3 
       (.I0(VSync_Cnt_reg[10]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[8]_i_4 
       (.I0(VSync_Cnt_reg[9]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \VSync_Cnt[8]_i_5 
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt10_out),
        .O(\VSync_Cnt[8]_i_5_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[0] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[0]_i_1_n_7 ),
        .Q(VSync_Cnt_reg[0]));
  CARRY4 \VSync_Cnt_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\VSync_Cnt_reg[0]_i_1_n_0 ,\VSync_Cnt_reg[0]_i_1_n_1 ,\VSync_Cnt_reg[0]_i_1_n_2 ,\VSync_Cnt_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\VSync_Cnt[0]_i_2_n_0 }),
        .O({\VSync_Cnt_reg[0]_i_1_n_4 ,\VSync_Cnt_reg[0]_i_1_n_5 ,\VSync_Cnt_reg[0]_i_1_n_6 ,\VSync_Cnt_reg[0]_i_1_n_7 }),
        .S({\VSync_Cnt[0]_i_3_n_0 ,\VSync_Cnt[0]_i_4_n_0 ,\VSync_Cnt[0]_i_5_n_0 ,\VSync_Cnt[0]_i_6_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[10] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[8]_i_1_n_5 ),
        .Q(VSync_Cnt_reg[10]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[11] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[8]_i_1_n_4 ),
        .Q(VSync_Cnt_reg[11]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[1] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[0]_i_1_n_6 ),
        .Q(VSync_Cnt_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[2] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[0]_i_1_n_5 ),
        .Q(VSync_Cnt_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[3] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[0]_i_1_n_4 ),
        .Q(VSync_Cnt_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[4] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[4]_i_1_n_7 ),
        .Q(VSync_Cnt_reg[4]));
  CARRY4 \VSync_Cnt_reg[4]_i_1 
       (.CI(\VSync_Cnt_reg[0]_i_1_n_0 ),
        .CO({\VSync_Cnt_reg[4]_i_1_n_0 ,\VSync_Cnt_reg[4]_i_1_n_1 ,\VSync_Cnt_reg[4]_i_1_n_2 ,\VSync_Cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\VSync_Cnt_reg[4]_i_1_n_4 ,\VSync_Cnt_reg[4]_i_1_n_5 ,\VSync_Cnt_reg[4]_i_1_n_6 ,\VSync_Cnt_reg[4]_i_1_n_7 }),
        .S({\VSync_Cnt[4]_i_2_n_0 ,\VSync_Cnt[4]_i_3_n_0 ,\VSync_Cnt[4]_i_4_n_0 ,\VSync_Cnt[4]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[5] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[4]_i_1_n_6 ),
        .Q(VSync_Cnt_reg[5]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[6] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[4]_i_1_n_5 ),
        .Q(VSync_Cnt_reg[6]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[7] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[4]_i_1_n_4 ),
        .Q(VSync_Cnt_reg[7]));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[8] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[8]_i_1_n_7 ),
        .Q(VSync_Cnt_reg[8]));
  CARRY4 \VSync_Cnt_reg[8]_i_1 
       (.CI(\VSync_Cnt_reg[4]_i_1_n_0 ),
        .CO({\NLW_VSync_Cnt_reg[8]_i_1_CO_UNCONNECTED [3],\VSync_Cnt_reg[8]_i_1_n_1 ,\VSync_Cnt_reg[8]_i_1_n_2 ,\VSync_Cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\VSync_Cnt_reg[8]_i_1_n_4 ,\VSync_Cnt_reg[8]_i_1_n_5 ,\VSync_Cnt_reg[8]_i_1_n_6 ,\VSync_Cnt_reg[8]_i_1_n_7 }),
        .S({\VSync_Cnt[8]_i_2_n_0 ,\VSync_Cnt[8]_i_3_n_0 ,\VSync_Cnt[8]_i_4_n_0 ,\VSync_Cnt[8]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \VSync_Cnt_reg[9] 
       (.C(clk),
        .CE(VSync_Cnt0),
        .CLR(RGB_HSync_i_2_n_0),
        .D(\VSync_Cnt_reg[8]_i_1_n_6 ),
        .Q(VSync_Cnt_reg[9]));
  CARRY4 V_De0_carry
       (.CI(1'b0),
        .CO({V_De0,V_De0_carry_n_1,V_De0_carry_n_2,V_De0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_V_De0_carry_O_UNCONNECTED[3:0]),
        .S({V_De0_carry_i_1_n_0,V_De0_carry_i_2_n_0,V_De0_carry_i_3_n_0,V_De0_carry_i_4_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    V_De0_carry_i_1
       (.I0(VSync_Cnt_reg[11]),
        .I1(VSync_Cnt_reg[10]),
        .I2(VSync_Cnt_reg[9]),
        .O(V_De0_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    V_De0_carry_i_2
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt_reg[7]),
        .I2(VSync_Cnt_reg[6]),
        .O(V_De0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0820)) 
    V_De0_carry_i_3
       (.I0(VSync_Cnt_reg[3]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[5]),
        .I3(VSync_Cnt_reg[4]),
        .O(V_De0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h0900)) 
    V_De0_carry_i_4
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[1]),
        .I3(VSync_Cnt_reg[2]),
        .O(V_De0_carry_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF7A0)) 
    V_De_i_1
       (.I0(VSync_Cnt0),
        .I1(VSync_Cnt10_out),
        .I2(V_De0),
        .I3(V_De_reg_n_0),
        .O(V_De_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    V_De_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(RGB_HSync_i_2_n_0),
        .D(V_De_i_1_n_0),
        .Q(V_De_reg_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_1
       (.I0(HSync_Cnt_reg[5]),
        .I1(Video_Mode),
        .O(i__carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry__0_i_2
       (.I0(HSync_Cnt_reg[4]),
        .I1(Video_Mode),
        .O(i__carry__0_i_2_n_0));
  LUT3 #(
    .INIT(8'h2D)) 
    i__carry__0_i_3
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[6]),
        .I2(HSync_Cnt_reg[7]),
        .O(i__carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'h87)) 
    i__carry__0_i_4
       (.I0(HSync_Cnt_reg[5]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[6]),
        .O(i__carry__0_i_4_n_0));
  LUT3 #(
    .INIT(8'hD2)) 
    i__carry__0_i_5
       (.I0(HSync_Cnt_reg[4]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[5]),
        .O(i__carry__0_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_1
       (.I0(HSync_Cnt_reg[11]),
        .O(i__carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_2
       (.I0(HSync_Cnt_reg[10]),
        .O(i__carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_3
       (.I0(HSync_Cnt_reg[9]),
        .O(i__carry__1_i_3_n_0));
  LUT4 #(
    .INIT(16'h0120)) 
    i__carry_i_1
       (.I0(VSync_Cnt_reg[9]),
        .I1(VSync_Cnt_reg[11]),
        .I2(Video_Mode),
        .I3(VSync_Cnt_reg[10]),
        .O(i__carry_i_1_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry_i_1__0
       (.I0(HSync_Cnt_reg[3]),
        .I1(Video_Mode),
        .O(i__carry_i_1__0_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry_i_1__1
       (.I0(VSync_Cnt_reg[11]),
        .I1(VSync_Cnt_reg[10]),
        .I2(VSync_Cnt_reg[9]),
        .O(i__carry_i_1__1_n_0));
  LUT4 #(
    .INIT(16'h2002)) 
    i__carry_i_2
       (.I0(VSync_Cnt_reg[6]),
        .I1(VSync_Cnt_reg[8]),
        .I2(Video_Mode),
        .I3(VSync_Cnt_reg[7]),
        .O(i__carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    i__carry_i_2__0
       (.I0(HSync_Cnt_reg[2]),
        .O(i__carry_i_2__0_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry_i_2__1
       (.I0(VSync_Cnt_reg[8]),
        .I1(VSync_Cnt_reg[7]),
        .I2(VSync_Cnt_reg[6]),
        .O(i__carry_i_2__1_n_0));
  LUT4 #(
    .INIT(16'h0900)) 
    i__carry_i_3
       (.I0(VSync_Cnt_reg[3]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[4]),
        .I3(VSync_Cnt_reg[5]),
        .O(i__carry_i_3_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    i__carry_i_3__0
       (.I0(VSync_Cnt_reg[3]),
        .I1(VSync_Cnt_reg[5]),
        .I2(VSync_Cnt_reg[4]),
        .O(i__carry_i_3__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_3__1
       (.I0(HSync_Cnt_reg[2]),
        .O(i__carry_i_3__1_n_0));
  LUT4 #(
    .INIT(16'h0009)) 
    i__carry_i_4
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[2]),
        .I3(VSync_Cnt_reg[1]),
        .O(i__carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h0900)) 
    i__carry_i_4__0
       (.I0(VSync_Cnt_reg[0]),
        .I1(Video_Mode),
        .I2(VSync_Cnt_reg[1]),
        .I3(VSync_Cnt_reg[2]),
        .O(i__carry_i_4__0_n_0));
  LUT3 #(
    .INIT(8'h78)) 
    i__carry_i_4__1
       (.I0(HSync_Cnt_reg[3]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[4]),
        .O(i__carry_i_4__1_n_0));
  LUT3 #(
    .INIT(8'h96)) 
    i__carry_i_5
       (.I0(HSync_Cnt_reg[2]),
        .I1(Video_Mode),
        .I2(HSync_Cnt_reg[3]),
        .O(i__carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_6
       (.I0(HSync_Cnt_reg[2]),
        .I1(Video_Mode),
        .O(i__carry_i_6_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_7
       (.I0(Video_Mode),
        .I1(HSync_Cnt_reg[1]),
        .O(i__carry_i_7_n_0));
endmodule

(* CHECK_LICENSE_TYPE = "Driver_HDMI_0,Driver_HDMI,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "Driver_HDMI,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    Rst,
    Video_Mode,
    RGB_In,
    RGB_Data,
    RGB_HSync,
    RGB_VSync,
    RGB_VDE,
    Set_X,
    Set_Y);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET Rst, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 Rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME Rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input Rst;
  input Video_Mode;
  input [23:0]RGB_In;
  output [23:0]RGB_Data;
  output RGB_HSync;
  output RGB_VSync;
  output RGB_VDE;
  output [11:0]Set_X;
  output [11:0]Set_Y;

  wire RGB_HSync;
  wire [23:0]RGB_In;
  wire RGB_VDE;
  wire RGB_VSync;
  wire Rst;
  wire [11:0]Set_X;
  wire [11:0]Set_Y;
  wire Video_Mode;
  wire clk;

  assign RGB_Data[23:0] = RGB_In;
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Driver_HDMI inst
       (.RGB_HSync(RGB_HSync),
        .RGB_VDE(RGB_VDE),
        .RGB_VSync(RGB_VSync),
        .Rst(Rst),
        .Set_X(Set_X),
        .Set_Y(Set_Y),
        .Video_Mode(Video_Mode),
        .clk(clk));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
