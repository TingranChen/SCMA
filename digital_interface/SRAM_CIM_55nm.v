`timescale 1ns/1ns

module SRAM_CIM_55nm(
    input clk,//CIM input
    input [8:0]a,//CIM input
    input [15:0]d,//sys input and CIM input
    input wrt,//CIM input
    input wrtbuf,//CIM input
    output [15:0]q,//CIM output
    input comp,//CIM input
    input model,//CIM input
    input wait_,//CIM input
    input inbit,//CIM input
    input set,//CIM input
    input read//CIM input
);

endmodule

