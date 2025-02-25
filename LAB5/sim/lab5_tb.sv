`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 10:21:41 PM
// Design Name: 
// Module Name: lab5_tb
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

module lab5_tb();
    logic [3:0] num;
    logic [2:0] sel;
    logic [6:0] segments;
    logic [7:0] anode;

    lab5 uut( 
        .num(num),
        .sel(sel),
        .segments(segments),
        .anode(anode)
    );

    task driver(input logic [3:0] N = $random, input logic [2:0] S = $random);
        begin
            num = N;
            sel = S;
            #10;
        end
    endtask

    task direct_test(input logic [3:0] N, input logic [2:0] S);
        begin
            driver(N, S);
            monitor();
        end
    endtask

    task random_test(input int n);
        begin
            for (int i = 0; i < n; i++) begin
                driver();
                monitor();
            end
        end
    endtask  

    task monitor();
        logic [6:0] expected_segment;
        logic [7:0] expected_anode;

        begin
           
            case (num)
                4'h0: expected_segment = 7'b1000000;
                4'h1: expected_segment = 7'b1111001;
                4'h2: expected_segment = 7'b0100100;
                4'h3: expected_segment = 7'b0110000;
                4'h4: expected_segment = 7'b0011001;
                4'h5: expected_segment = 7'b0010010;
                4'h6: expected_segment = 7'b0000010;
                4'h7: expected_segment = 7'b1111000;
                4'h8: expected_segment = 7'b0000000;
                4'h9: expected_segment = 7'b0010000;
                4'hA: expected_segment = 7'b0001000;
                4'hB: expected_segment = 7'b0000011;
                4'hC: expected_segment = 7'b1000110;
                4'hD: expected_segment = 7'b0100001;
                4'hE: expected_segment = 7'b0000110;
                4'hF: expected_segment = 7'b0001110;
                default: expected_segment = 7'b1111111;
            endcase

            
            case (sel)
                3'b000: expected_anode = 8'b11111110;
                3'b001: expected_anode = 8'b11111101;
                3'b010: expected_anode = 8'b11111011;
                3'b011: expected_anode = 8'b11110111;
                3'b100: expected_anode = 8'b11101111;
                3'b101: expected_anode = 8'b11011111;
                3'b110: expected_anode = 8'b10111111;
                3'b111: expected_anode = 8'b01111111;
                default: expected_anode = 8'b11111111;
            endcase

            
            if (segments !== expected_segment || anode !== expected_anode) begin
                $display("ERROR: num=%b, sel=%b, Expected: segment=%b, anode=%b, Got: segment=%b, anode=%b, Time=%t", 
                         num, sel, expected_segment, expected_anode, segments, anode, $time);
                $finish;
            end else begin
                $display("PASS: num=%b, sel=%b, segment=%b, anode=%b, Time=%t", 
                         num, sel, segments, anode, $time);
            end    
        end
    endtask

    initial begin
        $display("Starting Experiment_5 Self-Testing Testbench...\n");

        
        direct_test(4'b0000, 3'b000);
        direct_test(4'b1111, 3'b111);
        direct_test(4'b1010, 3'b011);
        direct_test(4'b0101, 3'b100);

        
        random_test(5);

        $display("\nAll tests passed successfully!");
        $finish;    
    end    
endmodule
