module IO #(
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
    parameter CHIP_EN_DATA = 4'h0,
    parameter CIM_COLLUMN = 16
)
(
    input clk,
    input rst,
    input col_en,
    input empty_outputfifo,
    output empty,
    input full_inputfifo,
    output full,
    input [ADDR_IN_WIDTH-1:0]a_in,
    output [REG_ADDR-1:0]a_reg,
    output [ADDR_CIM_IN_WIDTH-1:0] a_cim,
    output [REG_DATA_WIDTH-1:0]d_reg,
    output [DATA_IN_ADDR-1:0]inputfifo_WR_EN,
    output [DATA_OUT_ADDR-1:0]outputfifo_RD_EN,
    input [DATA_IN_WIDTH-1:0]data_in,
    output [DATA_CIM_IN_WIDTH-1:0]data_in_cim,
    output wrt,
    output reg_en,
    input chip_en
    );

    wire wrt_en,inputfifo_wr_en,outputfifo_rd_en;
    wire [3:0]inputfifo_addr;
    assign inputfifo_addr = a_in[3:0];
    assign wrt_en = chip_en & (a_in[10:8]==3'b001);
    assign inputfifo_wr_en = chip_en &((a_in[10:8]==3'b010) | (a_in[10:8]==3'b111));
    assign reg_en = chip_en & (a_in[10:8]==3'b011);
	//assign WR_DATA = {36{inputfifo_wr_en}} & data_in;
    assign a_reg = {32{reg_en}} & a_in[REG_ADDR-1:0];
    assign d_reg = {32{reg_en}} & data_in[REG_DATA_WIDTH-1:0];
    assign inputfifo_WR_EN[0] = inputfifo_wr_en & (inputfifo_addr==4'b0000);
    assign inputfifo_WR_EN[1] = inputfifo_wr_en & (inputfifo_addr==4'b0001);
    assign inputfifo_WR_EN[2] = inputfifo_wr_en & (inputfifo_addr==4'b0010);
    assign inputfifo_WR_EN[3] = inputfifo_wr_en & (inputfifo_addr==4'b0011);
    assign inputfifo_WR_EN[4] = inputfifo_wr_en & (inputfifo_addr==4'b0100);
    assign inputfifo_WR_EN[5] = inputfifo_wr_en & (inputfifo_addr==4'b0101);
    assign inputfifo_WR_EN[6] = inputfifo_wr_en & (inputfifo_addr==4'b0110);
    assign inputfifo_WR_EN[7] = inputfifo_wr_en & (inputfifo_addr==4'b0111);
    assign inputfifo_WR_EN[8] = inputfifo_wr_en & (inputfifo_addr==4'b1000);
    assign inputfifo_WR_EN[9] = inputfifo_wr_en & (inputfifo_addr==4'b1001);
    assign inputfifo_WR_EN[10] = inputfifo_wr_en & (inputfifo_addr==4'b1010);
    assign inputfifo_WR_EN[11] = inputfifo_wr_en & (inputfifo_addr==4'b1011);
    assign inputfifo_WR_EN[12] = inputfifo_wr_en & (inputfifo_addr==4'b1100);
    assign inputfifo_WR_EN[13] = inputfifo_wr_en & (inputfifo_addr==4'b1101);
    assign inputfifo_WR_EN[14] = inputfifo_wr_en & (inputfifo_addr==4'b1110);
    assign inputfifo_WR_EN[15] = inputfifo_wr_en & (inputfifo_addr==4'b1111);

    wire [3:0]outputfifo_addr = a_in[7:4];
    assign outputfifo_rd_en = (a_in[10:8]==3'b100) | (a_in[10:8]==3'b111);
    assign outputfifo_RD_EN[0] = outputfifo_rd_en & (outputfifo_addr==4'b0000);
    assign outputfifo_RD_EN[1] = outputfifo_rd_en & (outputfifo_addr==4'b0001);

    assign wrt = wrt_en & chip_en;
    assign full = full_inputfifo;
    assign empty = empty_outputfifo;
    assign a_cim =  a_in[7:0];
    assign data_in_cim = data_in[31:0];
//	assign data_out = {32{chip_en}} & RD_DATA;
//	assign data_out = RD_DATA;
        
endmodule
