`timescale 1ns / 1ps

module fifo
    #(
      parameter FIFO_DEPTH = 8,
      parameter DATA_RANGE = 255 + 1,
      localparam POINTER_WIDTH = $clog2(FIFO_DEPTH),
      localparam DATA_WIDTH = $clog2(DATA_RANGE)
    )
    (
    input                       clk, rst, wr_en, [DATA_WIDTH-1:0]din,
    input                       rd_en,
    output wire                 full, 
           wire                 empty,
    output reg [DATA_WIDTH-1:0] dout
    );
    
    reg [DATA_WIDTH-1:0]        mem [0 : FIFO_DEPTH - 1];
    reg [POINTER_WIDTH:0]       wr_ptr, rd_ptr;
    
    assign full = ({~wr_ptr[POINTER_WIDTH], wr_ptr[POINTER_WIDTH-1:0]} == rd_ptr);
    assign empty = (wr_ptr == rd_ptr);
    
    
    //write
    always @(posedge clk, posedge rst) 
    begin
        if (rst == 1)
        wr_ptr <= 3'd0;
        else 
        begin
            if (wr_en == 1 && ~full) 
            begin        
                mem[wr_ptr[POINTER_WIDTH-1:0]] <= din;
                wr_ptr <= wr_ptr + 1;
                
            end
        end
    end
    //read
    always @(posedge clk, posedge rst) 
    begin
        if (rst == 1)
        rd_ptr <= 3'd0;
        else 
        begin
            if (rd_en == 1 && ~empty) 
            begin
                dout <= mem[rd_ptr[POINTER_WIDTH-1:0]];
                rd_ptr <= rd_ptr + 1;
                
            end
        end
    end

endmodule