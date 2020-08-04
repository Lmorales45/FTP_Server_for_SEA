`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shi Bohao
// 
// Create Date: 2020/08/02 12:58:55
// Design Name: 
// Module Name: get_data_from_esp32
// Project Name: 
// Target Devices: SEA
// Tool Versions: 2018.3
// Description: 
// 
// Dependencies: 
// 
// Revision:1.1
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
input Set_X,
input Set_Y,
//RAM 
output reg [addr_width-1:0] addr,//Ҫ��ȡ��������RAM�еĵ�ַ
input [7:0]data_in,//RAM�������������
//input enb,
output reg [23:0] data_out
);
reg [31:0] width=0,deepth=0,x_lower,x_higher,y_lower,y_higher;//����ͼƬ��ȡ�����,Set_X��Set_Y������
reg [3:0] sub=0,sub1=0;//sub��mem_Img_data�½Ǳ�0~15,��ʾ��Ӧ�ļĴ���;sub1�Ƕ�ȡ��Ⱥͳ���ʱʹ�õ��±�
reg [7:0] mem_Img_format [0:7];//mem_Img_formatΪ8��8λ�Ĵ��������飬���ڴ洢ͼƬ��ʽ(mem_Img_format[0][3:0]�Ĵ����洢ͼƬ��ȣ�mem_Img_format[1][3:0]�Ĵ����洢ͼƬ���ȡ�
integer i=0,format_en=0,temp;//format_en=1��ʾ�Ѿ���ȡ��ȡ����ȡ���Ϊ���ǵ�ͼƬ����1bit�ͱ�ʾ������ɫ����ɫ���߰�ɫ������һ�δ�RAM�ж�ȡ8bit���Ծ���һ�ξͶ���8�����ص����ɫ�����Ծ���Ҫ��temp���ֱ���ȡdata_in�������
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        format_en <= 0;
        width <= 0;
        deepth <= 0;
        for (i=0;i<=7;i=i+1)
            mem_Img_format[i] <= 0;
        i <= 0;        
    end
    else
    begin
        if(deepth == 0&&width==0)
        begin
            if(i<=7)
            begin
            mem_Img_format[i] <= data_in;
            i <= i+1;
            end
            else
            begin
                width <= {mem_Img_format[0],mem_Img_format[1],mem_Img_format[2],mem_Img_format[3]};
                deepth <= {mem_Img_format[4],mem_Img_format[5],mem_Img_format[6],mem_Img_format[7]};                
                i <= 0;
                format_en <= 1;
            end
        end
    end
end
//registers & wire
//reg [16:0] count; 
//wire [14:0] rcount;//0x00 ~ 0x0f : get the data ; 0x10 ~ 0x1f : output the data to RAM
//assign rcount = count[16:2];//�ڵ�ַ�ı������ʱ�����ں�RAM����������Ż���иı�
//count: counter of clk
//always @(posedge clk,negedge rst_n)
//begin
//    if (!rst_n)
//        count <= 0;
//    else
//        if (rcount < 32768)//ͼƬ����Ϊÿ��128���أ��ܹ�256�С���ΪͼƬ������ɫֻ�к�ɫ�Ͱ�ɫ������ͼƬ������ɫ���ݴ�СҲ��256*128bit
//            count <= count + 1;
//        else
//            count <= 0;
//end
//addr: address to RAM, address change while count[1:0] == 2'b00, data store while count[1:0] == 2'b11
always @(*)
begin
    if(width!=0 && deepth!=0)
    begin
        x_lower = (1920 - width)/2;
        x_higher = x_lower + width;
        y_lower = (1080 - deepth)/2;
        y_higher = y_lower + deepth;
    end
    else
    begin
        x_lower = 0;
        x_higher = 0;
        y_lower = 0;
        y_higher = 0;       
    end
end
always @(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        addr <= 0;
        temp <= 0;
    end
    else
    begin
        if(deepth == 0 && width == 0)
        begin
            addr <= addr + 1;//��ֱ�Ӱ�i��ֵ��addr��addr���i��һ�����ڣ�����Ԥ�ڶ���ͬ��������
            data_out <= 24'hffffff;
        end
        else//��ȡ���ȡ����ȡ���ʱaddr=8
        begin
            if(x_lower != 0 && x_higher != 0 && y_lower != 0 && y_higher != 0)
            begin
                if(Set_X >= x_lower && Set_X < x_higher)
                begin
                    if(Set_Y >= x_lower && Set_Y < x_higher)
                        begin
                        if(temp < 7)
                        begin
                            data_out <= {24{data_in[7-temp]}};//1λת24λ data_in�����λ������Ҫ�����������ɫֵ
                            temp <= temp + 1;
                        end
                        else if(temp ==7)
                        begin
                            data_out <= {24{data_in[7-temp]}};//1λת24λ data_in�����λ������Ҫ�����������ɫֵ
                            temp <= 0;
                            addr <= addr +1;
                        end
                        else
                            data_out <= {24{data_in[7-temp]}};//��RAM��ȡ��һ��8bit����
                        end
                    else
                        data_out <= 24'hffffff;
                end
                else
                    data_out <= 24'hffffff;
            end
        end
        
    end
//        if (rcount < 32768)
//            addr <= rcount;//����RAM�����е�ַ0~32767
//        else
//            addr <= 0;
end
//reg [7:0] mem_Img_data [0:15];//mem_Img_dataΪ16��8λ�Ĵ��������飬���ڴ洢ͼƬ����RGB_data
///reg [3:0] sub=0,sub1=0;//sub��mem_Img_data�½Ǳ�0~15,��ʾ��Ӧ�ļĴ���;sub1�Ƕ�ȡ��Ⱥͳ���ʱʹ�õ��±�
//reg [31:0] width=0,deepth=0;//����ͼƬ��ȡ�����
//integer i=0,format_en=0;

//read data from RAM
//always @(posedge clk,negedge rst_n)
//begin
//    if (!rst_n)//��λ����ֻ������FPGA�ڲ��Ĵ����д洢������
//    begin
//        sub <= 0;
//        sub1 <= 0;
//        format_en <= 0;
//        for (i=0;i<15;i=i+1)
//            mem_Img_data[i] <= 0;
//    end
//    else
//    begin
//        if ((rcount < 32768)&&(count[1:0] == 2'b11))//����32768������ȼ������RAM���ܹ����˶��٣�������ֱ����������
//        begin
//            if (rcount < 8)//�ȶ�ȡ��ȡ���������
//            begin
//                if(sub1<8)
//                begin
//                    mem_Img_format[sub1] <= data_in;
//                    sub1 <= sub1 +1;
//                end
//                else
//                begin
//                    format_en <= 1;
//                    sub1 <= 0;
//                end
//            end
//            else//rcount>=8<=>RAM�е�ַ>=8��Щ��ַ��ȫ���洢������������
//            begin
//                if(sub < 16)
//                begin
//                    mem_Img_data[sub] <= data_in;
//                    sub <= sub +1;
//                end
//                else
//                    sub <= 0;
//            end
//        end
//    end
//end
//always @(posedge clk or negedge rst_n)//��ȡ��ȡ�����
//begin
//    if(!rst_n)
//    begin
//        width <= 0;
//        deepth <= 0;
//    end
//    else
//    begin
//        width <= {mem_Img_format[0],mem_Img_format[1],mem_Img_format[2],mem_Img_format[3]};
//        deepth <= {mem_Img_format[4],mem_Img_format[5],mem_Img_format[6],mem_Img_format[7]};
//    end
//end
//always @(*)
//begin
//    if(Set_X>=832&&Set_X<1088)
//        begin
//            if(Set_Y>=220&&Set_Y<860)
//            begin
                
//            end
//        end
//end
////data_out: output the data in mem
//always @(posedge clk,negedge rst_n)
//begin
//    if (!rst_n)
//        data_out <= 0;
//    else
//        if (rcount < 32)
//            data_out <= mem_Img_data[sub];
//        else
//            data_out <= 0;
//end

endmodule
