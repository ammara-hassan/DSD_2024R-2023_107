`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 08:25:02 PM
// Design Name: 
// Module Name: l4_tb
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


module l4_tb();
  logic [1:0] a;
  logic [1:0] b;
  logic red,green,blue;

l4 uut( 
  .a(a),
  .b(b),
  .red(red),
  .green(green),
  .blue(blue)
);

task driver(logic [1:0] A = $random , B = $random);
      a = A;
      b = B;
      #10;
endtask

task direct_test(logic [1:0] a,b);
  begin
      driver(a,b);
  end
endtask

task random_test(input int n);
  for(int i=0 ; i<n ; i++)
  begin
      driver();
  end
endtask  

task monitor();
      begin
          $monitor("Time: %0t | a = %b, b = %b, red = %b, green = %b, blue = %b", 
                   $time, a, b, red, green, blue);
      end
  endtask

initial begin
  
      monitor();
      
      direct_test(2'b10, 2'b01);
      direct_test(2'b01, 2'b10);
      
      random_test(10);
     
      $finish;    
      end    
endmodule
