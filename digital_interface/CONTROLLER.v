module CONTROLLER #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32, 
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 11,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 8,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter CHIP_EN_DATA = 4'h0
)
(
input clk,
input cal_done,
output cal_b,
output col_en,
input rst,
input empty_inputfifo,
input [REG_ADDR-1:0] a_reg,
input [REG_DATA_WIDTH-1:0]d_reg,
input reg_en,
output reg_en_b,
input [191:0] qin,
output [63:0] qout,
input full_outputfifo,
output WR_EN_outputfifo,
output reg RD_EN_inputfifo,
output [15:0] sel_array,
input [4:0] matrix_act
);


parameter IDLE = 3'b000;
parameter CAL = 3'b001;
parameter ACCESS = 3'b010;
parameter OUT = 3'b011;
parameter STALL = 3'b100;
reg [2:0]state;
reg [2:0]state_tmp;

//reg [191:0]reg_cal;
reg [31:0]reg_add_0,reg_add_1,reg_conf_0;
wire [63:0]SIMD_in;

wire stall_en;
assign stall_en = reg_en & (a_reg[0] | a_reg[1] | a_reg[2] | a_reg[3]);
assign cal_b = (state==CAL);
assign col_en = reg_conf_0[31];
assign WR_EN_outputfifo = (state==OUT);

wire reg_sel_0 = a_reg==8'b00001000;
wire reg_sel_1 = a_reg==8'b10001000;
assign sel_array[7:0] = {8{(reg_en & reg_sel_0)}};
assign sel_array[15:8] = {8{(reg_en & reg_sel_1)}};
assign reg_en_b = reg_en & (reg_sel_0 | reg_sel_1);

wire [63:0] access_tmp_0,access_tmp_1;

always @(posedge clk or negedge rst)begin
    if(!rst)begin
        reg_add_0 <= 32'b0;
        reg_add_1 <= 32'b0;
        reg_conf_0 <= 32'b0;
    end
    else if(reg_en)begin
        case (a_reg)
        8'b00000010:begin
            reg_add_0 <= d_reg;
        end
        8'b00000011:begin
            reg_add_1 <= d_reg;
        end
        8'b00000100:begin
            reg_conf_0 <= d_reg;
        end
   //     8'b00000101:begin
   //         reg_conf_1 <= d_reg;
   //     end
   //     8'b00000110:begin
   //         reg_conf_2 <= d_reg;
   //     end
   //     8'b00000111:begin
   //         reg_conf_3 <= d_reg;
   //     end
        endcase
    end
    else;
end

always @(posedge clk or negedge rst)begin
    if(!rst)begin
        RD_EN_inputfifo <= 1'b0;
        state <= IDLE;
        state_tmp <= IDLE;
    end
    else begin
        case (state)
        IDLE:begin
            if(stall_en)begin
                state <= STALL;
                state_tmp <= state;
            end
            else if((!empty_inputfifo) & (!full_outputfifo))begin
                state <= CAL;
                RD_EN_inputfifo <= 1'b1;
            end
            else 
		state <= state;
            end
        CAL:begin
            RD_EN_inputfifo <= 1'b0;
            if(stall_en)begin
                state <= STALL;
                state_tmp <= state;
            end
            else if(cal_done)
                state <= ACCESS;
            else 
		state<=state;
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
            else
		state <= state;	
	    end
        endcase
    end
end

quantize dut_quantize(
    .cim_input(qin),
    .cim_output(SIMD_in),
    .col_en(col_en),
    .matrix_act(matrix_act)
);

SIMDshifter SIMDshift_0(
         .shiftinput(SIMD_in),
         .conf(reg_conf_0[3:0]),
         .shiftoutput(access_tmp_0)
     );

SIMDadder SIMDadder_0(
        .A(access_tmp_0),
        .B({reg_add_1,reg_add_0}),
        .conf(reg_conf_0[7:4]),
        .Cout(qout)
);

endmodule

