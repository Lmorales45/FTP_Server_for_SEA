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
parameter addr_width = 15//��ַ15bit
)(
input clk,//100MHZ
input rst_n,
//RAM 
output reg [addr_width-1:0] addr,//Ҫ��ȡ��������RAM�еĵ�ַ
input [7:0]data_in,//RAM�������������
//input enb,
output reg [7:0] data_out
);
//registers & wire
reg [16:0] count; 
wire [14:0] rcount;//0x00 ~ 0x0f : get the data ; 0x10 ~ 0x1f : output the data to RAM
assign rcount = count[16:2];//�ڵ�ַ�ı������ʱ�����ں�RAM����������Ż���иı�
//count: counter of clk
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        count <= 0;
    else
        if (rcount < 32768)//ͼƬ����Ϊÿ��128���أ��ܹ�256�С���ΪͼƬ������ɫֻ�к�ɫ�Ͱ�ɫ������ͼƬ������ɫ���ݴ�СҲ��256*128bit
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
            addr <= rcount;//����RAM�����е�ַ0~32767
        else
            addr <= 0;
end
reg [7:0] mem_Img_data [0:15];//mem_Img_dataΪ16��8λ�Ĵ��������飬���ڴ洢ͼƬ����RGB_data
reg [7:0] mem_Img_format [0:7];//mem_Img_formatΪ8��8λ�Ĵ��������飬���ڴ洢ͼƬ��ʽ(mem_Img_format[0][3:0]�Ĵ����洢ͼƬ��ȣ�mem_Img_format[1][3:0]�Ĵ����洢ͼƬ���ȡ�
reg [3:0] sub=0,sub1=0;//sub��mem_Img_data�½Ǳ�0~15,��ʾ��Ӧ�ļĴ���;sub1�Ƕ�ȡ��Ⱥͳ���ʱʹ�õ��±�

integer i=0;

//read data from RAM
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)//��λ����ֻ������FPGA�ڲ��Ĵ����д洢������
    begin
        sub <= 0;
        sub1 <= 0;
        for (i=0;i<15;i=i+1)
            mem_Img_data[i] <= 0;
    end
    else
    begin
        if ((rcount < 32768)&&(count[1:0] == 2'b11))//����32768������ȼ������RAM���ܹ����˶��٣�������ֱ����������
        begin
            if (rcount < 8)//�ȶ�ȡ��ȡ���������
            begin
                if(sub1<8)
                begin
                    mem_Img_format[sub1] <= data_in;
                    sub1 <= sub1 +1;
                end
                else
                    sub1 <= 0;
            end
            else//rcount>=8<=>RAM�е�ַ>=8��Щ��ַ��ȫ���洢������������
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
