`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/25 19:33:08
// Design Name: 
// Module Name: system_io
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


module system_io(
    input clk,
    input wen,
    input wbuf,
    input cal,
    output cal_done,
    input [8:0]a_chip,
    input [15:0]d,
    input eact,
    output [5:0]q
    );
       wire [15:0] d_cim;//CIM input 
       assign d_cim = d;
       wire read;//CIM input
       wire [8:0]a;//CIM input
       wire wrt;//CIM input
       wire wrtbuf;//CIM input
       wire [3:0]cim_a;
       wire cal_b; 
       IOw iow(
        .clk(clk),
        .wen(wen),
        .wbuf(wbuf),
        .cal(cal),
        .a_in(a_chip),
        .cim_a(cim_a),
        .read(read),
        .a_out(a),
        .wrt(wrt),
        .wrtbuf(wrtbuf),
        .cal_b(cal_b)//cal_b信号参与状态机的控制
        );
    
        reg [15:0]q_in_cim;//CIM output
        wire comp;//CIM input
        wire model;//CIM input
        wire wait_;//CIM input
        wire inbit;//CIM input
        wire set;//CIM input
        wire [5:0]SMw_data;
       SMw smw(
        .clk(clk),
        .cal_b(cal_b),
        .q(q_in_cim),
        .cim_a(cim_a),
        .a(a_chip[4:0]),//adderess of out ,form system IO
        .comp(comp),
        .model(model),
        .wait_(wait_),
        .inbit(inbit),
        .set(set),
        .read(read),
        .cal_done(cal_done),
        .data_out(SMw_data)
        );
        wire [5:0]ACT_data;//system output
        assign a = ACT_data;
        ACT act(
            .eact(eact),
            .data_in(SMw_data),
            .data_out(ACT_data)
            );
            

endmodule
