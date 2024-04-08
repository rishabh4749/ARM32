`timescale 1ns / 1ps

//The Arithmetic Logic Unit (ALU) is a crucial component of a processor (CPU - Central Processing Unit) in a computer system. It plays a fundamental role in performing arithmetic and logic operations, which are essential for the execution of instructions in a computer program.

module Arithmetic_Logic_Unit (

    //32 Bit operands
    input [31:0] A, 
    input [31:0] B,
   
    input [3:0] control, //Specifies the operation to be performed by the processor
    
    input carry_in, //Input carry needed for some specific operations
    
    output reg [31:0] result, //Output from the processor
    
    output [3:0] status //Additional information related to the result
    );
    
    //Status registers
    
    reg carry; //Whether or not there is a carry in the output
    
    reg overflow; //Overflow flag register
    
    wire zero; //Whether the result is zero
    
    wire neg; //Whether the result is negative

    always @(*) begin

        //Carry and Overflow flags being initialised to zero at the beginning of the cycle and values will be updated based on the result of the operation
        carry = 1'b0;
        
        overflow = 1'b0;

        case (control)
        
            4'b0001:
                result = B; //Copy operation
            4'b1001:
                result = ~B; //Complement operation
            4'b0010:
                {carry, result} = A + B; //Addition operation
            4'b0011:
                {carry, result} = A + B + carry_in; //Addition with carry
            4'b0100:
                {carry, result} = A - B; //Subtraction
            4'b0101:
                {carry, result} = A - B - carry_in; //Subtraction with borrow
            4'b0110:
                result = A & B; //AND 
            4'b0111:
                result = A | B; //OR
            4'b1000:
                result = A ^ B; //XOR 
            4'b0100:
                result = A - B; //Bitwise XOR
                
        endcase
        
        //Overflow checking for the addition operations
        
        if(control == 4'b0010 || control == 4'b0011)
        
            overflow = (A[31] == B[31]) & (A[31] != result[31]);

        //Overflow checking for the subtraction operations
        
        else if (control == 4'b0100 || control == 4'b0101)
        
            overflow = (A[31] == ~B[31]) & (A[31] == result[31]);
            
    end

    assign neg = result[31]; //MSB indicates whether the number is positive or negative
    
    assign zero = (result == 32'b0) ? 1'b1 : 1'b0; //Zero checking

    assign status = {zero, carry, neg, overflow}; //Status registers
    
    //ALU Module ends here
    
endmodule 
