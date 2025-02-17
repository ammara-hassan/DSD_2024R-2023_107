`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 10:15:29 PM
// Design Name: 
// Module Name: l4
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

`timescale 1ns / 1ps

module l4(
 input logic [1:0] a,b,
 output logic red,green,blue 
);

 assign red = (a[1] & ~b[0]) | (a[1] & ~b[1]) | (a[0] & a[1]) | (~b[0] & ~b[1]) | (a[0] & ~b[1]);
 
 assign blue = (~a[0] & b[0]) | (a[1] & ~b[1]) | (a[0] & ~b[0]) | (~a[1] & b[1]);
 
 assign green = (~a[0] & ~a[1]) | (~a[0] & b[1]) | (b[0] & b[1]) | (~a[1] & b[1]) | (~a[1] & b[0]);

endmodule

