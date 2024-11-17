`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2024 03:34:25 PM
// Design Name: 
// Module Name: receiver_tb
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


module transmitter_tb;
parameter DATA_WIDTH = 8;
reg rst, clk;

reg [0:DATA_WIDTH-1] tx_din;

wire tx_done;
wire tx_dout;
reg tx_start;


transmitter inst(
.tx_din(tx_din),
.rst(rst),
.clk(clk),
.tx_start(tx_start),


.tx_done(tx_done),
.tx_dout(tx_dout)


);


initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial
    begin
        rst = 1;
        tx_start = 0;
        #30;      
        rst = 0;
        tx_start = 1;
        #10;
        
        tx_din = 8'b10101011;      
      
        #1600;    
        tx_din = 8'b11110000;
     
        #1600;    
        tx_din = 8'b10101010;
        
    end    
endmodule
