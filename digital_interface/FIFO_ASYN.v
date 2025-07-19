`timescale 1ns/1ps
module FIFO_ASYN
#(
	parameter DATA_WIDTH = 32,
	parameter DATA_DEPTH = 4,
	parameter DATA_ADDR  = 2
)
(
	input CLK_WR,
	input RST_WR,
	input WR_EN, RD_EN,
	input [DATA_WIDTH-1:0] WR_DATA,
	output [DATA_WIDTH-1:0] RD_DATA,
	output EMPTY,FULL
);

/////////////////////////////////////
//
// OUTPUT CONNECTION
//
/////////////////////////////////////
reg [DATA_WIDTH-1:0] data_out;
//reg empty_out,full_out;
wire empty_out,full_out;
assign RD_DATA = data_out;
assign EMPTY = empty_out;
assign FULL = full_out;

/////////////////////////////////////
//
// REG OPERATION & DATA_ADDR OPERATION
//
/////////////////////////////////////
reg [DATA_WIDTH-1:0] reg_fifo [DATA_DEPTH-1:0];
reg [DATA_ADDR:0] WR_ADDR,RD_ADDR;  //Additional MSB for judging full
integer i;

always @ (posedge CLK_WR or negedge RST_WR)
begin
	if(!RST_WR) begin
		for(i=0;i<DATA_DEPTH;i=i+1)
			reg_fifo[i] <= 0;
        WR_ADDR <= 0;
		RD_ADDR <= 0;
		data_out <= 0;
	end
	else begin
		if(!full_out && WR_EN) begin
			reg_fifo[WR_ADDR[DATA_ADDR-1 : 0]] <= WR_DATA;
			WR_ADDR <= WR_ADDR + 1;
		end
		else begin
			WR_ADDR<=WR_ADDR;
		end

		if(!empty_out && RD_EN) begin
			data_out <= reg_fifo[RD_ADDR[DATA_ADDR-1 : 0]];
			RD_ADDR <= RD_ADDR + 1;
		end
		else begin
			RD_ADDR <= RD_ADDR;
		end
	end
end

/*
always @ (posedge CLK_RD or negedge RST_RD)
begin
	if(!RST_RD) begin
//		data_out <= 0;
        RD_ADDR <= 0;
		data_out <= 0;
	end
	else if(!empty_out && RD_EN) begin
		data_out <= reg_fifo[RD_ADDR[DATA_ADDR-1 : 0]];
		RD_ADDR <= RD_ADDR + 1;
	end
	else
		RD_ADDR <= RD_ADDR;
end
*/

/////////////////////////////////////
//
// BIN TO GRAY
//
/////////////////////////////////////
wire [DATA_ADDR:0] WR_ADDR_GRAY,RD_ADDR_GRAY;
assign WR_ADDR_GRAY = (WR_ADDR >> 1) ^ WR_ADDR;
assign RD_ADDR_GRAY = (RD_ADDR >> 1) ^ RD_ADDR;

/////////////////////////////////////
//
// TWO-STAGE SYNC
//
/////////////////////////////////////
reg [DATA_ADDR:0] WR_ADDR_GRAY_SYNC,RD_ADDR_GRAY_SYNC;
reg [DATA_ADDR:0] WR_ADDR_GRAY_SYNC_R,RD_ADDR_GRAY_SYNC_R;

always @ (posedge CLK_WR or negedge RST_WR)
begin
	if(!RST_WR) begin
		RD_ADDR_GRAY_SYNC   <= 0;
//		  RD_ADDR_GRAY_SYNC_R <= 0;
        WR_ADDR_GRAY_SYNC   <= 0;
//	      WR_ADDR_GRAY_SYNC_R <= 0;
	end
	else begin
		RD_ADDR_GRAY_SYNC   <= RD_ADDR_GRAY;
//        RD_ADDR_GRAY_SYNC_R <= RD_ADDR_GRAY_SYNC;
		WR_ADDR_GRAY_SYNC   <= WR_ADDR_GRAY;
//		  WR_ADDR_GRAY_SYNC_R <= WR_ADDR_GRAY_SYNC;
	end
end

/*
always @ (posedge CLK_RD or negedge RST_RD)
begin
	if(!RST_RD) begin
		WR_ADDR_GRAY_SYNC   <= 0;
//	    WR_ADDR_GRAY_SYNC_R <= 0;
	end
	else begin
		WR_ADDR_GRAY_SYNC   <= WR_ADDR_GRAY;
//		WR_ADDR_GRAY_SYNC_R <= WR_ADDR_GRAY_SYNC;
	end
end
*/

/////////////////////////////////////
//
// JUDGE
//
/////////////////////////////////////

assign empty_out = (RD_ADDR_GRAY[DATA_ADDR : 0] == WR_ADDR_GRAY_SYNC[DATA_ADDR : 0])? 1:0;
assign full_out = (WR_ADDR_GRAY[DATA_ADDR : 0] == {~RD_ADDR_GRAY_SYNC[DATA_ADDR : DATA_ADDR-1] , RD_ADDR_GRAY_SYNC[DATA_ADDR-2:0]})? 1:0;

/*
//Write-clock judges full signal
always @ (posedge CLK_WR or negedge RST_WR)
begin
	if(!RST_WR)
		full_out <= 0;
	else if((WR_ADDR_GRAY[DATA_ADDR] != RD_ADDR_GRAY_SYNC[DATA_ADDR]) && (WR_ADDR_GRAY[DATA_ADDR - 1] != RD_ADDR_GRAY_SYNC[DATA_ADDR - 1]) && (WR_ADDR_GRAY[DATA_ADDR-2 : 0] == RD_ADDR_GRAY_SYNC[DATA_ADDR-2 : 0]))
		full_out <= 1;
	else
		full_out <= 0;
end

//Read-clock judges empty signal
always @ (posedge CLK_RD or negedge RST_RD)
begin
    if(!RST_RD)
		empty_out <= 0;
	else if(RD_ADDR_GRAY[DATA_ADDR : 0] == WR_ADDR_GRAY_SYNC[DATA_ADDR : 0])
		empty_out <= 1;
	else
		empty_out <= 0;
end
*/
endmodule
