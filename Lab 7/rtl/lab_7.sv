`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2025 10:19:49 PM
// Design Name: 
// Module Name: lab_7
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// A combined and modified version of the original code with adjusted names and logic.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab_7(
    output [6:0] seg_output,
    output [7:0] anode_pins,
    input [3:0] num_input,
    input [2:0] selector,
    input write_enable, clk, reset
);
    wire [3:0] data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7, data_out8, mux_output;

    // Storage module to hold the data
    storage_unit data_storage (
        .D1(data_out1), .D2(data_out2), .D3(data_out3), .D4(data_out4),
        .D5(data_out5), .D6(data_out6), .D7(data_out7), .D8(data_out8),
        .num(num_input), .sel(selector), .write(write_enable), 
        .clk(clk), .reset(reset)
    );

    // Multiplexer to select one of the stored values
    mux_8_selector mux_selector (
        .mux_out(mux_output), .D1(data_out1), .D2(data_out2), .D3(data_out3), .D4(data_out4),
        .D5(data_out5), .D6(data_out6), .D7(data_out7), .D8(data_out8), 
        .sel(selector)
    );

    // Anode control for display
    anode_control anode_ctrl (
        .out(anode_pins), .sel(selector), .write(write_enable)
    );

    // Segment control to convert the selected value to 7-segment representation
    segment_control seg_ctrl (
        .seg_output(seg_output), .L_out(mux_output)
    );
endmodule

module storage_unit(
    output reg [3:0] D1, D2, D3, D4, D5, D6, D7, D8,
    input [3:0] num, 
    input [2:0] sel, 
    input write, clk, reset
);
    wire [3:0] write_enable;
    assign write_enable = {sel[2], sel[1], sel[0], write};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            D1 <= 4'b0000;
            D2 <= 4'b0000;
            D3 <= 4'b0000;
            D4 <= 4'b0000;
            D5 <= 4'b0000;
            D6 <= 4'b0000;
            D7 <= 4'b0000;
            D8 <= 4'b0000;
        end else begin
            case (write_enable)
                4'b0001: D1 <= num;
                4'b0011: D2 <= num;
                4'b0101: D3 <= num;
                4'b0111: D4 <= num;
                4'b1001: D5 <= num;
                4'b1011: D6 <= num;
                4'b1101: D7 <= num;
                4'b1111: D8 <= num;
            endcase
        end
    end
endmodule

module mux_8_selector(
    output reg [3:0] mux_out,
    input [3:0] D1, D2, D3, D4, D5, D6, D7, D8,
    input [2:0] sel
);
    always @(*) begin
        case (sel)
            3'b000: mux_out = D1;
            3'b001: mux_out = D2;
            3'b010: mux_out = D3;
            3'b011: mux_out = D4;
            3'b100: mux_out = D5;
            3'b101: mux_out = D6;
            3'b110: mux_out = D7;
            3'b111: mux_out = D8;
            default: mux_out = 4'b0000;
        endcase
    end
endmodule

module anode_control(
    output reg [7:0] out,
    input [2:0] sel,
    input write
);
    wire [3:0] control_signal;
    assign control_signal = {sel[2], sel[1], sel[0], write};

    always @(*) begin
        case (control_signal)
            4'b0000: out = 8'b1111_1110;
            4'b0001: out = 8'b1111_1111;
            4'b0010: out = 8'b1111_1101;
            4'b0011: out = 8'b1111_1111;
            4'b0100: out = 8'b1111_1011;
            4'b0101: out = 8'b1111_1111;
            4'b0110: out = 8'b1111_0111;
            4'b0111: out = 8'b1111_1111;
            4'b1000: out = 8'b1110_1111;
            4'b1001: out = 8'b1111_1111;
            4'b1010: out = 8'b1101_1111;
            4'b1011: out = 8'b1111_1111;
            4'b1100: out = 8'b1011_1110;
            4'b1101: out = 8'b1111_1111;
            4'b1110: out = 8'b0111_1110;
            4'b1111: out = 8'b1111_1111;
            default: out = 8'b1111_1111;
        endcase
    end
endmodule

module segment_control(
    output reg [6:0] seg_output,
    input [3:0] L_out
);
    always @(L_out) begin
        case(L_out)
            4'b0000: seg_output = 7'b000_0001;
            4'b0001: seg_output = 7'b100_1111;
            4'b0010: seg_output = 7'b001_0010;
            4'b0011: seg_output = 7'b000_0110;
            4'b0100: seg_output = 7'b100_1100;
            4'b0101: seg_output = 7'b010_0100;
            4'b0110: seg_output = 7'b010_0000;
            4'b0111: seg_output = 7'b000_1111;
            4'b1000: seg_output = 7'b000_0000;
            4'b1001: seg_output = 7'b000_0100;
            4'b1010: seg_output = 7'b000_1000;
            4'b1011: seg_output = 7'b110_0000;
            4'b1100: seg_output = 7'b011_0001;
            4'b1101: seg_output = 7'b100_0010;
            4'b1110: seg_output = 7'b011_0000;
            4'b1111: seg_output = 7'b011_1000;
            default: seg_output = 7'b111_1111;
        endcase
    end
endmodule
