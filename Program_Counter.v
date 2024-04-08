`timescale 1ns / 1ps

//PC keeps the track of the addresses of the instructions being executed.

module Program_Counter (clk, reset,load, i_pc, o_pc);

    input clk;
    
    input reset;
    
    input load; //Load signal
    
    input [31:0] i_pc; //Input data for the PC
    
    output reg [31:0] o_pc; 

    always @(posedge clk, posedge reset) //Asynchronous reset
    
     begin
     
        if (reset) 
            o_pc <= 32'b0; //Reset the PC to zero

        else if (clk && load) 
            o_pc <= i_pc; //Load the Output PC with the Input PC

        else 
            o_pc <= o_pc; //No change
            
    end

endmodule
