module quantize_6to4(
    input [5:0]b6_input,
    output [3:0]b4_output,
    input col_en,
    input matrix_16to9,
    input matrix_8to5,
    input matrix_4to3,
    input matrix_2,
    input matrix_1
);
    // wire matrix_16to8 = matrix_act[4]||matrix_act[3];
    // wire matrix_8to4 = (!matrix_16to8) && (matrix_act[2]);
    // wire matrix_4to2 = (!matrix_16to8) && (!matrix_8to4) && (matrix_act[1]);
    // wire matrix_2to1 = (!matrix_16to8) && (!matrix_8to4) && (!matrix_4to2) && (matrix_act[0]);
    // wire matrix_2to1 = matrix_act[]
    // assign b4_output = (b6_input[5])?b6_input[5:2]:(b6_input[5:4]==2'b01)?b6_input[4:1]: 
    // (b6_input[5:3]==3'b001)?b6_input[3:0]:(b6_input[5:2]==4'b0001)?{b6_input[2:0],1'b0}:{b6_input[1:0],2'b0};

    assign b4_output = col_en ? {b6_input[2:0],1'b0} : matrix_16to9 ? b6_input[5:2] : matrix_8to5 ? b6_input[5]? 4'hF :
                                b6_input[4:1] : matrix_4to3 ? b6_input[4]? 4'hF : b6_input[3:0] : matrix_2 ? b6_input[3]? 4'b1110 :
                                {b6_input[2:0],1'b0} : matrix_1 ? b6_input[2] ? 4'b1100 : {b6_input[1:0],2'b00} : 4'h0;

endmodule