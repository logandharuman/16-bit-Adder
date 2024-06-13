`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 11:03:05
// Design Name: 
// Module Name: adder16
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


module adder16(x,y,z,sign,zero,carry,parity,overflow);
    input [15:0] x,y;
    output [15:0] z;
    output sign,carry,zero,parity,overflow;
    wire [3:1] c;
    adder4 A0 (z[3:0],c[1],x[3:0],y[3:0],1'b0);
    adder4 A1 (z[7:4],c[2],x[7:4],y[7:4],c[1]);
    adder4 A2 (z[11:8],c[3],x[11:8],y[11:8],c[2]);
    adder4 A3 (z[15:12],carry,x[15:12],y[15:12],c[3]);

    assign sign=z[15];
    assign zero=~|z;
    assign parity=~|z;
    assign overflow=(x[15]&y[15]&~z[15])|(~x[15]&~y[15]&z[15]);
endmodule
