`timescale 1ns / 1ps

module SIMDshifter(
        input [63:0] shiftinput,
        input [3:0] conf,
        output [63:0] shiftoutput
    );
    wire left = conf[0];
    wire right = conf[1];
    wire en = conf[3]; 
    wire [62:0] left_shift =  shiftinput[62:0];
    wire [62:0] right_shift =  shiftinput[63:1];
    wire [63:0] shiftoutput_tmp = (en&left)?{left_shift,1'b0}:(en&(!left)&right)?{1'b0,right_shift}:shiftinput;
    assign shiftoutput[3:0]   = en?{left&shiftoutput_tmp[3],   shiftoutput_tmp[2:0]}:shiftinput[3:0];
    assign shiftoutput[7:4]   = en?{left&shiftoutput_tmp[7],     shiftoutput_tmp[6:5], !left&shiftoutput_tmp[4]}:shiftinput[7:4];
    assign shiftoutput[11:8]  = en?{left&shiftoutput_tmp[11],  shiftoutput_tmp[10:9],   !left&shiftoutput_tmp[8]}:shiftinput[11:8];
    assign shiftoutput[15:12] = en?{left&shiftoutput_tmp[15],    shiftoutput_tmp[14:13],  !left&shiftoutput_tmp[12]}:shiftinput[15:12];
    assign shiftoutput[19:16]   = en?{left&shiftoutput_tmp[19],     shiftoutput_tmp[18:17], !left&shiftoutput_tmp[16]}:shiftinput[19:16];
    assign shiftoutput[23:20]  = en?{left&shiftoutput_tmp[23],  shiftoutput_tmp[22:21],   !left&shiftoutput_tmp[20]}:shiftinput[23:20];
    assign shiftoutput[27:24] = en?{left&shiftoutput_tmp[27],    shiftoutput_tmp[26:25],  !left&shiftoutput_tmp[24]}:shiftinput[27:24];
    assign shiftoutput[31:28]   = en?{left&shiftoutput_tmp[31],   shiftoutput_tmp[30:29],  !left&shiftoutput_tmp[28]}:shiftinput[31:28];
    assign shiftoutput[35:32]   = en?{left&shiftoutput_tmp[35],     shiftoutput_tmp[34:33], !left&shiftoutput_tmp[32]}:shiftinput[35:32];
    assign shiftoutput[39:36]  = en?{left&shiftoutput_tmp[39],  shiftoutput_tmp[38:37],   !left&shiftoutput_tmp[36]}:shiftinput[39:36];
    assign shiftoutput[43:40] = en?{left&shiftoutput_tmp[43],    shiftoutput_tmp[42:41],   !left&shiftoutput_tmp[40]}:shiftinput[43:40];
    assign shiftoutput[47:44]   = en?{left&shiftoutput_tmp[47],     shiftoutput_tmp[46:45], !left&shiftoutput_tmp[44]}:shiftinput[47:44];
    assign shiftoutput[51:48]  = en?{left&shiftoutput_tmp[51],  shiftoutput_tmp[50:49],   !left&shiftoutput_tmp[48]}:shiftinput[51:48];
    assign shiftoutput[55:52] = en?{left&shiftoutput_tmp[55],    shiftoutput_tmp[54:53],   !left&shiftoutput_tmp[52]}:shiftinput[55:52];
    assign shiftoutput[59:56]   = en?{left&shiftoutput_tmp[59],     shiftoutput_tmp[58:57],  !left&shiftoutput_tmp[56]}:shiftinput[59:56];
    assign shiftoutput[63:60]  = en?{left&shiftoutput_tmp[63],  shiftoutput_tmp[62:61],  !left&shiftoutput_tmp[60]}:shiftinput[63:60];
    
    
    
    
endmodule
