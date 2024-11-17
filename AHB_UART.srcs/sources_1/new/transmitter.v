`timescale 1ns / 1ps


module transmitter
    #(parameter DATA_WIDTH = 8)
    (
    input  rst, 
           clk,      
           tx_start,      
           [DATA_WIDTH-1:0]tx_din, 
           
    output reg tx_done = 0, 
           reg tx_dout
                     
    );
    
    parameter s_idle = 2'b00, s_start = 2'b01, s_data = 2'b10, s_stop = 2'b11;
    
    wire [DATA_WIDTH + 1:0] tx_data = {1'b1, tx_din, 1'b0};
    reg  [1:0]              state, nextstate;
    reg                     tick = 0;
    reg  [3:0]              clk_count = 0, 
                            tick_count = 0;
    integer                 i = 0;
    
    
    always @(posedge clk)
    begin
        clk_count = clk_count + 1;
        if (clk_count == 1)
        begin   
            tick <= ~tick;
            clk_count <= 0;    
        end
    end
    
    always @(posedge clk, posedge rst)
        if (rst == 1) 
        begin
            state <= s_idle;
            tick_count <= 0;     
        end
        else 
        begin
            state <= nextstate;       
        end
        
    always @(tick)
        case(state)   
            s_idle: 
            if (tx_start == 1) 
            begin
                nextstate = s_start;
                tick_count = 0;
                tx_done = 1;
            end
            else nextstate = s_idle;
            
            s_start:
            begin 
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_start;
                if (tick_count == 8)
                begin
                    tx_done = 0;
                    tick_count = 0;
                    tx_dout = tx_data[i];
                    i = i + 1;
                    nextstate = s_data;
                end  
            end
            
            s_data: 
            begin
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_data;
                if (tick_count == 8)
                begin
                    tx_dout = tx_data[i];
                    i = i + 1;
                    tick_count = 0;
                end
                if (i == DATA_WIDTH + 1) nextstate = s_stop;
                else nextstate = s_data;                   
            end
            
            s_stop:
            begin
                
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_stop;
                if (tick_count == 8)
                begin
                    tx_dout = tx_data[DATA_WIDTH + 1];
                    if (tx_data[DATA_WIDTH + 1] == 1)               
                        nextstate = s_idle; 
                    i = 0;
                    tick_count = 0;
                    tx_done = 1;
                             
                end
            end
            
            default: nextstate = s_idle;
        endcase
    
endmodule
