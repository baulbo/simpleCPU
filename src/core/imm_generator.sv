/*
    Sets the imm value according to the the RV32I opcode map.
*/
module ImmGenerator(
    input [31:0] instr,
    output reg signed [31:0] imm
);
    wire [6:0] opcode = instr[6:0];
    always @(*) begin
        case(opcode)
            // LW-type: sign extended immediate will contain address in data mem
            7'b0000011 : imm[31:0] = {{20{instr[31]}}, instr[31:20]}; 
            // S-type instructions (incl. SW instruction)
            7'b0100011 : imm[31:0] = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        endcase
    end
endmodule