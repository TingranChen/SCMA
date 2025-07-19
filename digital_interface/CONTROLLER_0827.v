module CONTROLLER #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 14,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 4,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter CHIP_EN_DATA = 4'h0
)
(
input clk,
output clk_b,
input cal_done,
output cal_b,
output col_en,
input rst,
input empty_inputfifo,
input [REG_ADDR-1:0] a_reg,
input [REG_DATA_WIDTH-1:0]d_reg,
output [REG_DATA_WIDTH-1:0]data_cim_in,
input reg_en,
input [63:0] qin,
output [63:0] qout,
output rst_b,
input full_outputfifo,
output WR_EN_outputfifo,
output reg RD_EN_inputfifo
);

assign rst_b = rst;
assign clk_b = clk;

parameter IDLE = 3'b000;
parameter CAL = 3'b001;
parameter ACCESS = 3'b010;
parameter OUT = 3'b011;
parameter STALL = 3'b100;
reg [2:0]state;
reg [2:0]state_tmp;

reg [63:0]reg_cal;
reg [31:0]reg_add_0,reg_add_1,reg_conf_0,reg_conf_1,reg_conf_2,reg_conf_3;
reg [15:0]reg_en_collum;

wire stall_en;
assign stall_en = reg_en & (a_reg[0] | a_reg[1] | a_reg[2] | a_reg[3]);
assign cal_b = (state==CAL);
assign col_en = reg_conf_0[31];
assign WR_EN_outputfifo = (state==OUT);

wire [63:0] access_tmp_0,access_tmp_1;

assign data_cim_in = d_reg;

always @(posedge clk or negedge rst)begin
    if(rst == 1'b0)begin
        RD_EN_inputfifo <= 1'b0;
        state <= IDLE;
        state_tmp <= IDLE;
        reg_cal <= 63'b0;
        reg_add_0 <= 32'b0;
        reg_add_1 <= 32'b0;
        reg_conf_0 <= 32'b0;
        reg_conf_1 <= 32'b0;
        reg_conf_2 <= 32'b0;
        reg_conf_3 <= 32'b0;
        reg_en_collum <= 32'b0;
    end
    if(reg_en)begin
        case (a_reg)
        4'b0101:begin
            reg_add_0 <= d_reg;
        end
        4'b0110:begin
            reg_add_1 <= d_reg;
        end
        4'b0100:begin
            reg_en_collum <= d_reg;
        end
        4'b0111:begin
            reg_conf_0 <= d_reg;
        end
        4'b1000:begin
            reg_conf_1 <= d_reg;
        end
        4'b1001:begin
            reg_conf_2 <= d_reg;
        end
        4'b1010:begin
            reg_conf_3 <= d_reg;
        end
        endcase
    end
end

always @(posedge clk)begin
    case (state)
    IDLE:begin
            if(stall_en)begin
                state <= STALL;
                state_tmp <= state;
            end
            if((!empty_inputfifo) & (!full_outputfifo))begin
                state <= CAL;
                RD_EN_inputfifo <= 1'b1;
            end
        end
    CAL:begin
        RD_EN_inputfifo <= 1'b0;
        reg_cal <= qin;
        if(stall_en)begin
            state <= STALL;
            state_tmp <= state;
        end
        else if(cal_done)
            state <= ACCESS;
        end
    ACCESS:begin
        if(stall_en)begin
            state <= STALL;
            state_tmp <= state;
        end
        else
        state<=OUT;
        end
    OUT:begin
        state <= IDLE;
        end
    STALL:begin
        if(!stall_en)
            state <= state_tmp;
        end
    endcase
end

SIMDshifter SIMDshift_0(
        .shiftinput(reg_cal),
        .conf(reg_conf_0[3:0]),
        .shiftoutput(access_tmp_0)
    );

SIMDadder SIMDadder_0(
        .A(access_tmp_0),
        .B({reg_add_1,reg_add_0}),
        .conf(reg_conf_0[7:4]),
        .Cout(access_tmp_1)
    );

SHIFTER SHIFTER_0(
        .shiftinput(access_tmp_1),
        .conf(reg_conf_0[11:8]),
        .shiftoutput(qout)
    );
endmodule

