module ALU(
    input [3:0] alu_control,
    input reg signed [31:0] a,
    input reg signed [31:0] b,
    output reg signed [31:0] result,
    output zero // NOTE: branching was not implemented
);

    wire signed [31:0] sum;
    wire signed [31:0] sub;
    wire [31:0] and_res;
    wire [31:0] or_res;
    wire signed [31:0] slt_res;

    assign sum = a + b;
    assign sub = a - b;
    assign and_res = a & b; // bitwise and
    assign or_res = a | b; // bitwise or
    assign slt_res = (a < b) ? 32'd1 : 32'b0;

    always @(*) begin
        case (alu_control) 
            // R-type
            4'b0000 : result = sum;     // ADD
            4'b0001 : result = sub;     // SUB
            4'b0010 : result = and_res; // AND
            4'b0011 : result = or_res;  // OR
            4'b0100 : result = slt_res; // SLT

            // I-type
            4'b0101 : result = sum;     // ADDI
            4'b0110 : result = slt_res; // SLTI
            4'b0111 : result = or_res;  // ORI
            4'b1000 : result = and_res; // ANDI

            // LW-type
            4'b1001 : result = sum; // LW   : imm (sign extended imm), which is the offset from the base addr in data memory
            4'b1010 : result = sum; // SW
        endcase 
    end

endmodule