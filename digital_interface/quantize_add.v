module quantize_add(
    input [3:0]input_a,
    input [3:0]input_b,
    output [3:0]output_sum
);
    wire [4:0]tmp_sum;
    assign tmp_sum = input_b + {2'b00,input_a[3:2]};
    assign output_sum = tmp_sum[4]?4'hF:tmp_sum[3:0];
endmodule
