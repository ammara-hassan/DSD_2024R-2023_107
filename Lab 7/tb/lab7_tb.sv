`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2025 07:54:17 PM
// Design Name: 
// Module Name: lab7_tb
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


module lab7_tb;

    // Testbench signals
    reg [3:0] num_input;  // Input number to store
    reg [2:0] selector;   // Selector input for mux and anode control
    reg write_enable;     // Write enable signal
    reg clk;              // Clock signal
    reg reset;            // Reset signal
    
    wire [6:0] seg_output;  // 7-segment display output
    wire [7:0] anode_pins;  // Anode control pins

    // Instantiate the Lab_7 module
    Lab_7 uut (
        .seg_output(seg_output),
        .anode_pins(anode_pins),
        .num_input(num_input),
        .selector(selector),
        .write_enable(write_enable),
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation (period = 10ns)
    always begin
        #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // Initial block for stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        write_enable = 0;
        num_input = 4'b0000;
        selector = 3'b000;
        
        // Apply reset for a few clock cycles
        #10 reset = 1;  // Assert reset for 10ns
        #10 reset = 0;  // Deassert reset
        
        // Test Case 1: Store value 4 at position 0
        num_input = 4'b0100;  // Value to store (4)
        selector = 3'b000;    // Selector for position 0
        write_enable = 1;     // Enable writing
        #10 write_enable = 0; // Disable write
        
        // Test Case 2: Store value 7 at position 1
        num_input = 4'b0111;  // Value to store (7)
        selector = 3'b001;    // Selector for position 1
        write_enable = 1;     // Enable writing
        #10 write_enable = 0; // Disable write
        
        // Test Case 3: Select position 0 (Expect value 4 on display)
        selector = 3'b000;    // Selector for position 0
        #10;

        // Test Case 4: Select position 1 (Expect value 7 on display)
        selector = 3'b001;    // Selector for position 1
        #10;
        
        // Test Case 5: Store value 2 at position 2
        num_input = 4'b0010;  // Value to store (2)
        selector = 3'b010;    // Selector for position 2
        write_enable = 1;     // Enable writing
        #10 write_enable = 0; // Disable write
        
        // Test Case 6: Select position 2 (Expect value 2 on display)
        selector = 3'b010;    // Selector for position 2
        #10;
        
        // Test Case 7: Reset the system
        reset = 1;  // Assert reset
        #10 reset = 0;  // Deassert reset
        
        // Test Case 8: Store value 9 at position 3
        num_input = 4'b1001;  // Value to store (9)
        selector = 3'b011;    // Selector for position 3
        write_enable = 1;     // Enable writing
        #10 write_enable = 0; // Disable write
        
        // Test Case 9: Select position 3 (Expect value 9 on display)
        selector = 3'b011;    // Selector for position 3
        #10;
        
        // Test Case 10: Store value 5 at position 4
        num_input = 4'b0101;  // Value to store (5)
        selector = 3'b100;    // Selector for position 4
        write_enable = 1;     // Enable writing
        #10 write_enable = 0; // Disable write
        
        // Test Case 11: Select position 4 (Expect value 5 on display)
        selector = 3'b100;    // Selector for position 4
        #10;

        // End of simulation
        $stop;
    end
endmodule
