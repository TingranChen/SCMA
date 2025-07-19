module outputFIFO #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 14,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 4,
    parameter REG_ADDR = 2,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter DATA_IN_CIM_WIDTH = 512,
    parameter DATA_DEPTH = 4,
    parameter DATA_ADDR = 2
)
(
    input CLK,
    input [1:0]RD_EN,
    input WR_EN,
    input rst_n,
    input [63:0]qin,
    output [31:0]RD_DATA,
    output full,
    output empty
);

wire [31:0]RD_DATA_0,RD_DATA_1;
wire full_0,full_1;
wire empty_0,empty_1;
assign full = full_0 | full_1;
assign empty = empty_0 | empty_1;

FIFO_ASYN
#(
    .DATA_WIDTH(32),
    .DATA_DEPTH(DATA_DEPTH),
    .DATA_ADDR(DATA_ADDR)
)
FIFO_0
(
	.CLK_WR(CLK), 
	.RST_WR(rst_n), 
	.WR_EN(WR_EN), 
    .RD_EN(RD_EN[0]),
	.WR_DATA(qin[31:0]),
	.RD_DATA(RD_DATA_0),
	.EMPTY(empty_0),
    .FULL(full_0)
);

FIFO_ASYN
#(
    .DATA_WIDTH(32), 
    .DATA_DEPTH(DATA_DEPTH),	
    .DATA_ADDR(DATA_ADDR)
)
FIFO_1
(
	.CLK_WR(CLK), 
	.RST_WR(rst_n), 
	.WR_EN(WR_EN), 
    .RD_EN(RD_EN[1]),
	.WR_DATA(qin[63:32]),
	.RD_DATA(RD_DATA_1),
	.EMPTY(empty_1),
    .FULL(full_1)
);

assign RD_DATA = ({32{RD_EN[0]}} & RD_DATA_0) | ({32{RD_EN[1]}} & RD_DATA_1);


endmodule
