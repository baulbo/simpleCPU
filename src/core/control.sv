
module Control(
    input [6:0] opcode,
    output reg branch,                  // whether to branch (=1) or not (=0) 
    output reg data_mem_read_enable,    // used to enable reading from data memory (wired to data memory) 
    output reg data_mem_write_enable,   // (store) enables writing to data memory (wired to data memory)
    output reg mem_to_reg_sel,          // (load) used to control (sel) multiplexer to switch between ALU out and data mem out
    output reg [1:0] alu_op,            // informs ALU about the type of operation (4 different operations)
    output reg alu_source_sel,          // 0="register file output rs2_data", 1="immediate"
    output reg reg_write_enable         // enables writing to register (wired to register file)
);

    always @(*) begin
        case(opcode)
            // R-type instructions
            7'b0110011  :   begin
                                branch                  = 0;
                                data_mem_read_enable    = 0;
                                data_mem_write_enable   = 0;
                                mem_to_reg_sel          = 0;
                                alu_op                  = 2'b00;   // R-type
                                alu_source_sel          = 0;       // NOTE: use rs2_data out of register file
                                reg_write_enable        = 1;
                            end  

            // I-type instructions
            7'b0010011:   begin
                                branch                  = 0;
                                data_mem_read_enable    = 0; 
                                data_mem_write_enable   = 0;
                                mem_to_reg_sel          = 0;
                                alu_op                  = 2'b10;   // I-type
                                alu_source_sel          = 1;       // source is imm instead of rs2_data
                                reg_write_enable        = 1;
                            end

            // LW-type (I-type) instruction (load value from data memory into reg file registers)
            7'b0000011  :   begin
                                branch                  = 0;
                                data_mem_read_enable    = 1; 
                                data_mem_write_enable   = 0;
                                mem_to_reg_sel          = 1;
                                alu_op                  = 2'b01;   // LW-type
                                alu_source_sel          = 1;       // source is imm instead of rs2_data
                                reg_write_enable        = 1;
                            end
            // S-type 
            // incl. SW-type instruction (store value from reg file in data memory)
            7'b0100011  :   begin
                                branch                  = 0;
                                data_mem_read_enable    = 0; 
                                data_mem_write_enable   = 1;
                                mem_to_reg_sel          = 1;
                                alu_op                  = 2'b11;   // SW-type
                                alu_source_sel          = 1;       // source is imm instead of rs2_data
                                reg_write_enable        = 0;
                            end

            default     :   begin
                                branch                  = 1'bx;
                                data_mem_read_enable    = 1'bx;
                                data_mem_write_enable   = 1'bx;
                                mem_to_reg_sel          = 1'bx;
                                alu_op                  = 2'bxx;            
                                alu_source_sel          = 1'bx;             
                                reg_write_enable        = 1'bx;
                            end
        endcase
    end
    

endmodule