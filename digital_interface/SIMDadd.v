`timescale 1ns / 1ps

module SIMDadder(
        input [63:0] A,
        input [63:0] B,
        input [3:0]conf,
        output [63:0] Cout
    );
    wire sub = conf[2];
    wire en = conf[3];
    wire [63:0] B_real = sub?(~B):B;
    wire [4:0] C0 = A[3:0]   +  B_real[3:0]   + sub;
    wire [4:0] C1 = A[7:4]   +  B_real[7:4]    + (sub);
    wire [4:0] C2 = A[11:8]  +  B_real[11:8]    + (sub);
    wire [4:0] C3 = A[15:12] +  B_real[15:12]    + (sub);
    wire [4:0] C4 = A[19:16]   +  B_real[19:16]  + sub;
    wire [4:0] C5 = A[23:20]   +  B_real[23:20]  + (sub);
    wire [4:0] C6 = A[27:24]  +  B_real[27:24]   + (sub);
    wire [4:0] C7 = A[31:28] +  B_real[31:28]    + (sub);
    wire [4:0] C8 = A[35:32]   +  B_real[35:32]  + sub;
    wire [4:0] C9 = A[39:36]   +  B_real[39:36]  + (sub);
    wire [4:0] C10 = A[43:40]  +  B_real[43:40]  + (sub);
    wire [4:0] C11 = A[47:44] +  B_real[47:44]   + (sub);
    wire [4:0] C12 = A[51:48]   +  B_real[51:48] + sub;
    wire [4:0] C13 = A[55:52]   +  B_real[55:52] + (sub);
    wire [4:0] C14 = A[59:56]  +  B_real[59:56]  + (sub);
    wire [4:0] C15 = A[63:60] +  B_real[63:60]   + (sub);
    
    assign Cout = en?{C15[3:0],C14[3:0],C13[3:0],C12[3:0],C11[3:0],C10[3:0],C9[3:0],C8[3:0],C7[3:0],C6[3:0],C5[3:0],C4[3:0],C3[3:0],C2[3:0],C1[3:0],C0[3:0]}:A;
    
endmodule
