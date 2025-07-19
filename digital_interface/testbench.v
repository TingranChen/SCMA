 `timescale 1ns/1ns

module top;
    reg clk;//CIM input
    reg [8:0]a;//CIM input
    reg [15:0]d_chip;//sys input and CIM input
    reg wrt;//CIM input
    reg wrtbuf;//CIM input
    wire [15:0]q_in_cim;//CIM output
    reg comp;//CIM input
    reg model;//CIM input
    reg wait_;//CIM input
    reg inbit;//CIM input
    reg set;//CIM input
    reg read;//CIM input

    parameter   CYCLE_MHz = 100;
    parameter    CLK_PEROID = 1000 / CYCLE_MHz;
    always begin
        clk = 0 ; #(CLK_PEROID/2) ;
        clk = 1 ; #(CLK_PEROID/2) ;
    end

    initial begin
        a = 9'b0;//CIM input
        d_chip = 16'b0;//sys input and CIM input
        wrt = 1'b0;//CIM input
        wrtbuf = 1'b0;//CIM input
        comp = 1'b0;
        inbit = 1'b0;
        model = 1'b0;
        read = 1'b0;
        set = 1'b0;
        wait_ = 1'b0;
    end

    task test_write;
        input [8:0] B_addr;
        input [15:0] B_data;
        input isBuffer;

        begin
            a = B_addr;
            d_chip = B_data;
            wrt = !isBuffer;
            wrtbuf = isBuffer;
            comp = 1'b0;
            inbit = 1'b0;
            model = 1'b0;
            read = 1'b0;
            set = 1'b0;
            wait_ = 1'b0;
            #(CLK_PEROID*21);
        end
    endtask

    task test_cal;
        begin
            set = 1'b1;
            #(2*CLK_PEROID) set = 1'b0;
            comp = 1'b1;
            model = 1'b0;
            inbit = 1'b0;
            wait_ = 1'b1;
            #(CLK_PEROID) inbit = 1'b1;
            #(2*CLK_PEROID) inbit = 1'b0;
            wait_ = 1'b0;
            #(2*CLK_PEROID) model = 1'b1;
            wait_ = 1'b1;
            #(CLK_PEROID) inbit = 1'b1;
            #(2*CLK_PEROID) inbit = 1'b0;
            wait_ = 1'b0;
            #(2*CLK_PEROID) model = 1'b0;
            comp = 1'b0;
        end
    endtask

    SRAM_CIM dut(
        .a(a), 
        .d(d_chip),
        .q(q_in_cim),
        .clk(clk),
        .comp(comp),
        .inbit(inbit),
        .model(model),
        .read(read),
        .set(set),
        .wait_(wait_),
        .wrt(wrt),
        .wrtbuf(wrtbuf)
    );

    initial begin
		$fsdbDumpfile("vcs_CIM.fsdb");
		$fsdbDumpvars;
        test_write(9'd511,16'd65535,1);
        test_write(9'd0,16'd0,1);
        test_write(9'd2,16'd12341,1);
        test_write(9'd10,16'd11234,1);
        test_write(9'd20,16'd53446,1);
        test_write(9'd100,16'd8561,1);
        test_write(9'd200,16'd2131,1);
		test_write(9'd250,16'd65535,0);
        test_write(9'd267,16'd0,0);
        test_write(9'd299,16'd2342,0);
        test_write(9'd302,16'd14255,0);
        test_write(9'd12,16'd65532,0);
        test_write(9'd408,16'd23432,0);
        test_write(9'd490,16'd65521,0);
        test_cal;
        $finish(10);
    end

endmodule