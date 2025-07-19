`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 22:04:12
// Design Name: 
// Module Name: Relu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: z
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Relu(
input [5:0]data,
input RELU,
output [5:0]out
);

assign out = RELU?(data[5]?data:5'b0):(data);

endmodule
