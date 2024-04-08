`timescale 1ns / 1ps

//the Instruction Memory Unit (IMU) is responsible for managing and providing instructions to the processor during program execution. It plays a crucial role in fetching and decoding instructions, allowing the CPU to execute the instructions of a program.

module  Memory_for_Instructions(clk,reset,address,instruction);

    input clk;
    input reset;
    input [31:0] address; //Memory address
    output reg [31:0] instruction; //Instruction fetched from memory
    
    reg[7:0] memory [0:1023]; //Array of 1024 registers, each 8 bits wide.
    
    always @(*) begin

        if (reset) begin
            instruction <= 32'b0;
            
            //By initializing the memory with a specific instruction, we can set the initial state of the processor to a known and controlled configuration. In this case, the instruction "MOV R0, #20" is used to initialize register R0 with the value 20.
            {memory[0], memory[1], memory[2], memory[3]} = 32'b1110_00_1_1101_0_0000_0000_000000010100;
            
        end

        else begin
            instruction <= {memory[address], memory[address+1], memory[address+2], memory[address+3]}; //Fetch the instruction depending on the memory address.
        end
        
        end
        
        endmodule
