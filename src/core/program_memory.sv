
module ProgramMemory (
        input [31:0] addr,
        output [31:0] instr
    );

    reg [31:0] instr_reg [0:63]; // holds program instructions in binary

    assign instr = (addr > 127) ? 32'b0 : instr_reg[addr];

    initial begin

        instr_reg[0] = 32'b0;  instr_reg[1] = 32'b0;  instr_reg[2] = 32'b0;  instr_reg[3] = 32'b0;
        instr_reg[4] = 32'b0;  instr_reg[5] = 32'b0;  instr_reg[6] = 32'b0;  instr_reg[7] = 32'b0;
        instr_reg[8] = 32'b0;  instr_reg[9] = 32'b0;  instr_reg[10] = 32'b0; instr_reg[11] = 32'b0;
        instr_reg[12] = 32'b0; instr_reg[13] = 32'b0; instr_reg[14] = 32'b0; instr_reg[15] = 32'b0;
        instr_reg[16] = 32'b0; instr_reg[17] = 32'b0; instr_reg[18] = 32'b0; instr_reg[19] = 32'b0;
        instr_reg[20] = 32'b0; instr_reg[21] = 32'b0; instr_reg[22] = 32'b0; instr_reg[23] = 32'b0;
        instr_reg[24] = 32'b0; instr_reg[25] = 32'b0; instr_reg[26] = 32'b0; instr_reg[27] = 32'b0;
        instr_reg[28] = 32'b0; instr_reg[29] = 32'b0; instr_reg[30] = 32'b0; instr_reg[31] = 32'b0;
        instr_reg[32] = 32'b0;  instr_reg[33] = 32'b0;  instr_reg[34] = 32'b0;  instr_reg[35] = 32'b0;
        instr_reg[36] = 32'b0;  instr_reg[37] = 32'b0;  instr_reg[38] = 32'b0;  instr_reg[39] = 32'b0;
        instr_reg[40] = 32'b0;  instr_reg[41] = 32'b0;  instr_reg[42] = 32'b0;  instr_reg[43] = 32'b0;
        instr_reg[44] = 32'b0;  instr_reg[45] = 32'b0;  instr_reg[46] = 32'b0;  instr_reg[47] = 32'b0;
        instr_reg[48] = 32'b0;  instr_reg[49] = 32'b0;  instr_reg[50] = 32'b0;  instr_reg[51] = 32'b0;
        instr_reg[52] = 32'b0;  instr_reg[53] = 32'b0;  instr_reg[54] = 32'b0;  instr_reg[55] = 32'b0;
        instr_reg[56] = 32'b0;  instr_reg[57] = 32'b0;  instr_reg[58] = 32'b0;  instr_reg[59] = 32'b0;
        instr_reg[60] = 32'b0;  instr_reg[61] = 32'b0;  instr_reg[62] = 32'b0;  instr_reg[63] = 32'b0;

        // read memory file into program memory
        $readmemb("../assembler/output/example.mem", instr_reg);

    end

endmodule