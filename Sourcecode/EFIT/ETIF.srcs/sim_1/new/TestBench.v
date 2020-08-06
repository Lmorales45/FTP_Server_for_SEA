`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/05 14:25:34
// Design Name: 
// Module Name: TestBench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestBench();
reg rst_n;
reg qspi_d0;//发送的数据
reg qspi_d1;
reg qspi_d2;
reg qspi_d3;
reg I_qspi_cs;
reg I_qspi_clk;//qspi通信时钟
reg clk_system;

wire data_out;
wire RAM_en;
wire addr;
wire o_data;
wire doutb;
wire addrb;

qspi_slave slave_test(
    .I_qspi_clk  (I_qspi_clk)  , 
    .I_qspi_cs   (I_qspi_cs)  , 
    .IO_qspi_io0 (qspi_d0)  ,
    .IO_qspi_io1 (qspi_d1)  ,
    .IO_qspi_io2 (qspi_d2)  , 
    .IO_qspi_io3 (qspi_d3)  , 
    .o_addr      (addr)    ,
    .o_data      (o_data)  ,//RAM数据写入端
//    .o_valid     (o_valid), //RAM写使能端
    .RAM_en(RAM_en)
);

  blk_mem_gen_0 u_blk_mem_gen_0 (
      .clka(I_qspi_clk),    // input wire clka
      .wea(1),      // input wire [0 : 0] wea RAM写使能端
      .addra(addr),  // input wire [14 : 0] addra
      .dina(o_data),    // input wire [7 : 0] dina
      .clkb(clk_system),    // input wire clkb B端口数据读取要和HDMI Driver保持同步
      .addrb(addrb),  // input wire [14 : 0] addrb
      .doutb(doutb)  // output wire [7 : 0] doutb 输出给数据处理模块的数据
);

    //数据处理模块，提取图片像素信息并返回给HDMI Driver
    get_data_from_esp32 get_data_from_esp32_0(
         .clk(clk_system),
         .rst_n(rst_n),
         .addr(addrb),  //output addr
         .data_in(doutb),//读取RAM数据(doutb)
         .data_out(data_out),//发送图片数据给HDMI Driver
         .Set_X(1000),
         .Set_Y(500),
         .RAM_en(RAM_en)
    );

initial
begin
rst_n=0;
clk_system=0;
qspi_d0=0;//发送的数据
qspi_d1=0;
qspi_d2=0;
qspi_d3=0;
I_qspi_cs=1;
I_qspi_clk=0;
#10;
rst_n=1;
I_qspi_cs=0;
#50;
qspi_d0=0;
#10;
qspi_d0=0;
#10;
qspi_d0=1;
#10;
qspi_d0=1;
#10;
qspi_d0=0;
#10;
qspi_d0=0;
#10;
qspi_d0=1;
#10;
qspi_d0=0;
#10;//esp32发送初始地址32'b0
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=0;

#10;//宽度0
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0110;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0100;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;//长度1
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;//长度1
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;//长度1
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;//长度1
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0110;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0100;
#10;//数据2其实是八个像素点
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0010;
//#10;//数据3其实是八个像素点
//{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0000;
//#10;
//{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b0011;
//0xff表示传输结束
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b1111;
#10;
{qspi_d3,qspi_d2,qspi_d1,qspi_d0}=4'b1111;


$stop;
end
always #5 I_qspi_clk=~I_qspi_clk;
always #10 clk_system=~clk_system;
endmodule
