module inputFIFO_unit#(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 14,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 4,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter CHIP_EN_DATA = 4'h0,
    parameter DATA_WIDTH=32,
    parameter DATA_DEPTH=4,
    parameter DATA_ADDR=2
)
(
    input CLK_WR,
    input [1:0]RD_EN,
    input col_en,
    input [1:0]WR_EN,
    input rst_n,
    input [35:0]din,
    output [63:0]RD_DATA,
    output [1:0]full,
    output [1:0]empty,
    input [1:0]reg_en_flag
);

wire full_0,full_1;
wire empty_0,empty_1;
assign full[0] = full_0;
assign full[1] = full_1;
assign empty[0] = empty_0;
assign empty[1] = empty_1;
wire wr_en = WR_EN[0] | WR_EN[1];
//wire [DATA_IN_WIDTH-1:0]din_n = {DATA_IN_WIDTH{wr_en}} & din;
wire [DATA_IN_WIDTH-1:0]din_n = din;
wire [31:0]WR_DATA_FIFO_1 = ({32{col_en}} & {28'b0,din_n[35:32]}) | ({32{!col_en}} & din_n[31:0]);
wire [31:0]WR_DATA_FIFO_0 = din_n[31:0];
wire WR_EN_FIFO_1 = col_en?WR_EN[0]:WR_EN[1];
wire RD_EN_FIFO_1 = col_en?RD_EN[0]:RD_EN[1];
wire REG_EN_FIFO_1 = col_en?reg_en_flag[0]:reg_en_flag[1];

wire [63:0] RD_DATA_tmp;
assign RD_DATA[31:0] = {32{reg_en_flag[0]}} & RD_DATA_tmp[31:0];
assign RD_DATA[63:32] = {32{REG_EN_FIFO_1}} & RD_DATA_tmp[63:32];


FIFO_ASYN
#(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_DEPTH(DATA_DEPTH),
    .DATA_ADDR(DATA_ADDR)
)
FIFO_0
(
	.CLK_WR(CLK_WR), 
	.RST_WR(rst_n), 
	.WR_EN(WR_EN[0]), 
    .RD_EN(RD_EN[0]),
	.WR_DATA(WR_DATA_FIFO_0),
	.RD_DATA(RD_DATA_tmp[31:0]),
	.EMPTY(empty_0),
    .FULL(full_0)
);


FIFO_ASYN
#(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_DEPTH(DATA_DEPTH),
    .DATA_ADDR(DATA_ADDR)
)
FIFO_1
(
	.CLK_WR(CLK_WR), 
	.RST_WR(rst_n), 
	.WR_EN(WR_EN_FIFO_1), 
    .RD_EN(RD_EN_FIFO_1),
	.WR_DATA(WR_DATA_FIFO_1),
	.RD_DATA(RD_DATA_tmp[63:32]),
	.EMPTY(empty_1),
    .FULL(full_1)
);

endmodule
