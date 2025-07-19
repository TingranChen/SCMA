module SRAMCIMfinal(
        input [511:0]data_in_cim, 
        input model,
        input set,
        input comp,
        input inbit,
        input wait_,
        input clk,
        input [7:0]a,
        input [31:0]d,
        output [191:0]q,
        input [15:0]sel_array,
        input col_en,
        input reg_en,
        input wrt
);
//reg aa;
//always @(posedge clk)begin
//	aa <= reg_en & col_en & reg_en & wrt & wrtbuf;
//end
//wire read_en = comp & model & (~inbit) & (wait_);
//wire [191:0]q10 = {192{read_en}} | data_in_cim[191:0] | data_in_cim[383:192] | {16'b0,sel_array,d,data_in_cim[511:384]};
//wire [191:0]q10 = data_in_cim[191:0];
//wire [191:0]q9 = ~q10;
//wire [191:0]q8 = ~q9;
//wire [191:0]q7 = ~q8;
//wire [191:0]q6 = ~q7;
//wire [191:0]q5 = ~q6;
//wire [191:0]q4 = ~q5;
//wire [191:0]q3 = ~q4;
//wire [191:0]q2 = ~q3;
//wire [191:0]q1 = ~q2;
//wire [191:0]q0 = ~q1;
//assign q = ~q10;
endmodule
