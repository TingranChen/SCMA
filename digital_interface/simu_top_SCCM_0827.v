`timescale 1ns / 1ns

module simu_top();
    parameter DATA_IN_WIDTH = 36;
    parameter DATA_OUT_WIDTH = 32;
    parameter DATA_IN_ADDR = 16;
    parameter DATA_OUT_ADDR = 2;
    parameter ADDR_IN_WIDTH = 15;
    parameter REG_DATA_WIDTH = 32;
    parameter REG_DEPTH = 16;
    parameter REG_ADDR = 4;
    parameter ADDR_CIM_IN_WIDTH = 8;
    parameter DATA_CIM_IN_WIDTH = 32;
    parameter CIM_ROW = 128;

    reg clk;
    wire clk_IO_b,clk_SM_b,clkm_IO_b,clkm_SM_b,clk_CTR_b;
    reg rst;
    wire rst_IO_b_inputfifo,rst_IO_b_SM,rst_SM_b_outputfifo,rst_SM_b_control,rst_CTR_b;

    wire col_en_CTR,col_en_IO_b,col_en_SM_b;

    wire empty,empty_inputfifo,empty_inputfifo_IO_b,empty_inputfifo_SM_b,empty_outputfifo,empty_outputfifo_SM_b;

    wire full,full_outputfifo,full_outputfifo_SM_b,full_inputfifo;

    reg [ADDR_IN_WIDTH-1:0]a_in;
    wire [ADDR_CIM_IN_WIDTH-1:0]a_cim_IO;
    wire [REG_ADDR-1:0]a_reg_IO,a_reg_SM_b;

    reg [DATA_IN_WIDTH-1:0]data_in;
    //for test without SRAM_CIM2
    wire [63:0]data_in_cim;
    wire [DATA_CIM_IN_WIDTH-1:0]data_in_cim_IO,data_cim_in_CTR;
    //
    wire [DATA_OUT_WIDTH-1:0] data_out;
    wire [REG_DATA_WIDTH-1:0]d_reg_IO,d_reg_SM_b;
    wire [DATA_IN_WIDTH-1:0]WR_DATA_IO_b;
    wire [DATA_OUT_WIDTH-1:0]WR_DATA_CTR;
    wire [DATA_OUT_WIDTH-1:0]RD_DATA_SM_b,RD_DATA_outputfifo;
    wire [CIM_ROW*4-1:0]RD_DATA_inputfifo;

    wire RD_EN_inputfifo_CTR,RD_EN_inputfifo_SM_b,RD_EN_inputfifo_IO_b;
    wire [DATA_IN_ADDR-1:0]WR_EN_inputfifo_IO;
    wire WR_EN_outputfifo_CTR;
    wire [DATA_OUT_ADDR-1:0]RD_EN_outputfifo_IO_b,RD_EN_outputfifo_SM_b;

    wire wrt_IO,reg_en_IO,reg_en_inputfifo,reg_en_SM_b;
    
    wire cal_CTR_b;
    wire comp_SM,model_SM,wait_SM,inbit_SM,set_SM,cal_done_SM;

    wire [REG_DATA_WIDTH/2-1:0] reg_en_row_inputfifo;

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
    .clk_b(clk_IO_b),
    .clkm_b(clkm_IO_b),
    .rst(rst),
    .rst_IO_b_SM(rst_IO_b_SM),
    .rst_IO_b_inputfifo(rst_IO_b_inputfifo),
    .col_en(col_en_SM_b),
    .col_en_b(col_en_IO_b),
    .empty(empty),
    .empty_outputfifo(empty_outputfifo_SM_b),
    .empty_inputfifo(empty_inputfifo),
    .empty_inputfifo_b(empty_inputfifo_IO_b),
    .full_inputfifo(full_inputfifo),
    .full(full),
    .a_in(a_in),
    .a_cim(a_cim_IO),
    .a_reg(a_reg_IO_b),
    .d_reg(d_reg_IO),
    .inputfifo_RD_EN(RD_EN_inputfifo_SM_b),
    .inputfifo_RD_EN_b(RD_EN_inputfifo_IO_b),
    .inputfifo_WR_EN(WR_EN_inputfifo_IO),
    .outputfifo_RD_EN(RD_EN_outputfifo_IO_b),
    .data_in(data_in),
    .WR_DATA(WR_DATA_IO_b),
    .RD_DATA(RD_DATA_SM_b),
    .data_out(data_out),
    .wrt(wrt_IO),
    .reg_en(reg_en_IO),
    .reg_en_inputfifo(reg_en_inputfifo)
    );

inputFIFO #(
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
dut_inputFIFO(
    .CLK_WR(clk_IO_b),
    .CLK_RD(clk_IO_b),
    .RD_EN(RD_EN_inputfifo_IO_b),
    .WR_EN(WR_EN_inputfifo_IO),
    .col_en(col_en_IO_b),
    .rst_n(rst_IO_b_inputfifo),
    .din(WR_DATA_IO_b),
    .a_reg(a_reg_IO_b),
    .RD_DATA(RD_DATA_inputfifo),
    .full(full_inputfifo),
    .empty(empty_inputfifo),
    .reg_en_row(reg_en_row_inputfifo),
    .reg_en(reg_en_inputfifo)
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
    .clk(clk_IO_b),
    .clk_b(clk_SM_b),
    .clkm(clkm_IO_b),
    .clkm_b(clkm_SM_b),
    .cal_b(cal_CTR_b),
    .comp(comp_SM),
    .model(model_SM),
    .wait_(wait_SM),
    .inbit(inbit_SM),
    .set(set_SM),
    .cal_done(cal_done_SM),

    .col_en(col_en_CTR),
    .col_en_b(col_en_SM_b),
    .rst(rst_IO_b_SM),
    .rst_outputfifo(rst_SM_b_outputfifo),
    .rst_control(rst_SM_b_control),
    .empty_outputfifo(empty_outputfifo),
    .empty_outputfifo_b(empty_outputfifo_SM_b),
    .RD_DATA(RD_DATA_outputfifo),
    .RD_DATA_b(RD_DATA_SM_b),
    .outputfifo_RD_EN(outputfifo_RD_EN_IO_b),
    .outputfifo_RD_EN_b(outputfifo_RD_EN_SM_b),
    .empty_inputfifo(empty_inputfifo_IO_b),
    .empty_inputfifo_b(empty_inputfifo_SM_b),
    .RD_EN_inputfifo(RD_EN_inputfifo_CTR),
    .RD_EN_inputfifo_b(RD_EN_inputfifo_SM_b),
    .RD_EN_outputfifo(RD_EN_outputfifo_IO_b),
    .RD_EN_outputfifo_b(RD_EN_outputfifo_SM_b),
    .a_reg(a_reg_IO),
    .a_reg_b(a_reg_SM_b),
    .d_reg(d_reg_IO),
    .d_reg_b(d_reg_SM_b),
    .reg_en(reg_en_IO),
    .reg_en_b(reg_en_SM_b)
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
    .clk(clk_SM_b),
    .clk_b(clk_CTR_b),
    .cal_done(cal_done_SM),
    .cal_b(cal_CTR_b),
    .col_en(col_en_CTR),
    .rst(rst_SM_b_control),
    .rst_b(rst_CTR_b),
    .empty_inputfifo(empty_inputfifo_SM_b),
    .a_reg(a_reg_SM_b),
    .d_reg(d_reg_SM_b),
    .data_cim_in(data_cim_in_CTR),
    .reg_en(reg_en_SM_b),
    .qin(data_in_cim),
    .qout(WR_DATA_CTR),
    .full_outputfifo(full_outputfifo),
    .WR_EN_outputfifo(WR_EN_outputfifo_CTR),
    .RD_EN_inputfifo(RD_EN_inputfifo_CTR)
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
    .ADDR_CIM_IN_WIDTH(ADDR_CIM_IN_WIDTH),
    .CHIP_EN_DATA(4'h0)
)
dut_outputFIFO(
    .CLK_WR(clk_CTR_b),
    .CLK_RD(clk_CTR_b),
    .RD_EN(RD_EN_outputfifo_SM_b),
    .WR_EN(WR_EN_outputfifo_CTR),
    .rst_n(rst_CTR_b),
    .qin(WR_DATA_CTR),
    .RD_DATA(RD_DATA_outputfifo),
    .full(full_outputfifo),
    .empty(empty_outputfifo)
);

SRAMCIMfinal dut(
        .data_in_cim(RD_DATA_inputfifo), 
        .model(model_SM),
        .set(set_SM),
        .comp(comp_SM),
        .inbit(inbit_SM),
        .wait_(wait_SM),
        .clk(clk_IO_b),
        .a({1'b0,a_cim_IO[7:0]}),
        .d(data_cim_in_CTR),
        .q(data_in_cim[63:0]),
        .wrt(wrt_IO),
        .wrtbuf(wrtbuf),
        .reg_en_row(reg_en_row_inputfifo)
);

//
//task define
    real    CLK_PEROID = 100;
    real    HIGH_RATE = 0.4;
    task test_write_input;
        input [DATA_IN_ADDR/4-1:0] I_addr;
        input [DATA_IN_WIDTH-1:0] I_data;

        begin
            a_in = {11'b00000100000,I_addr};
            data_in = I_data;
            #(CLK_PEROID);
            a_in = {4'hF,11'b0};
        end
    endtask

    task test_write_reg;
        input [DATA_IN_ADDR/4-1:0] R_addr;
        input [DATA_IN_WIDTH-1:0] R_data;

        begin
            a_in = {11'b00000110000,R_addr};
            data_in = R_data;
            #(CLK_PEROID);
            a_in = {4'hF,11'b0};
        end
    endtask

    task test_write_array;
        input [ADDR_CIM_IN_WIDTH-1:0] A_addr;
        input [DATA_OUT_WIDTH-1:0] A_data;

        begin
            a_in = {7'b0000001,A_addr};
            data_in = ~A_data;
            #(CLK_PEROID);
            a_in = {4'hF,11'b0};
        end
    endtask

    task test_read_output;
        input [DATA_IN_ADDR/4-1:0]O_addr;
        reg [DATA_OUT_WIDTH-1:0]O_data;
        begin   
            a_in = {7'b0000100,O_addr,4'b0000};
            O_data = data_out;
            $display("cALCULATION Result %d is %h",O_addr,O_data);
            #(CLK_PEROID);
            a_in = {4'hF,11'b0};
        end
    endtask

    task test_write_and_read;
        input [DATA_IN_ADDR/4-1:0]I_addr;
        input [DATA_IN_ADDR/4-1:0]O_addr;
        input [DATA_IN_WIDTH-1:0]I_data;
        reg [DATA_OUT_WIDTH-1:0]O_data;
        begin   
            a_in = {7'b0000111,O_addr,I_addr};
            O_data = data_out;
            data_in = I_data;
            $display("cALCULATION Result %d is %h",O_addr,O_data);
            #(CLK_PEROID);
            a_in = {4'hF,11'b0};
        end
    endtask
//

    always begin
        clk = 1 ; #(CLK_PEROID*0.5) ;
        clk = 0 ; #(CLK_PEROID*0.5) ;
    end
    
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
        test_write_array(9'd0,32'hFEDCBA98);
        test_write_array(9'd1,32'hFEDCBA98);
        test_write_array(9'd2,32'hFEDCBA98);
        test_write_array(9'd3,32'hFEDCBA98);
        test_write_array(9'd4,32'hFEDCBA98);
        test_write_array(9'd5,32'hFEDCBA98);
        test_write_array(9'd6,32'hFEDCBA98);
        test_write_array(9'd7,32'hFEDCBA98);
        test_write_array(9'd8,32'hFEDCBA98);
        
        test_write_array(9'd128,32'h76543210);
        test_write_array(9'd129,32'h76543210);
        test_write_array(9'd130,32'h76543210);
        test_write_array(9'd131,32'h76543210);
        test_write_array(9'd132,32'h76543210);
        test_write_array(9'd133,32'h76543210);
        test_write_array(9'd134,32'h76543210);
        test_write_array(9'd135,32'h76543210);
        test_write_array(9'd136,32'h76543210);

    
    //writeBuffer
        #(CLK_PEROID*4);
        test_write_reg(4'd0,32'h00000001);
        test_write_input(9'd0,32'hFFFFFFFF);
        test_write_input(9'd1,32'hFFFFFFFF);
        test_write_input(9'd2,32'hFFFFFFFF);
        test_write_input(9'd3,32'hFFFFFFFF);
        test_write_input(9'd4,32'hFFFFFFFF);
        test_write_input(9'd5,32'hFFFFFFFF);
        test_write_input(9'd6,32'hFFFFFFFF);
        test_write_input(9'd7,32'hFFFFFFFF);
        // data_in_cim = 64'h7777777777777777;
        # (CLK_PEROID *31);
        test_read_output(4'd0);
        test_read_output(4'd1);
    

    //test simd shifter        
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(4'd7,32'h00000009);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
        
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(4'd7,32'h0000000a);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(4'd7,32'h00000007);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);
    //
    //test simd add
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(4'd7,32'h00000080);
        // test_write_reg(4'd5,32'h11111111);
        // test_write_reg(4'd6,32'h11111111);
        // data_in_cim = 64'h7777777777777777;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        // //add result out of 4bits range 
        // test_write_input(4'd0,36'h0F0F0F0F0);
        // test_write_reg(4'd7,32'h00000080);
        // test_write_reg(4'd5,32'h11111111);
        // test_write_reg(4'd6,32'h11111111);
        // data_in_cim = 64'hffffffffffffffff;
        // # (CLK_PEROID *30);
        // test_read_output(4'd0);
        // test_read_output(4'd1);

        //minus
        test_write_input(4'd0,36'h0F0F0F0F0);
        test_write_reg(4'd7,32'h000000c0);
        test_write_reg(4'd5,32'h11111111);
        test_write_reg(4'd6,32'h11111111);
        // data_in_cim = 64'h7777777777777777;
        # (CLK_PEROID *31);
        test_read_output(4'd0);
        test_read_output(4'd1);

        //minus result out of 4bits range
        test_write_input(4'd0,36'h0F0F0F0F0);
        test_write_reg(4'd7,32'h000000c0);
        test_write_reg(4'd5,32'h88888888);
        test_write_reg(4'd6,32'h88888888);
        // data_in_cim = 64'h7777777777777777;
        # (CLK_PEROID *31);
        test_read_output(4'd0);
        test_read_output(4'd1);
    //
    //test mux
        //shift 4
        test_write_input(4'd0,36'h0F0F0F0F0);
        test_write_reg(4'd7,32'h00000400);
        // data_in_cim = 64'h7777777777777777;
        # (CLK_PEROID *31);
        test_read_output(4'd0);
        test_read_output(4'd1);

        //shift 15
        test_write_input(4'd0,36'h0F0F0F0F0);
        test_write_reg(4'd7,32'h00000F00);
        // data_in_cim = 64'h7777777777777777;
        # (CLK_PEROID *30);
        test_read_output(4'd0);
        test_read_output(4'd1);
    //
        $finish(10);
    end
endmodule