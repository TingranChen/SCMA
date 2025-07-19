`timescale 1ns / 1ns

module SCMU_wrapper #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 11,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 8,
    parameter ADDR_CIM_IN_WIDTH = 8, 
    parameter DATA_CIM_IN_WIDTH = 32,
    parameter CIM_ROW = 128,
    parameter CHIP_EN_DATA = 4'h0
)
(
    input chip_en,
    input clk,
    input rst,
    input [ADDR_IN_WIDTH-1:0]a_in,
    input [DATA_IN_WIDTH-1:0]data_in,
    output [DATA_OUT_WIDTH-1:0] data_out,
    output empty,
    output full
    );

    wire [ADDR_IN_WIDTH-1:0]a_in_selected = {32{chip_en}} & a_in;
//    wire [ADDR_IN_WIDTH-1:0]a_in_selected = a_in;
    wire [DATA_IN_WIDTH-1:0]data_in_selected = {36{chip_en}} & data_in;
//    wire [DATA_IN_WIDTH-1:0]data_in_selected = data_in;

    wire col_en_CTR;

    wire empty_inputfifo,empty_inputfifo_IO_b,empty_inputfifo_SM_b,empty_outputfifo,empty_outputfifo_SM_b;

    wire full_outputfifo,full_outputfifo_SM_b,full_inputfifo;

    wire [ADDR_CIM_IN_WIDTH-1:0]a_cim_IO;
    wire [REG_ADDR-1:0]a_reg_IO,a_reg_SM_b;

    wire [15:0]sel_array_CTR;
    //for test without SRAM_CIM2
    wire [191:0]data_in_cim_CIM;
    wire [DATA_CIM_IN_WIDTH-1:0]data_in_cim_IO;
    //
    wire [REG_DATA_WIDTH-1:0]d_reg_IO,d_reg_SM_b;
    wire [DATA_IN_WIDTH-1:0]WR_DATA_IO;
    wire [63:0]WR_DATA_CTR;
    wire [DATA_OUT_WIDTH-1:0]RD_DATA_SM_b,RD_DATA_outputfifo;
    wire [CIM_ROW*4-1:0]RD_DATA_inputfifo;

    wire RD_EN_inputfifo_CTR,RD_EN_inputfifo_SM_b,RD_EN_inputfifo_IO_b;
    wire [DATA_IN_ADDR-1:0]WR_EN_inputfifo_IO;
    wire WR_EN_outputfifo_CTR;
    wire [DATA_OUT_ADDR-1:0]RD_EN_outputfifo_IO,RD_EN_outputfifo_SM_b;

    wire wrt_IO,reg_en_IO,reg_en_inputfifo,reg_en_SM_b,reg_en_CTR_b;
    
    wire cal_b_CTR;
    wire comp_SM,model_SM,wait_SM,inbit_SM,set_SM,cal_done_SM;

    wire [REG_DATA_WIDTH/2-1:0] reg_en_row_inputfifo;

    wire [4:0]matrix_act_inputfifo;

//instance
IO #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .DATA_OUT_WIDTH(DATA_OUT_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
dut_IO 
(
    .clk(clk),
    .rst(rst),
    .col_en(col_en_CTR),
    .empty(empty),
    .empty_outputfifo(empty_outputfifo),
    .full_inputfifo(full_inputfifo),
    .full(full),
    .a_in(a_in_selected),
    .a_cim(a_cim_IO),
    .a_reg(a_reg_IO),
    .d_reg(d_reg_IO),
    .inputfifo_WR_EN(WR_EN_inputfifo_IO),
    .outputfifo_RD_EN(RD_EN_outputfifo_IO),
    .data_in(data_in_selected),
    .data_in_cim(data_in_cim_IO),
    .wrt(wrt_IO),
    .reg_en(reg_en_IO),
    .chip_en(chip_en)
    );

inputFIFO #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH)
)
dut_inputFIFO(
    .CLK(clk),
    .RD_EN(RD_EN_inputfifo_CTR),
    .WR_EN(WR_EN_inputfifo_IO),
    .col_en(col_en_CTR),
    .rst_n(rst),
    .din(data_in_selected),
    .a_reg(a_reg_IO),
    .d_reg(d_reg_IO),
    .RD_DATA(RD_DATA_inputfifo),
    .full(full_inputfifo),
    .empty(empty_inputfifo),
    .reg_en(reg_en_IO),
    .matrix_act(matrix_act_inputfifo)
);

SM #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .DATA_OUT_WIDTH(DATA_OUT_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
dut_SM(
    .clk(clk),
    .cal_b(cal_b_CTR),
    .comp(comp_SM),
    .model(model_SM),
    .wait_(wait_SM),
    .inbit(inbit_SM),
    .set(set_SM),
    .cal_done(cal_done_SM),
    .rst(rst)
);

CONTROLLER #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .DATA_OUT_WIDTH(DATA_OUT_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0) 
)
dut_CONTROLLER(
    .clk(clk),
    .cal_done(cal_done_SM),
    .cal_b(cal_b_CTR),
    .col_en(col_en_CTR),
    .rst(rst),
    .empty_inputfifo(empty_inputfifo),
    .a_reg(a_reg_IO),
    .d_reg(d_reg_IO),
    .reg_en(reg_en_IO),
    .reg_en_b(reg_en_CTR),
    .qin(data_in_cim_CIM),
    .qout(WR_DATA_CTR),
    .full_outputfifo(full_outputfifo),
    .WR_EN_outputfifo(WR_EN_outputfifo_CTR),
    .RD_EN_inputfifo(RD_EN_inputfifo_CTR),
    .sel_array(sel_array_CTR),
    .matrix_act(matrix_act_inputfifo)
);


outputFIFO #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .DATA_OUT_WIDTH(DATA_OUT_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH)
)
dut_outputFIFO(
    .CLK(clk),
    .RD_EN(RD_EN_outputfifo_IO),
    .WR_EN(WR_EN_outputfifo_CTR),
    .rst_n(rst),
    .qin(WR_DATA_CTR),
    .RD_DATA(data_out),
    .full(full_outputfifo),
    .empty(empty_outputfifo)
);

SRAMCIMfinal dut_sramcim(
        .data_in_cim(RD_DATA_inputfifo), 
        .model(model_SM),
        .set(set_SM),
        .comp(comp_SM),
        .inbit(inbit_SM),
        .wait_(wait_SM),
        .clk(clk),
        .a(a_cim_IO),
        .d(data_in_cim_IO),
        .q(data_in_cim_CIM),
        .sel_array(sel_array_CTR),
        .col_en(col_en_CTR),
        .reg_en(reg_en_CTR),
        .wrt(wrt_IO)
);

endmodule
