`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/02 12:58:55
// Design Name: 
// Module Name: get_data_from_esp32
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


module get_data_from_esp32
#(
parameter addr_width = 15//地址15bit
)(
input clk,//100MHZ
input rst_n,
//RAM 
output reg [addr_width-1:0] addr,//要读取的数据在RAM中的地址
input [7:0]data_in,//RAM返回请求的数据
//input enb,
output reg [7:0] data_out
);
//registers & wire
reg [16:0] count; 
wire [14:0] rcount;//0x00 ~ 0x0f : get the data ; 0x10 ~ 0x1f : output the data to RAM
assign rcount = count[16:2];//在地址改变的两个时钟周期后，RAM的数据输出才会进行改变
//count: counter of clk
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        count <= 0;
    else
        if (rcount < 32768)//图片设置为每行128像素，总共256行。因为图片像素颜色只有黑色和白色，所以图片像素颜色数据大小也是256*128bit
            count <= count + 1;
        else
            count <= 0;
end
//addr: address to RAM, address change while count[1:0] == 2'b00, data store while count[1:0] == 2'b11
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        addr <= 0;
    else
        if (rcount < 32768)
            addr <= rcount;//遍历RAM中所有地址0~32767
        else
            addr <= 0;
end
reg [7:0] mem_Img_data [0:15];//mem_Img_data为16个8位寄存器的数组，用于存储图片像素RGB_data
reg [7:0] mem_Img_format [0:7];//mem_Img_format为8个8位寄存器的数组，用于存储图片格式(mem_Img_format[0][3:0]寄存器存储图片宽度，mem_Img_format[1][3:0]寄存器存储图片长度。
reg [3:0] sub=0,sub1=0;//sub是mem_Img_data下角标0~15,表示对应的寄存器;sub1是读取宽度和长度时使用的下标

integer i=0;

//read data from RAM
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)//复位按键只是消除FPGA内部寄存器中存储的数据
    begin
        sub <= 0;
        sub1 <= 0;
        for (i=0;i<15;i=i+1)
            mem_Img_data[i] <= 0;
    end
    else
    begin
        if ((rcount < 32768)&&(count[1:0] == 2'b11))//这里32768最好是先计算出来RAM里总共存了多少，而不是直接用最大深度
        begin
            if (rcount < 8)//先读取宽度、长度数据
            begin
                if(sub1<8)
                begin
                    mem_Img_format[sub1] <= data_in;
                    sub1 <= sub1 +1;
                end
                else
                    sub1 <= 0;
            end
            else//rcount>=8<=>RAM中地址>=8这些地址中全都存储的是像素数据
            begin
                if(sub < 16)
                begin
                    mem_Img_data[sub] <= data_in;
                    sub <= sub +1;
                end
                else
                    sub <= 0;
            end
        end
    end
end

//data_out: output the data in mem
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        data_out <= 0;
    else
        if (rcount < 32)
            data_out <= mem_Img_data[sub];
        else
            data_out <= 0;
end

endmodule
