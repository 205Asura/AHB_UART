`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 10:19:56 AM
// Design Name: 
// Module Name: UART_tb
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


module UART_tb;
    reg        rst, 
               clk;
              
    reg [7:0]  din;
    reg        rx_din;   
    
    reg        wr_en,
               rd_en;
              
    wire       full,
               empty;
               
    wire [7:0] dout;
    wire       tx_dout;
UART inst(
    .clk(clk),
    .rst(rst),
    .din(din),
    .rx_din(rx_din),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .full(full),
    .empty(empty),
    .dout(dout),
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
    wr_en = 0;
    
    #10;
    rst = 0;
    wr_en = 1;
    din = 8'b10101010;
    #10;
    wr_en = 0;
    
    #1700;
        rx_din = 0;
        #160;
        rx_din = 1;
        #160;
        rx_din = 0;
        #160;
        rx_din = 1;
        #160;
        rx_din = 0;
        #160;
        rx_din = 1;
        #160;
        rx_din = 0;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        rd_en = 1;
end 
endmodule
