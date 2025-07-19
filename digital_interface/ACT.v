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


module ACT(
    input eact,
    input [7:0]data_in,
    output [7:0]data_out
    );
    Relu relu(
    .data(data_in),
    .RELU(eact),
    .out(data_out)
    );
endmodule
