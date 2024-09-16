
module Core (
    input clk,
    input rst, // active low reset
    output [31:0] current_instructions,
    output [1:0] alu_op_out,
    output wire [31:0] out1,
    output wire [31:0] out2,
    output wire [31:0] alu_mux_out_wire,
    output wire [31:0] write_register
);

    // multiplexer between the 2 adders (+4 increment or branch/ jump)
    wire [31:0] adder_mux_o; 
    wire [31:0] adder_o;
    Mux2to1 adder_mux (
        .sel(1'b0), // NOTE: this is hardwired because the BEQ instruction is not implemented
        .s0(adder_o),
        .s1(32'd0), // NOTE: ^^ 
        .out(adder_mux_o)
    );
    
    wire [31:0] pc_wire;
    ProgramCounter pc(
        .clk(clk),
        .rst(rst),
        .pc_i(adder_mux_o),
        .pc_o(pc_wire)
    );

    // FIXME: the adder results in segmentation fault, probably because it keeps adding... 
    //  connects all other modules together.
    Adder adder ( // calculates the address of next instruction
        .a(pc_wire),
        .b(32'd1), 
        .sum(adder_o) // should output next instr address
    );

    wire [31:0] program_mem_o_wire;
    ProgramMemory program_mem (
        .addr(pc_wire), 
        .instr(program_mem_o_wire)
    );
    assign current_instructions = program_mem_o_wire;

    wire branch_wire;
    wire data_mem_read_enable_wire;
    wire data_mem_write_enable_wire;
    wire mem_to_reg_sel_wire;
    wire [1:0] alu_op_wire;      
    wire alu_source_sel_wire;   
    wire reg_write_enable_wire;
    Control control (.opcode(program_mem_o_wire[6:0]), 
                    .branch(branch_wire), 
                    .data_mem_read_enable(data_mem_read_enable_wire),
                    .data_mem_write_enable(data_mem_write_enable_wire), 
                    .mem_to_reg_sel(mem_to_reg_sel_wire),
                    .alu_op(alu_op_wire), 
                    .alu_source_sel(alu_source_sel_wire), 
                    .reg_write_enable(reg_write_enable_wire)
    );
    assign alu_op_out = alu_op_wire;

    wire [31:0] write_data_wire;
    wire [31:0] rs1_data_wire;
    wire [31:0] rs2_data_wire;
    assign write_register = program_mem_o_wire[11:7];
    RegisterFile register_file (.clk(clk), .rst(rst), .we(reg_write_enable_wire),
                                .rs1_addr(program_mem_o_wire[19:15]), 
                                .rs2_addr(program_mem_o_wire[24:20]),
                                .rd_addr(program_mem_o_wire[11:7]),
                                .write_data(write_data_wire),
                                .rs1_data(rs1_data_wire),
                                .rs2_data(rs2_data_wire)
    );
    wire [3:0] alu_control_wire;
    ALUControl alu_control_unit (.alu_op(alu_op_wire),
                                .funct3(program_mem_o_wire[14:12]), 
                                .funct7(program_mem_o_wire[30]),
                                .alu_control(alu_control_wire)
    );

    wire [31:0] imm_gen_o;
    ImmGenerator imm_generator (.instr(program_mem_o_wire),
                                .imm(imm_gen_o)
    );

    wire [31:0] alu_in_mux_o; 
    Mux2to1 alu_in_mux (
        .sel(alu_source_sel_wire),
        .s0(rs2_data_wire),
        .s1(imm_gen_o), 
        .out(alu_in_mux_o)
    );

    assign out1 = rs1_data_wire;
    assign out2 = alu_in_mux_o;

    wire zero_wire;
    wire [31:0] alu_result_wire;
    ALU alu (.alu_control(alu_control_wire),
            .a(rs1_data_wire), .b(alu_in_mux_o), 
            .result(alu_result_wire), 
            .zero(zero_wire)
    );

    reg [31:0] data_memory_data_o_wire;
    DataMemory data_memory (.clk(clk),
                            .rst(rst),
                            .addr(alu_result_wire),
                            .we(data_mem_write_enable_wire),
                            .re(data_mem_read_enable_wire),
                            .write_data(rs2_data_wire),
                            .read_data(data_memory_data_o_wire)
    );

    // write-back (after ALU)
    Mux2to1 alu_out_mux (
        .sel(mem_to_reg_sel_wire),
        .s0(alu_result_wire),
        .s1(data_memory_data_o_wire),
        .out(write_data_wire)
    );

    assign alu_mux_out_wire = write_data_wire;

endmodule