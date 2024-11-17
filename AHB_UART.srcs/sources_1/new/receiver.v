`timescale 1ns / 1ps


module receiver
    #(parameter DATA_WIDTH = 8)
    (
    input   rst, 
            clk, 
            rx_din, 
            
    output  reg                       rx_done,
    output  reg [DATA_WIDTH - 1 : 0]  rx_dout          
    );
    
    parameter s_idle = 2'b00, s_start = 2'b01, s_data = 2'b10, s_stop = 2'b11;
    
    reg [1:0]                state, nextstate;
    reg [3:0]                tick_count = 0;
    
    reg       tick = 0;
    integer   clk_count = 0, i = 0;
    
    
    
    always @(posedge clk)
    begin
            clk_count <= clk_count + 1;
            if (clk_count == 1-1)
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
            if (rx_din == 0) 
            begin
                nextstate = s_start;
                tick_count = 0;
                
                rx_done = 1;
            end
            else nextstate = s_idle;
            
            s_start:
            begin 
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_start;
                if (tick_count == 4)
                begin
                    tick_count = 0;
                    nextstate = s_data;
                    rx_done = 0;
                    
                end  
            end
            
            s_data: 
            begin
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_data;
                if (tick_count == 8)
                begin
                    rx_dout[i] = rx_din;
                    i = i + 1;
                    tick_count = 0;
                end
                if (i == DATA_WIDTH) nextstate = s_stop;
                else nextstate = s_data;                   
            end
            
            s_stop:
            begin
                if (tick == 1) tick_count = tick_count + 1;
                else nextstate = s_stop;
                if (tick_count == 8)
                begin
                    
                    if (rx_din == 1)
                    begin
                        nextstate = s_idle;
                        
                    end
                    i = 0;
                    tick_count = 0;
                    rx_done = 1;
                    
                end
            end
            
            default: nextstate = s_idle;
        endcase
    
endmodule
