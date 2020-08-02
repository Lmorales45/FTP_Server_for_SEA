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
output reg [7:0] data_out,
output reg wen
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
reg [3:0] mem_Img_format [0:1];//mem_Img_formatΪ2��4λ�Ĵ��������飬���ڴ洢ͼƬ��ʽ(mem_Img_format[0][3:0]�Ĵ����洢ͼƬ��ȣ�mem_Img_format[1][3:0]�Ĵ����洢ͼƬ���ȡ�
//reg [7:0] mem_vir_addr [0:7];//mem_vir_addrΪ8��8λ�Ĵ������飬���ڴ洢�����ַ
reg [4:0] process=5'b00000;//process�Ƕ�ȡRAM���ݽ��̡�
reg [3:0] sub=0,sub1=0;//sub��mem_Img_data�½Ǳ�0~15,��ʾ��Ӧ�ļĴ���
integer i=0,format_en=1;//��ȡͼƬ��ʽʹ�ܣ�1����Ҫ��ȡͼƬ��ʽ���ݣ�0���Ѿ�����ͼƬ��ʽ����
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
                process <= 5'b00000;//��Ȼ�趨��processλ����ô���Ҳ�����ȥ��
        end
end
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)//��λ����ֻ������FPGA�ڲ��Ĵ����д洢������
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
            if (process < 5'b10000)//process:0~15����ȡͼƬ������ɫ��16~23����ȡͼƬ��ʽ��24~31����ȡ�������ν��յĵ�һ������������ͼƬ��������λ�ã�               
                mem_Img_data[sub-1] <= data_in;//��RAM�е����ݶ�ȡ��FPGA�ڵļĴ�����
            else if(process >= 5'b10000 && process <= 5'b10111) 
            begin
                mem_Img_format[0] <= data_in[7:4];//��ȡ�������
                mem_Img_format[1] <= data_in[3:0];//��ȡ��������
                format_en <= 0;//��ȡһ��ͼƬ��ʽ�͹��ˣ������������������̡�
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
