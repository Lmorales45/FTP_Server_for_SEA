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
output reg [7:0] data_out,
output reg wen
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
reg [3:0] mem_Img_format [0:1];//mem_Img_format为2个4位寄存器的数组，用于存储图片格式(mem_Img_format[0][3:0]寄存器存储图片宽度，mem_Img_format[1][3:0]寄存器存储图片长度。
//reg [7:0] mem_vir_addr [0:7];//mem_vir_addr为8个8位寄存器数组，用于存储虚拟地址
reg [4:0] process=5'b00000;//process是读取RAM数据进程。
reg [3:0] sub=0,sub1=0;//sub是mem_Img_data下角标0~15,表示对应的寄存器
integer i=0,format_en=1;//读取图片格式使能，1：需要读取图片格式数据，0：已经读过图片格式数据
always @(posedge clk,negedge rst_n)
begin
    if(!rst_n)
    begin
        
    end    
end
always @(posedge clk,negedge rst_n)
begin
    if(!rst_n)
    begin
        process <= 5'b00000;
        sub <= 4'b0000;
        sub1 <= 4'b0000;
    end
    else
        begin
            if(process<=5'b11111)
            begin
                process <= process + 5'b00001;
                if(process<5'b10000)
                    sub <= sub + 4'b0001;
                else if(process>=5'b11000&&process<=5'b11111)
                    sub1 <= sub1 + 4'b0001;
                else
                begin
                    sub <= 4'b0000;
                    sub1 <= 4'b0000;
                end
            end
            else
                process <= 5'b00000;//既然设定了process位数那么这句也许可以去掉
        end
end
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)//复位按键只是消除FPGA内部寄存器中存储的数据
    begin
//        format_en <= 1;
        sub <= 0;
        for (i=0;i<15;i=i+1)
            mem_Img_data[i] <= 0;
    end
    else
    begin
        if ((rcount < 32768)&&(count[1:0] == 2'b11))
        begin
            if (process < 5'b10000)//process:0~15（读取图片像素颜色）16~23（读取图片格式）24~31（读取最新两次接收的第一个像素在整个图片比特流中位置）               
                mem_Img_data[sub-1] <= data_in;//把RAM中的数据读取到FPGA内的寄存器里
            else if(process >= 5'b10000 && process <= 5'b10111) 
            begin
                mem_Img_format[0] <= data_in[7:4];//提取宽度数据
                mem_Img_format[1] <= data_in[3:0];//提取长度数据
                format_en <= 0;//提取一次图片格式就够了，后面可以跳过这个进程。
            end
            else
            begin
                mem_vir_addr[sub1-1
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
            data_out <= mem[sub];
        else
            data_out <= 0;
end
//wen: write enable of RAM
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
    begin
        wen <= 0;
    end
    else
        if ((rcount >= 16)&&(rcount < 32))
            wen <= 1;
        else
            wen <= 0;
end
endmodule
