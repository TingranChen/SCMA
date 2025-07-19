module SM #(
    parameter DATA_IN_WIDTH = 36,
    parameter DATA_OUT_WIDTH = 32,
    parameter DATA_IN_ADDR = 16,
    parameter DATA_OUT_ADDR = 2,
    parameter ADDR_IN_WIDTH = 11,
    parameter REG_DATA_WIDTH = 32,
    parameter REG_DEPTH = 16,
    parameter REG_ADDR = 8,
    parameter ADDR_CIM_IN_WIDTH = 8,
    parameter CHIP_EN_DATA = 4'h0,
    parameter IDLE = 2'b00,
    parameter CAL = 2'b01
)
(
    input clk,
    input cal_b,
    output comp,
    output model,
    output wait_,
    output inbit,
    output set,
    output reg cal_done,
    input rst
    );
    reg [4:0] cnt;
    reg [1:0]state;
    reg cim_flag;
    
    
    always @(posedge clk or negedge rst)begin
        if(!rst)begin
            state <= IDLE;
            cnt <= 4'b0;
            cim_flag <=  1'b0;
            cal_done <= 1'b0; 
        end
        else if(state == CAL)begin
            if(cnt==12)begin
                if(!cal_b)begin
                    state <= IDLE;
                    cnt <= 5'b0;
                end
                    cal_done <= 1'b1;
            end
            else cnt <= cnt+1;
        end
        else if(state == IDLE)begin
            if(cal_b)begin
                state<= CAL;
                cal_done<=1'b0;
            end
            else
                cal_done <= 1'b0;
        end
        else;
    end
    
    // always @(posedge cal_b)begin
    //     if(state==IDLE) begin
    //         state<= CAL;
    //         cal_done<=1'b0;
    //     end
    // end
    
    // assign set = cnt==1 || cnt==2 || cnt==3 || cnt==4;
    // assign comp = state==CAL && cnt!=0 && !set;
    // assign model =  cnt==15 || cnt==16 || cnt==17 || cnt==18 || cnt==19 || cnt==20 || cnt==21 || cnt==22 || cnt==23 || cnt==24;
    // assign wait_ = cnt==5 || cnt==6 || cnt==7 || cnt==8 || cnt==9 || cnt==10 || cnt==15 || cnt==16 || cnt==17 || cnt==18 || cnt==19 || cnt==20;
    // assign inbit = cnt==7 || cnt==8 || cnt==9 || cnt==10 || cnt==17 || cnt==18 || cnt==19 || cnt==20 ;

    assign set = cnt==1 || cnt==2 || (!rst);
    assign comp =  cnt==3 || cnt==4 || cnt==5 || cnt==6 || cnt==7 || cnt==8 || cnt==9 || cnt==10 || cnt==11 || cnt==12;
    assign model =  cnt==8 || cnt==9 || cnt==10 || cnt==11 || cnt==12;
    assign wait_ = cnt==3 || cnt==4 || cnt==5 || cnt==8 || cnt==9 || cnt==10;
    assign inbit = cnt==4 || cnt==5 || cnt==9 || cnt==10 ;

    // assign set = cnt==1 || cnt==2 || (!rst);
    // assign comp = state==CAL && cnt!=0 && !set;
    // assign model =  cnt==8 || cnt==9 || cnt==10 || cnt==11 || cnt==12;
    // assign wait_ = cnt==3 || cnt==4 || cnt==5 || cnt==8 || cnt==9 || cnt==10;
    // assign inbit = cnt==4 || cnt==5 || cnt==9 || cnt==10 ;
 
    // assign set = cnt==1 || cnt==2 || cnt==3 || cnt==4 || cnt==5;
    // assign comp = state==CAL && cnt!=0 && !set;
    // assign model =  cnt==11 || cnt==12 || cnt==13 || cnt==14 || cnt==15;
    // assign wait_ = cnt==6 || cnt==7 || cnt==8 || cnt==11 || cnt==12 || cnt==13;
    // assign inbit = cnt==7 || cnt==8 || cnt==12 || cnt==13 ;

endmodule
