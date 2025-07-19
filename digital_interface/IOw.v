`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/21 17:03:24
// Design Name: 
// Module Name: IOw
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
//ģ��оƬ״̬��wrt��wrtbuf��set��comp��inbit��wait��read
//Ԥ��IO�� a<0��8>��d<0:16>��q<-:16>��wen��wbuf��cal��CLK��epol�� eact
//����wen��wbuf��calΪʹ���źţ����幦�����
//wen	Wbuf	cal	Epol	eact	����
//1	0	0	-	-	д������
//1	0	1	-	-	д������
//1	1	0	-	-	дiobuf
//1	1	1	-	-	дiobuf
//0	0	1	-	-	�������״̬��
//0	0	0	0	0	�ɶ����ݽ������������гػ��򼤻����
//0	0	0	0	1	�ɶ����ݽ����������м������
//0	0	0	1	0	�ɶ����ݽ����������м������
//0	0	0	1	1	�ɶ����ݽ����������м�����ػ�����

//////////////////////////////////////////////////////////////////////////////////


module IOw(
    input clk,
    input wen,
    input wbuf,
    input cal,
    input [8:0]a_in,
    input [3:0]cim_a,
    input read,
    output [8:0] a_out,
    output wrt,
    output wrtbuf,
    output cal_b//cal_b�źŲ���״̬���Ŀ���
    );
    assign wrt = wen & !wbuf;
    assign wrtbuf = wen & wbuf;
    assign cal_b = cal & (~wen) & (~wbuf);
    assign a_out[3:0] = read?cim_a:a_in[3:0];
    assign a_out[8:4] = read?5'b0:a_in[8:4];
endmodule
