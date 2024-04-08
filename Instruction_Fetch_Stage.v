`timescale 1ns / 1ps

//The primary purpose of the IF stage is to fetch the next instruction to be executed from the program memory. It reads the instruction located at the memory address pointed to by the Program Counter (PC).

module Instruction_Fetch_Stage (clk,reset,freeze,branch_taken,branch_address,o_pc, instruction);

    input clk;
    input reset;
    input freeze; //freeze signal
    
    //Branch signal
    input branch_taken; 
    
    input [31:0] branch_address;
    output [31:0] o_pc;
    output [31:0] instruction;

    wire [31:0] Mux_In;
    wire [31:0] Mux_Out;

    assign Mux_Out = branch_taken ? branch_address : Mux_In; //If there is a branch instruction then branch address is taken.

    wire [31:0] pc_in;
    wire [31:0] pc_out;

    Program_Counter PC(clk, reset, ~freeze, pc_in, pc_out); //Here the not-freeze signal is acting as the load signal for the PC hence the pc_in will be loaded in pc_out only when not_freeze is activated.

    assign pc_in = Mux_Out;

    wire[31:0] pc_added;

    assign pc_added = pc_out + 4; //Fetching of next instruction
    
    assign Mux_In = pc_added; //Value updation of Mux_In with updated program counter

    Memory_for_instructions o_Memory_for_Instructions(clk, reset, pc_out, instruction); //Memory_for_Instructions(clk,reset,address,instruction)
    
    assign o_pc = pc_added;

endmodule
