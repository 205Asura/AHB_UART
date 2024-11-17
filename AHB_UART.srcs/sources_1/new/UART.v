`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2024 08:45:29 PM
// Design Name: 
// Module Name: UART
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


module UART(
input         clk, rst,
        [7:0] din, 
input         rx_din,
input         wr_en, rd_en,
output  [7:0] dout, 
output        tx_dout,
output        empty, 
              full
);
wire [7:0] fifo_rx_din;

wire [7:0] fifo_tx_dout;
    
wire       fifo_rx_wr_en,
           fifo_tx_rd_en;

wire       fifo_rx_full,
           fifo_tx_empty;

wire [7:0] rx_dout;
wire       rx_done,
           tx_done;
           
wire [7:0] tx_din;
wire       tx_start;

wire Q, Qbar;
           


assign fifo_rx_din   = rx_dout;
assign fifo_rx_wr_en = ~fifo_rx_full && rx_done;
assign tx_din        = fifo_tx_dout;
assign fifo_tx_rd_en = tx_done && Qbar;
assign tx_start      = ~fifo_tx_empty;

DFF FF(
    .clk(clk),
    .D(tx_done),
    .Q(Q),
    .Qbar(Qbar)
);          

fifo receive_fifo(
    .clk(clk),
    .rst(rst),
    .wr_en(fifo_tx_wr_en),
    .rd_en(rd_en),
    .dout(dout),
    .din(fifo_rx_din),
    .empty(empty),
    .full(fifo_rx_full)
);

fifo transmit_fifo(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(fifo_tx_rd_en),
    .dout(fifo_tx_dout),
    .din(din),
    .full(full),
    .empty(fifo_tx_empty)
);

receiver rx(
    .rst(rst),
    .clk(clk),
    .rx_din(rx_din),
    .rx_dout(rx_dout),
    .rx_done(rx_done)
);

transmitter tx(
    .rst(rst),
    .clk(clk),
    .tx_dout(tx_dout),
    .tx_din(tx_din),
    .tx_done(tx_done),
    .tx_start(tx_start)
);
endmodule
