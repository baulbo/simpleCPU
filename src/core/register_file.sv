module RegisterFile(
    input clk,
    input rst ,                 // active low reset
    input we,                   // write enable
    input [4:0] rs1_addr,       // instr[19:15]
    input [4:0] rs2_addr,       // instr[24:20]
    input [4:0] rd_addr,        // instr[11:7]
    input [31:0] write_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);
    reg [31:0] registers [0:31];
    
    always @(negedge clk, negedge rst) begin
        if(~rst) begin
            // reset registers
            // TODO: replace the line below if testing done with --> registers[0] <= 0; registers[1] <= 0; registers[2] <= 0; registers[3] <= 0; 
            registers[0] <= 0; registers[1] <= 0; registers[2] <= 0; registers[3] <= 0; 
            registers[4] <= 0; registers[5] <= 0; registers[6] <= 0; registers[7] <= 0; 
            registers[8] <= 0; registers[9] <= 0; registers[10] <= 0; registers[11] <= 0; 
            registers[12] <= 0; registers[13] <= 0; registers[14] <= 0; registers[15] <= 0; 
            registers[16] <= 0; registers[17] <= 0; registers[18] <= 0; registers[19] <= 0; 
            registers[20] <= 0; registers[21] <= 0; registers[22] <= 0; registers[23] <= 0; 
            registers[24] <= 0; registers[25] <= 0; registers[26] <= 0; registers[27] <= 0; 
            registers[28] <= 0; registers[29] <= 0; registers[30] <= 0; registers[31] <= 0;
        end else if (we) begin
            // write enabled
            // NOTE: reg x0 has to stay 0
            registers[rd_addr] <= (rd_addr == 0) ? 0 : write_data;
        end
    end

    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

endmodule