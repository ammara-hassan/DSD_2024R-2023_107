`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2025 11:36:06 AM
// Design Name: 
// Module Name: lab3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab3(
input logic a,b,c,
output logic x,y
);
   logic and_out;
   logic or_out1, or_out2;
    logic nand_out;
    logic not_out;
    logic xor_out1,xor_or2;
    
    
   assign or_out1 = a | b;
   assign nand_out = ~(a & b);
   assign x = ~c ^ or_out1; 
   assign xor_out2 = nand_out ^ a | b;
   assign y = or_out1 & xor_out2;
 
endmodule
