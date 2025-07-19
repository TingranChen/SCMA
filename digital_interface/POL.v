`timescale 1ns / 1ps
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
//模拟芯片状态有wrt、wrtbuf、set、comp、inbit、wait、read
//预期IO： a<0：8>、d<0:16>、q<-:16>、wen、wbuf、cal、CLK、epol、 eact
//其中wen、wbuf、cal为使能信号，具体功能如表
//wen	Wbuf	cal	Epol	eact	功能
//1	0	0	-	-	写主阵列
//1	0	1	-	-	写主阵列
//1	1	0	-	-	写iobuf
//1	1	1	-	-	写iobuf
//0	0	1	-	-	进入计算状态机
//0	0	0	0	0	可读数据结果，结果不进行池化或激活操作
//0	0	0	0	1	可读数据结果，结果进行激活操作
//0	0	0	1	0	可读数据结果，结果进行激活操作
//0	0	0	1	1	可读数据结果，结果进行激活与池化操作

//////////////////////////////////////////////////////////////////////////////////


module POL(
    input clk,
    input epol,
    input [2:0] pol_s,
    input [15:0] q,
    );
endmodule
