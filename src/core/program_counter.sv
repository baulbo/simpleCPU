module ProgramCounter(
    input clk,
    input rst,
    input [31:0] pc_i,
    output [31:0] pc_o
);

    reg [31:0] next_pc;
    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            next_pc = 0;
        end else
            next_pc <= pc_i;
    end

    assign pc_o = next_pc;

endmodule
