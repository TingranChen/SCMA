module simutop_quantize();

    reg [5:0]cim_input;
    reg col_en;
    reg [4:0]matrix_act;
    wire [3:0]cim_quantize;

    wire matrix_16to9,matrix_8to5,matrix_4to3,matrix_2,matrix_1;

    assign matrix_16to9 = ((matrix_act==5'b10000)|| ((matrix_act[4]==1'b0) && matrix_act[3])) && (!matrix_8to5);
    assign matrix_8to5 = ((matrix_act==5'b01000) || ((matrix_act[4:3]==2'b00) && matrix_act[2])) && (!matrix_4to3);
    assign matrix_4to3 = ((matrix_act==5'b00100) || (matrix_act==5'b00011));
    assign matrix_2 = (matrix_act==5'b00010);
    assign matrix_1 = (matrix_act == 5'b00001);

    quantize_6to4 DUT_0(
        .b6_input(cim_input),
        .col_en(col_en),
        .matrix_16to9(matrix_16to9),
        .matrix_8to5(matrix_8to5),
        .matrix_4to3(matrix_4to3),
        .matrix_2(matrix_2),
        .matrix_1(matrix_1),
        .b4_output(cim_quantize)
    );


    initial begin
        $fsdbDumpfile("vcs_simutop.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA();

        #1 cim_input = 6'b111111;
        col_en = 0;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;

        #10 cim_input = 6'b111111;
        col_en = 1;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;

        #10 col_en = 1;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;

        #10  cim_input = 6'b101010;
        col_en = 0;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;

        #10  cim_input = 6'b010101;
        col_en = 0;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;

        #10  cim_input = 6'b111111;
        col_en = 0;
        matrix_act = 5'd1;
        #1 matrix_act = 5'd2;
        #1 matrix_act = 5'd4;
        #1 matrix_act = 5'd8;
        #1 matrix_act = 5'd16;
    end
endmodule