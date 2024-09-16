module ALUControl(
    input [1:0] alu_op,     // output of control (which select the alu_op based on opcode instr[6:0])
    input [2:0] funct3,     // instr[14:12], together with funct7 is sufficient to determine the operation
    input funct7,           // instr[30]
    output reg [3:0] alu_control
);
     
    always @(*) begin
        case (alu_op)
            // NOTE: R-type and I-type actually don't need separate alu_controls, their funct7 and funct3 
            //      are the same. Only the control.sv needs to take care of things.
            // R-type
            2'b00 : begin 
                        case ({funct7, funct3})
                            4'b0000 : alu_control = 4'b0000; // ADD
                            4'b1000 : alu_control = 4'b0001; // SUB
                            4'b0111 : alu_control = 4'b0010; // AND
                            4'b0110 : alu_control = 4'b0011; // OR
                            4'b0010 : alu_control = 4'b0100; // SLT
                        endcase
                    end
            
            // I-type
            2'b10 : begin
                        case (funct3)
                            3'b000 : alu_control = 4'b0101; // ADDI
                            3'b010 : alu_control = 4'b0110; // SLTI
                            3'b110 : alu_control = 4'b0111; // ORI
                            3'b111 : alu_control = 4'b1000; // ANDI
                        endcase
                    end

            // LW-type
            2'b01 : alu_control = 4'b1001;                   // LW

            // SW-type
            2'b11 : alu_control = 4'b1010;                   // SW

        endcase
    end


endmodule