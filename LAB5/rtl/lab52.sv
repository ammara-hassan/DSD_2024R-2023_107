`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 10:27:05 PM
// Design Name: 
// Module Name: lab52
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

module lab52(
  input [3:0] num,  
  input [2:0] sel,  
  output logic [6:0] segments,  
  output logic [7:0] anode    
);

  always_comb begin
    case (num)
      4'h0: segments = 7'b1000000;  
      4'h1: segments = 7'b1111001;
      4'h2: segments = 7'b0100100;
      4'h3: segments = 7'b0110000;
      4'h4: segments = 7'b0011001;
      4'h5: segments = 7'b0010010;
      4'h6: segments = 7'b0000010;
      4'h7: segments = 7'b1111000;
      4'h8: segments = 7'b0000000;
      4'h9: segments = 7'b0010000;
      4'hA: segments = 7'b0001000;
      4'hB: segments = 7'b0000011;
      4'hC: segments = 7'b1000110;
      4'hD: segments = 7'b0100001;
      4'hE: segments = 7'b0000110;
      4'hF: segments = 7'b0001110;
      default: segments = 7'b1111111;
    endcase
  end

  always_comb begin
    case (sel)
      3'b000: anode = 8'b11111110;
      3'b001: anode = 8'b11111101;
      3'b010: anode = 8'b11111011;
      3'b011: anode = 8'b11110111;
      3'b100: anode = 8'b11101111;
      3'b101: anode = 8'b11011111;
      3'b110: anode = 8'b10111111;
      3'b111: anode = 8'b01111111;
      default: anode = 8'b11111111;
    endcase
  end

endmodule
