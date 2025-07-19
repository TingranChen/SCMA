module quantize(
    input [191:0]cim_input,
    input col_en,
    input [4:0]matrix_act,
    output [63:0]cim_output
);
    wire [127:0]cim_quantize;
    wire matrix_16to9,matrix_8to5,matrix_4to3,matrix_2,matrix_1;

    assign matrix_16to9 = ((matrix_act==5'b10000)|| ((matrix_act[4]==1'b0) && matrix_act[3])) && (!matrix_8to5);
    assign matrix_8to5 = ((matrix_act==5'b01000) || ((matrix_act[4:3]==2'b00) && matrix_act[2])) && (!matrix_4to3);
    assign matrix_4to3 = ((matrix_act==5'b00100) || (matrix_act[1])) && (!matrix_2);
    assign matrix_2 = (matrix_act==5'b00010);
    assign matrix_1 = (matrix_act == 5'b00001);
    // wire matrix_2to1 = matrix_act[]

    quantize_6to4 DUT_0(
        .b6_input(cim_input[5:0]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[3:0])
    );

    quantize_6to4 DUT_1(
        .b6_input(cim_input[11:6]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[7:4])
    );
    
    quantize_6to4 DUT_2(
        .b6_input(cim_input[17:12]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[11:8])
    );
    
    quantize_6to4 DUT_3(
        .b6_input(cim_input[23:18]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[15:12])
    );
    
    quantize_6to4 DUT_4(
        .b6_input(cim_input[29:24]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[19:16])
    );
    
    quantize_6to4 DUT_5(
        .b6_input(cim_input[35:30]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[23:20])
    );
    
    quantize_6to4 DUT_6(
        .b6_input(cim_input[41:36]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[27:24])
    );
    
    quantize_6to4 DUT_7(
        .b6_input(cim_input[47:42]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[31:28])
    );
    
    quantize_6to4 DUT_8(
        .b6_input(cim_input[53:48]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[35:32])
    );
    
    quantize_6to4 DUT_9(
        .b6_input(cim_input[59:54]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[39:36])
    );
    
    quantize_6to4 DUT_10(
        .b6_input(cim_input[65:60]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[43:40])
    );
    
    quantize_6to4 DUT_11(
        .b6_input(cim_input[71:66]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[47:44])
    );
    
    quantize_6to4 DUT_12(
        .b6_input(cim_input[77:72]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[51:48])
    );
    
    quantize_6to4 DUT_13(
        .b6_input(cim_input[83:78]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[55:52])
    );
    
    quantize_6to4 DUT_14(
        .b6_input(cim_input[89:84]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[59:56])
    );
    
    quantize_6to4 DUT_15(
        .b6_input(cim_input[95:90]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[63:60])
    );
    
    quantize_6to4 DUT_16(
        .b6_input(cim_input[101:96]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[67:64])
    );
    
    quantize_6to4 DUT_17(
        .b6_input(cim_input[107:102]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[71:68])
    );
    
    quantize_6to4 DUT_18(
        .b6_input(cim_input[113:108]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[75:72])
    );
    
    quantize_6to4 DUT_19(
        .b6_input(cim_input[119:114]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[79:76])
    );
    
    quantize_6to4 DUT_20(
        .b6_input(cim_input[125:120]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[83:80])
    );
    
    quantize_6to4 DUT_21(
        .b6_input(cim_input[131:126]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[87:84])
    );
    
    quantize_6to4 DUT_22(
        .b6_input(cim_input[137:132]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[91:88])
    );
    
    quantize_6to4 DUT_23(
        .b6_input(cim_input[143:138]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[95:92])
    );
    
    quantize_6to4 DUT_24(
        .b6_input(cim_input[149:144]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[99:96])
    );
    
    quantize_6to4 DUT_25(
        .b6_input(cim_input[155:150]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[103:100])
    );
    
    quantize_6to4 DUT_26(
        .b6_input(cim_input[161:156]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[107:104])
    );
    
    quantize_6to4 DUT_27(
        .b6_input(cim_input[167:162]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[111:108])
    );
    
    quantize_6to4 DUT_28(
        .b6_input(cim_input[173:168]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[115:112])
    );
    
    quantize_6to4 DUT_29(
        .b6_input(cim_input[179:174]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[119:116])
    );
    
    quantize_6to4 DUT_30(
        .b6_input(cim_input[185:180]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[123:120])
    );
    
    quantize_6to4 DUT_31(
        .b6_input(cim_input[191:186]),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize[127:124])
    );


    quantize_add QA_0(
        .input_a(cim_quantize[3:0]),
        .input_b(cim_quantize[7:4]),
        .output_sum(cim_output[3:0])
    );
    quantize_add QA_1(
        .input_a(cim_quantize[11:8]),
        .input_b(cim_quantize[15:12]),
        .output_sum(cim_output[7:4])
    );
    quantize_add QA_2(
        .input_a(cim_quantize[19:16]),
        .input_b(cim_quantize[23:20]),
        .output_sum(cim_output[11:8])
    );
    quantize_add QA_3(
        .input_a(cim_quantize[27:24]),
        .input_b(cim_quantize[31:28]),
        .output_sum(cim_output[15:12])
    );
    quantize_add QA_4(
        .input_a(cim_quantize[35:32]),
        .input_b(cim_quantize[39:36]),
        .output_sum(cim_output[19:16])
    );
    quantize_add QA_5(
        .input_a(cim_quantize[43:40]),
        .input_b(cim_quantize[47:44]),
        .output_sum(cim_output[23:20])
    );
    quantize_add QA_6(
        .input_a(cim_quantize[51:48]),
        .input_b(cim_quantize[55:52]),
        .output_sum(cim_output[27:24])
    );
    quantize_add QA_7(
        .input_a(cim_quantize[59:56]),
        .input_b(cim_quantize[63:60]),
        .output_sum(cim_output[31:28])
    );
    quantize_add QA_8(
        .input_a(cim_quantize[67:64]),
        .input_b(cim_quantize[71:68]),
        .output_sum(cim_output[35:32])
    );
    quantize_add QA_9(
        .input_a(cim_quantize[75:72]),
        .input_b(cim_quantize[79:76]),
        .output_sum(cim_output[39:36])
    );
    quantize_add QA_10(
        .input_a(cim_quantize[83:80]),
        .input_b(cim_quantize[87:84]),
        .output_sum(cim_output[43:40])
    );
    quantize_add QA_11(
        .input_a(cim_quantize[91:88]),
        .input_b(cim_quantize[95:92]),
        .output_sum(cim_output[47:44])
    );
    quantize_add QA_12(
        .input_a(cim_quantize[99:96]),
        .input_b(cim_quantize[103:100]),
        .output_sum(cim_output[51:48])
    );
    quantize_add QA_13(
        .input_a(cim_quantize[107:104]),
        .input_b(cim_quantize[111:108]),
        .output_sum(cim_output[55:52])
    );
    quantize_add QA_14(
        .input_a(cim_quantize[115:112]),
        .input_b(cim_quantize[119:116]),
        .output_sum(cim_output[59:56])
    );
    quantize_add QA_15(
        .input_a(cim_quantize[123:120]),
        .input_b(cim_quantize[127:124]),
        .output_sum(cim_output[63:60])
    );

endmodule