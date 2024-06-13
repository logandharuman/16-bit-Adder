`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 11:34:17
// Design Name: 
// Module Name: tb_adder16
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


module tb_adder16;
    reg [15:0] x, y;
    wire [15:0] z;
    wire sign, zero, carry, parity, overflow;

    // Instantiate the DUT
    adder16 uut (
        .x(x),
        .y(y),
        .z(z),
        .sign(sign),
        .zero(zero),
        .carry(carry),
        .parity(parity),
        .overflow(overflow)
    );

    // Test vectors
    initial begin
        // Test Case 1
        x = 16'h0000; y = 16'h0000;
        #10;
        $display("x = %h, y = %h, z = %h, sign = %b, zero = %b, carry = %b, parity = %b, overflow = %b", x, y, z, sign, zero, carry, parity, overflow);

        // Test Case 2
        x = 16'hFFFF; y = 16'h0001;
        #10;
        $display("x = %h, y = %h, z = %h, sign = %b, zero = %b, carry = %b, parity = %b, overflow = %b", x, y, z, sign, zero, carry, parity, overflow);

        // Test Case 3
        x = 16'h8000; y = 16'h8000;
        #10;
        $display("x = %h, y = %h, z = %h, sign = %b, zero = %b, carry = %b, parity = %b, overflow = %b", x, y, z, sign, zero, carry, parity, overflow);

        // Test Case 4
        x = 16'h1234; y = 16'h5678;
        #10;
        $display("x = %h, y = %h, z = %h, sign = %b, zero = %b, carry = %b, parity = %b, overflow = %b", x, y, z, sign, zero, carry, parity, overflow);

        // Test Case 5
        x = 16'hAAAA; y = 16'h5555;
        #10;
        $display("x = %h, y = %h, z = %h, sign = %b, zero = %b, carry = %b, parity = %b, overflow = %b", x, y, z, sign, zero, carry, parity, overflow);

        $finish;
    end
endmodule

