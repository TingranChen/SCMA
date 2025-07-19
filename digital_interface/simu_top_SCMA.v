`timescale 1ns / 1ns

module simu_top ();
    parameter DATA_IN_WIDTH = 36;
    parameter DATA_OUT_WIDTH = 32;
    parameter DATA_IN_ADDR = 16;
    parameter DATA_OUT_ADDR = 2;
    parameter ADDR_IN_WIDTH = 27;
    parameter REG_DATA_WIDTH = 32;
    parameter REG_DEPTH = 16;
    parameter REG_ADDR = 8;
    parameter ADDR_CIM_IN_WIDTH = 8;
    parameter DATA_CIM_IN_WIDTH = 32;
    parameter CIM_ROW = 128;
    parameter CHIP_EN_DATA_0 = 16'd1;
    parameter CHIP_EN_DATA_1 = 16'd2;
    parameter CHIP_EN_DATA_2 = 16'd4;
    parameter CHIP_EN_DATA_3 = 16'd8;
    parameter CHIP_EN_DATA_4 = 16'd16;
    parameter CHIP_EN_DATA_5 = 16'd32;
    parameter CHIP_EN_DATA_6 = 16'd64;
    parameter CHIP_EN_DATA_7 = 16'd128;
    parameter CHIP_EN_DATA_8 = 16'd256;
    parameter CHIP_EN_DATA_9 = 16'd512;
    parameter CHIP_EN_DATA_10 = 16'd1024;
    parameter CHIP_EN_DATA_11 = 16'd2048;
    parameter CHIP_EN_DATA_12 = 16'd4096;
    parameter CHIP_EN_DATA_13 = 16'd8192;
    parameter CHIP_EN_DATA_14 = 16'd16384;
    parameter CHIP_EN_DATA_15 = 16'd32768;
    parameter CHIP_EN_NUM = 16;


    reg clk;
    reg rst;
    reg [ADDR_IN_WIDTH-1:0]a_in;
    reg [DATA_IN_WIDTH-1:0]data_in;
    wire [DATA_OUT_WIDTH-1:0] data_out;
wire empty;
wire full;

SCMA_wrapper #(
    .CHIP_EN_NUM(16)
)
dut_SCMA(
	.empty(empty),
	.full(full),
    .clk(clk),
    .rst(rst),
    .a_in(a_in),
    .data_in(data_in),
    .data_out(data_out)
);
//
//task define
    real    CLK_PEROID = 40;
    real    HIGH_RATE = 0.4;
    task test_write_input;
        input [DATA_IN_ADDR/4-1:0] I_addr;
        input [DATA_IN_WIDTH-1:0] I_data;
        input [CHIP_EN_NUM-1:0] chip_en;
        begin
            a_in = {chip_en,7'b0100000,I_addr};
            data_in = I_data;
            #(CLK_PEROID);
            a_in = {chip_en,11'b0};
        end
    endtask

    task test_write_reg;
        input [REG_ADDR-1:0] R_addr;
        input [DATA_IN_WIDTH-1:0] R_data;
        input [CHIP_EN_NUM-1:0] chip_en;
        begin
            a_in = {chip_en,3'b011,R_addr};
            data_in = R_data;
            #(CLK_PEROID);
            a_in = {11'b0};
        end
    endtask

    task test_FIFO;
        input [35:0]test_data;    
        input [15:0]chip_en;    
        begin       
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000001,chip_en);
            test_write_reg(8'b00000100,32'h00000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data+1,chip_en);
            test_write_input(9'd0,test_data+2,chip_en);
            test_write_input(9'd0,test_data+3,chip_en);
            test_write_input(9'd0,test_data+4,chip_en);
            test_write_input(9'd0,test_data+5,chip_en);
            test_write_input(9'd0,test_data+6,chip_en);
            test_write_input(9'd0,test_data+7,chip_en);
            test_write_input(9'd0,test_data+8,chip_en);
            test_write_input(9'd0,test_data+9,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd0,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
        end
    endtask

    // task test_sel_array;
    //     input sel_en;
    //     input [31:0] sel_collum_data;
    //     input [CHIP_EN_NUM-1:0] chip_en;
    //     begin
    //         a_in = {chip_en, 3'b011,sel_en,7'b0001000};
    //         data_in = sel_collum_data;
    //         #(CLK_PEROID);
    //         a_in = {chip_en,11'b0};
    //     end
    // endtask

    // task test_sel_array_en;
    //     input [15:0] sel_collum_en;
    //     input [CHIP_EN_NUM-1:0] chip_en;
    //     begin
    //         a_in = {chip_en, 11'b01100001111};
    //         data_in = {chip_en,16'b0,sel_collum_en};
    //         #(CLK_PEROID);
    //         a_in = {chip_en,11'b0};
    //     end
    // endtask

    task test_write_array;
        input [ADDR_CIM_IN_WIDTH-1:0] A_addr;
        input [DATA_OUT_WIDTH-1:0] A_data;
        input [CHIP_EN_NUM-1:0] chip_en;
        begin
            a_in = {chip_en, 3'b001,A_addr};
            data_in = ~A_data;
            #(CLK_PEROID);
            a_in = {chip_en,11'b0};
        end
    endtask


    task test_read_output;
        input [DATA_IN_ADDR/4-1:0]O_addr;
        reg [DATA_OUT_WIDTH-1:0]O_data;
        input [CHIP_EN_NUM-1:0] chip_en;
        begin
            a_in = {chip_en,3'b100,O_addr,4'b0000};
	    #(CLK_PEROID);
            O_data = data_out;
            $display("cALCULATION Result %d is %h",O_addr,O_data);
            a_in = {11'b0};
        end
    endtask


    task test_write_and_read;
        input [DATA_IN_ADDR/4-1:0]I_addr;
        input [DATA_IN_ADDR/4-1:0]O_addr;
        input [DATA_IN_WIDTH-1:0]I_data;
        reg [DATA_OUT_WIDTH-1:0]O_data;
        input [CHIP_EN_NUM-1:0] chip_en;
        begin
            a_in = {chip_en, 3'b111,O_addr,I_addr};
            O_data = data_out;
            data_in = I_data;
            $display("cALCULATION Result %d is %h",O_addr,O_data);
            #(CLK_PEROID);
            a_in = {chip_en,11'b0};
        end
    endtask

    task test_array_sel;
        input [3:0]chip_en;    
        begin       
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000001,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            test_write_reg(8'b00001000,32'h00000000,chip_en);
            test_write_input(9'd0,36'hFFFFFFFFF,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);

            
            test_write_reg(8'b00000001,32'h00000001,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            test_write_reg(8'b00001000,32'h11111111,chip_en);
            test_write_input(9'd0,36'hFFFFFFFFF,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);

            
            test_write_reg(8'b00000001,32'h00000004,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            test_write_reg(8'b00001000,32'h11111111,chip_en);
            // test_write_input(9'd0,36'hFFFFFFFFF,chip_en);
            test_write_input(9'd2,36'hFFFFFFFFF,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
        end
    endtask

    task test_input_cal_col;
        input [35:0]test_data;
        input [3:0]chip_en;    
        begin       
            test_write_reg(8'b00001000,32'h01234567,chip_en);
            test_write_reg(8'b10001000,32'h01234567,chip_en);
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000001,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);

            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000004,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);

            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000010,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000040,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000100,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000400,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00001000,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00004000,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            // test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
        end
    endtask

    task test_input_cal_col_2;
        input [35:0]test_data;
        input [3:0]chip_en;    
        begin       
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000FFFF,chip_en);
            test_write_reg(8'b00000100,32'b10000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            test_write_input(9'd14,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
        end
    endtask


    task test_input_cal_matrix;
        input [35:0]test_data;
        input [3:0]chip_en;
        begin
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000001,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            // test_write_input(9'd1,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd3,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000003,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            // test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd3,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000007,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            // test_write_input(9'd3,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000000F,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            // test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000001F,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            // test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000003F,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            // test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000007F,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            // test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h000000FF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            // test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h000001FF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            // test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h000003FF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            // test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h000007FF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            // test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00000FFF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd11,test_data,chip_en);
            // test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00001FFF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd11,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            // test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00003FFF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd11,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            test_write_input(9'd13,test_data,chip_en);
            // test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h00007FFF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd11,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            test_write_input(9'd13,test_data,chip_en);
            test_write_input(9'd14,test_data,chip_en);
            // test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            
            //writeBuffer
            #(CLK_PEROID*4);
            test_write_reg(8'b00000001,32'h0000FFFF,chip_en);
            test_write_reg(8'b00000100,32'b00000000000000000000000000000000,chip_en); 
            test_write_input(9'd0,test_data,chip_en);
            test_write_input(9'd1,test_data,chip_en);
            test_write_input(9'd2,test_data,chip_en);
            test_write_input(9'd3,test_data,chip_en);
            test_write_input(9'd4,test_data,chip_en);
            test_write_input(9'd5,test_data,chip_en);
            test_write_input(9'd6,test_data,chip_en);
            test_write_input(9'd7,test_data,chip_en);
            test_write_input(9'd8,test_data,chip_en);
            test_write_input(9'd9,test_data,chip_en);
            test_write_input(9'd10,test_data,chip_en);
            test_write_input(9'd11,test_data,chip_en);
            test_write_input(9'd12,test_data,chip_en);
            test_write_input(9'd13,test_data,chip_en);
            test_write_input(9'd14,test_data,chip_en);
            test_write_input(9'd15,test_data,chip_en);
            # (CLK_PEROID *31);
            test_read_output(4'd0,chip_en);
            test_read_output(4'd1,chip_en);
            /////////////////////////////
        end
    endtask
//

    always begin
        clk = 1 ; #(CLK_PEROID*0.5) ;
        clk = 0 ; #(CLK_PEROID*0.5) ;
    end
    

    integer x;
    
    initial begin
        # (CLK_PEROID *0.4);
        a_in = 0;
        data_in = 0;
        rst = 0;
		$fsdbDumpfile("vcs_simutop.fsdb");
		$fsdbDumpvars;
        $fsdbDumpMDA();
    //writeArray
        #(CLK_PEROID*4);
        rst = 1;

        for(x=0;x<128;x=x+1) 
        begin
            test_write_array(x,32'h000000E4,CHIP_EN_DATA_0);
        end

    test_FIFO(36'h00000FFEF,CHIP_EN_DATA_0);
    # (CLK_PEROID*40);

    //   test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_0);
    //# (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_0);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_0);
    # (CLK_PEROID*20);

    test_input_cal_col(36'hFFFFFFFFF,CHIP_EN_DATA_0);
    # (CLK_PEROID*20);


    test_FIFO(36'h00000FFFF,CHIP_EN_DATA_1);
    # (CLK_PEROID*40);

       test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_1);
    # (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_1);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_1);
    # (CLK_PEROID*20);

    test_input_cal_col(36'hFFFFFFFFF,CHIP_EN_DATA_1);



    test_FIFO(36'h00000FFFF,CHIP_EN_DATA_9);
    # (CLK_PEROID*40);

       test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_2);
    # (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_3);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_4);
    # (CLK_PEROID*20);


    test_FIFO(36'h00000FFFF,CHIP_EN_DATA_5);
    # (CLK_PEROID*40);

       test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_6);
    # (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_7);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_8);

    test_FIFO(36'h00000FFFF,CHIP_EN_DATA_9);
    # (CLK_PEROID*40);

       test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_10);
    # (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_11);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_12);


       test_FIFO(36'h0000FFFFF,CHIP_EN_DATA_13);
    # (CLK_PEROID*20);

       test_FIFO(36'h000FFFFFF,CHIP_EN_DATA_14);
    # (CLK_PEROID*20);


       test_FIFO(36'h00FFFFFFF,CHIP_EN_DATA_15);

    test_input_cal_col(36'hFFFFFFFFF,CHIP_EN_DATA_5);
    # (CLK_PEROID*20);


    # (CLK_PEROID*20);

    test_input_cal_col(36'hFFFFFFFFF,CHIP_EN_DATA_1);
    # (CLK_PEROID*20);

    test_input_cal_col_2(36'hFFFFFFFFF,CHIP_EN_DATA_0);
    # (CLK_PEROID*20);
    
    // test_input_cal_col(36'hFFFFFFFFF,CHIP_EN_DATA_1);
    // # (CLK_PEROID*50);
    
    test_input_cal_matrix(36'hFFFFFFFF,CHIP_EN_DATA_0);
    # (CLK_PEROID*20);
    
    // test_input_cal_matrix(36'hFFFFFFFF,CHIP_EN_DATA_1);
        
    /////////////////////////////


        // test_write_input(9'd0,36'hEEEEEEEEE);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
    
        // test_write_input(9'd0,36'hDDDDDDDDD);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'hCCCCCCCCC);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        // test_write_input(9'd0,36'hBBBBBBBBB);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'hAAAAAAAAA);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h999999999);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h888888888);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h777777777);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h666666666);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h555555555);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h444444444);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h333333333);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h222222222);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h111111111);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(9'd0,36'h000000000);
        // # (CLK_PEROID *31);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

    //test simd shifter        
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(8'b00000100,32'h00000009);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(8'b00000100,32'h0000000a);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(8'b00000100,32'h00000007);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
    //
    //test simd add
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(8'b00000100,32'h00000080);
        // test_write_reg(4'd5,32'h11111111);
        // test_write_reg(4'd6,32'h11111111);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        // //add result out of 4bits range 
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(8'b00000100,32'h00000080);
        // test_write_reg(4'd5,32'h11111111);
        // test_write_reg(4'd6,32'h11111111);
        // data_in_cim = 64'hffffffffffffffff;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

    //     //minus
    //     test_write_input(4'd0,36'h0F0F0F0F0);
    //     test_write_reg(8'b00000100,32'h000000c0);
    //     test_write_reg(4'd5,32'h11111111);
    //     test_write_reg(4'd6,32'h11111111);
    //     // data_in_cim = 64'h7777777777777777;
    //     # (CLK_PEROID *31);
    //     test_read_output(4'd0);
    //     test_read_output(4'd1);

    //     //minus result out of 4bits range
    //     test_write_input(4'd0,36'h0F0F0F0F0);
    //     test_write_reg(8'b00000100,32'h000000c0);
    //     test_write_reg(4'd5,32'h88888888);
    //     test_write_reg(4'd6,32'h88888888);
    //     // data_in_cim = 64'h7777777777777777;
    //     # (CLK_PEROID *31);
    //     test_read_output(4'd0);
    //     test_read_output(4'd1);
    // //
    // //test mux
    //     //shift 4
    //     test_write_input(4'd0,36'h0F0F0F0F0);
    //     test_write_reg(8'b00000100,32'h00000400);
    //     // data_in_cim = 64'h7777777777777777;
    //     # (CLK_PEROID *31);
    //     test_read_output(4'd0);
    //     test_read_output(4'd1);

    //     //shift 15
    //     test_write_input(4'd0,36'h0F0F0F0F0);
    //     test_write_reg(8'b00000100,32'h00000F00);
    //     // data_in_cim = 64'h7777777777777777;
    //     # (CLK_PEROID *30);
    //     test_read_output(4'd0);
    //     test_read_output(4'd1);
    //
        $finish(10);
    end
endmodule
