`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 02:38:28 PM
// Design Name: 
// Module Name: DFF
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


module DFF(
    input clk, D,
    output reg Q, 
    output Qbar
    );
assign Qbar = ~Q;
always @(posedge clk)
begin
    Q <= D;
    
end
endmodule
