module inputFIFO#(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 14,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 4,
    parameter REG_ADDR = 8,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter DATA_IN_CIM_WIDTH = 512    
)
(
    input CLK,
    input RD_EN,
    input [DATA_IN_ADDR-1:0]WR_EN,
    input col_en,
    input rst_n,
    input [DATA_IN_WIDTH-1:0]din,
    input [REG_ADDR-1:0]a_reg,
    input [REG_DATA_WIDTH-1:0] d_reg,
    output [DATA_IN_CIM_WIDTH-1:0]RD_DATA,
    output full,
    output empty,
    input reg_en,
    output [4:0]matrix_act
);

//wire wr_en_0 = |WR_EN[DATA_IN_ADDR/2-1:0];
//wire wr_en_1 = |WR_EN[DATA_IN_ADDR-1:DATA_IN_ADDR/2];
//wire wr_en = | WR_EN[DATA_IN_ADDR-1:0];
reg [REG_DATA_WIDTH/2-1:0] reg_en_row;
wire [DATA_IN_CIM_WIDTH/32-1:0]full_flag;
wire [7:0]reg_en_row_flag = {reg_en_row[14],reg_en_row[12],reg_en_row[10],reg_en_row[8],reg_en_row[6],reg_en_row[4],reg_en_row[2],reg_en_row[0]};
assign full = col_en?(( reg_en_row_flag & {full_flag[14],full_flag[12],full_flag[10],full_flag[8],full_flag[6],full_flag[4],full_flag[2],full_flag[0]}) == reg_en_row_flag[7:0])  
                          :((reg_en_row[15:0]&full_flag)==reg_en_row[15:0]);

wire [DATA_IN_CIM_WIDTH/32-1:0]empty_flag;
assign empty = col_en?(!(( reg_en_row_flag &(~{empty_flag[14],empty_flag[12],empty_flag[10],empty_flag[8],empty_flag[6],empty_flag[4],empty_flag[2],empty_flag[0]})) == reg_en_row_flag[7:0])) 
                          :(!((reg_en_row[15:0]&(~empty_flag))==reg_en_row[15:0]));

wire [DATA_IN_CIM_WIDTH/32-1:0]RD_EN_flag = {16{RD_EN}} & reg_en_row;

//wire [DATA_IN_WIDTH-1:0]din_n = {DATA_IN_WIDTH{1'b1}} & din;
//wire [DATA_IN_WIDTH-1:0]din_0 = {DATA_IN_WIDTH{wr_en_0}} & din;
//wire [DATA_IN_WIDTH-1:0]din_1 = {DATA_IN_WIDTH{wr_en_1}} & din;
wire [DATA_IN_WIDTH-1:0]din_0 = din;
wire [DATA_IN_WIDTH-1:0]din_1 = din;

wire d_reg_avd = | d_reg;

always @(posedge CLK or negedge rst_n)begin
    if(!rst_n) begin
        reg_en_row <= 16'hFFFF;
    end
    else if(reg_en && a_reg==8'b00000001) begin
        if(!(d_reg[REG_DATA_WIDTH/2-1:0] == 16'b0))
            reg_en_row <= d_reg[REG_DATA_WIDTH/2-1:0];
        else;
    end
    else;
end

assign matrix_act = reg_en_row[0] + reg_en_row[1] + reg_en_row[2] + reg_en_row[3] + reg_en_row[4] + reg_en_row[5] + 
                    reg_en_row[6] + reg_en_row[7] + reg_en_row[8] + reg_en_row[9] + reg_en_row[10] + reg_en_row[11] + 
                    reg_en_row[12] + reg_en_row[13] + reg_en_row[14] + reg_en_row[15];

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_0(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[1:0]),
    .col_en(col_en),
    .WR_EN(WR_EN[1:0]),
    .rst_n(rst_n),
    .din(din_0),
    .RD_DATA(RD_DATA[63:0]),
    .full(full_flag[1:0]),
    .empty(empty_flag[1:0]),
    .reg_en_flag(reg_en_row[1:0])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_1(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[3:2]),
    .col_en(col_en),
    .WR_EN(WR_EN[3:2]),
    .rst_n(rst_n),
    .din(din_0),
    .RD_DATA(RD_DATA[127:64]),
    .full(full_flag[3:2]),
    .empty(empty_flag[3:2]),
    .reg_en_flag(reg_en_row[3:2])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_2(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[5:4]),
    .col_en(col_en),
    .WR_EN(WR_EN[5:4]),
    .rst_n(rst_n),
    .din(din_0),
    .RD_DATA(RD_DATA[191:128]),
    .full(full_flag[5:4]),
    .empty(empty_flag[5:4]),
    .reg_en_flag(reg_en_row[5:4])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_3(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[7:6]),
    .col_en(col_en),
    .WR_EN(WR_EN[7:6]),
    .rst_n(rst_n),
    .din(din_0),
    .RD_DATA(RD_DATA[255:192]),
    .full(full_flag[7:6]),
    .empty(empty_flag[7:6]),
    .reg_en_flag(reg_en_row[7:6])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_4(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[9:8]),
    .col_en(col_en),
    .WR_EN(WR_EN[9:8]),
    .rst_n(rst_n),
    .din(din_1),
    .RD_DATA(RD_DATA[319:256]),
    .full(full_flag[9:8]),
    .empty(empty_flag[9:8]),
    .reg_en_flag(reg_en_row[9:8])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_5(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[11:10]),
    .col_en(col_en),
    .WR_EN(WR_EN[11:10]),
    .rst_n(rst_n),
    .din(din_1),
    .RD_DATA(RD_DATA[383:320]),
    .full(full_flag[11:10]),
    .empty(empty_flag[11:10]),
    .reg_en_flag(reg_en_row[11:10])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_6(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[13:12]),
    .col_en(col_en),
    .WR_EN(WR_EN[13:12]),
    .rst_n(rst_n),
    .din(din_1),
    .RD_DATA(RD_DATA[447:384]),
    .full(full_flag[13:12]),
    .empty(empty_flag[13:12]),
    .reg_en_flag(reg_en_row[13:12])
);

inputFIFO_unit #(
    .DATA_IN_WIDTH(DATA_IN_WIDTH),
    .ADDR_IN_WIDTH(ADDR_IN_WIDTH),
    .REG_DATA_WIDTH(REG_DATA_WIDTH),
    .REG_DEPTH(REG_DEPTH),
    .REG_ADDR(REG_ADDR),
    .DATA_IN_ADDR(DATA_IN_ADDR),
    .DATA_OUT_ADDR(DATA_OUT_ADDR),
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
unit_7(
    .CLK_WR(CLK),
    .RD_EN(RD_EN_flag[15:14]),
    .col_en(col_en),
    .WR_EN(WR_EN[15:14]),
    .rst_n(rst_n),
    .din(din_1),
    .RD_DATA(RD_DATA[511:448]),
    .full(full_flag[15:14]),
    .empty(empty_flag[15:14]),
    .reg_en_flag(reg_en_row[15:14])
);

endmodule
