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


module receiver_tb;
    parameter                 DATA_WIDTH = 8;
    reg                       rst, 
                              clk;
    
    
    
    reg                       rx_din;
    
    wire                      rx_done;
    wire [DATA_WIDTH - 1 : 0] rx_dout;


receiver inst(
    .rx_din(rx_din),
    .rst(rst),
    .clk(clk),
    //.tick(tick),
    //.clk_count(clk_count),
    //.tick_count(tick_count),
//    .state(state),
//    .nextstate(nextstate),
    .rx_done(rx_done),
    .rx_dout(rx_dout)
);

integer i;
initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial
    begin
        rst = 1;
        rx_din = 1;
        #30;      
        rst = 0;
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
        
        
        #160;
        rx_din = 0;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 1;
        #160;
        rx_din = 0;
        #160;
        rx_din = 1;
        
        
        
    end    
endmodule
