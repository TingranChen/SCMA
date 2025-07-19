`timescale 1ns / 1ns

module SCMA_wrapper #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 11,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 4,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter DATA_CIM_IN_WIDTH = 32,
    parameter CIM_ROW = 128,
    parameter CHIP_EN_DATA_0 = 4'h0,
    parameter CHIP_EN_DATA_1 = 4'h1,
    parameter CHIP_EN_DATA_2 = 4'h2,
    parameter CHIP_EN_DATA_3 = 4'h3,
    parameter CHIP_EN_DATA_4 = 4'h4,
    parameter CHIP_EN_DATA_5 = 4'h5,
    parameter CHIP_EN_DATA_6 = 4'h6,
    parameter CHIP_EN_DATA_7 = 4'h7,
    parameter CHIP_EN_DATA_8 = 4'h8,
    parameter CHIP_EN_DATA_9 = 4'h9,
    parameter CHIP_EN_DATA_10 = 4'hA,
    parameter CHIP_EN_DATA_11 = 4'hB,
    parameter CHIP_EN_DATA_12 = 4'hC,
    parameter CHIP_EN_DATA_13 = 4'hD,
    parameter CHIP_EN_DATA_14 = 4'hE,
    parameter CHIP_EN_DATA_15 = 4'hF,
    parameter CHIP_EN_NUM = 16
)
(
    input clk,
    input rst,
    input [ADDR_IN_WIDTH+CHIP_EN_NUM-1:0]a_in,
    input [DATA_IN_WIDTH-1:0]data_in,
    output [DATA_OUT_WIDTH-1:0] data_out,
	output empty,
	output full
);

wire [CHIP_EN_NUM-1:0]sel_chip = a_in[ADDR_IN_WIDTH+CHIP_EN_NUM-1:ADDR_IN_WIDTH];
//wire [DATA_OUT_WIDTH-1:0] data_out_tmp;
wire [CHIP_EN_NUM-1:0] full_flag,empty_flag;
wire [DATA_OUT_WIDTH-1:0] data_out_0, data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7, data_out_8, data_out_9,
			  data_out_10, data_out_11, data_out_12, data_out_13, data_out_14, data_out_15;

assign data_out = sel_chip[0] ? data_out_0 : sel_chip[1] ? data_out_1 : sel_chip[2] ? data_out_2 : sel_chip[3] ? data_out_3 : sel_chip[4] ? data_out_4 : sel_chip[5] ? data_out_5 : sel_chip[6] ? data_out_6 : sel_chip[7] ? data_out_7 : sel_chip[8] ? data_out_8 : 
		sel_chip[9] ? data_out_9 : sel_chip[10] ? data_out_10 : sel_chip[11] ? data_out_11 : sel_chip[12] ? data_out_12 : sel_chip[13] ? data_out_13 : sel_chip[14] ? data_out_14 : sel_chip[15] ? data_out_15 : 32'b0;  
/*
assign data_out = {DATA_OUT_WIDTH{sel_chip[0]}} & data_out_0 | {DATA_OUT_WIDTH{sel_chip[1]}} & data_out_1 | 
		  {DATA_OUT_WIDTH{sel_chip[2]}} & data_out_2 | {DATA_OUT_WIDTH{sel_chip[3]}} & data_out_3 | 
		  {DATA_OUT_WIDTH{sel_chip[4]}} & data_out_4 | {DATA_OUT_WIDTH{sel_chip[5]}} & data_out_5 | 
		  {DATA_OUT_WIDTH{sel_chip[6]}} & data_out_6 | {DATA_OUT_WIDTH{sel_chip[7]}} & data_out_7 | 
		  {DATA_OUT_WIDTH{sel_chip[8]}} & data_out_8 | {DATA_OUT_WIDTH{sel_chip[9]}} & data_out_9 | 
		  {DATA_OUT_WIDTH{sel_chip[10]}} & data_out_10 | {DATA_OUT_WIDTH{sel_chip[11]}} & data_out_11 | 
		  {DATA_OUT_WIDTH{sel_chip[12]}} & data_out_12 | {DATA_OUT_WIDTH{sel_chip[13]}} & data_out_13 | 
		  {DATA_OUT_WIDTH{sel_chip[14]}} & data_out_14 | {DATA_OUT_WIDTH{sel_chip[15]}} & data_out_15 ;  
*/
//wire en_flag = (a_in[10:0] == 12'b011111111111);
//assign data_out = en_flag? {full_flag,empty_flag} : data_out_tmp;
assign empty = ((empty_flag&sel_chip)==sel_chip);
assign full = |(full_flag&sel_chip);
        SCMU_wrapper #(
            .CHIP_EN_DATA(0)
        )
        dut_SCMU_0(
            .chip_en(sel_chip[0]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_0),
            .empty(empty_flag[0]),
            .full(full_flag[0])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(1)
        )
        dut_SCMU_1(
            .chip_en(sel_chip[1]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_1),
            .empty(empty_flag[1]),
            .full(full_flag[1])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(2)
        )
        dut_SCMU_2(
            .chip_en(sel_chip[2]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_2),
            .empty(empty_flag[2]),
            .full(full_flag[2])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(3)
        )
        dut_SCMU_3(
            .chip_en(sel_chip[3]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_3),
            .empty(empty_flag[3]),
            .full(full_flag[3])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(4)
        )
        dut_SCMU_4(
            .chip_en(sel_chip[4]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_4),
            .empty(empty_flag[4]),
            .full(full_flag[4])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(5)
        )
        dut_SCMU_5(
            .chip_en(sel_chip[5]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_5),
            .empty(empty_flag[5]),
            .full(full_flag[5])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(6)
        )
        dut_SCMU_6(
            .chip_en(sel_chip[6]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_6),
            .empty(empty_flag[6]),
            .full(full_flag[6])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(7)
        )
        dut_SCMU_7(
            .chip_en(sel_chip[7]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_7),
            .empty(empty_flag[7]),
            .full(full_flag[7])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(8)
        )
        dut_SCMU_8(
            .chip_en(sel_chip[8]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_8),
            .empty(empty_flag[8]),
            .full(full_flag[8])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(9)
        )
        dut_SCMU_9(
            .chip_en(sel_chip[9]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_9),
            .empty(empty_flag[9]),
            .full(full_flag[9])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(10)
        )
        dut_SCMU_10(
            .chip_en(sel_chip[10]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_10),
            .empty(empty_flag[10]),
            .full(full_flag[10])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(11)
        )
        dut_SCMU_11(
            .chip_en(sel_chip[11]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_11),
            .empty(empty_flag[11]),
            .full(full_flag[11])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(12)
        )
        dut_SCMU_12(
            .chip_en(sel_chip[12]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_12),
            .empty(empty_flag[12]),
            .full(full_flag[12])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(13)
        )
        dut_SCMU_13(
            .chip_en(sel_chip[13]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_13),
            .empty(empty_flag[13]),
            .full(full_flag[13])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(14)
        )
        dut_SCMU_14(
            .chip_en(sel_chip[14]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_14),
            .empty(empty_flag[14]),
            .full(full_flag[14])
        );

        SCMU_wrapper #(
            .CHIP_EN_DATA(15)
        )
        dut_SCMU_15(
            .chip_en(sel_chip[15]),
            .clk(clk),
            .rst(rst),
            .a_in(a_in[ADDR_IN_WIDTH-1:0]),
            .data_in(data_in),
            .data_out(data_out_15),
            .empty(empty_flag[15]),
            .full(full_flag[15])
        );


endmodule
