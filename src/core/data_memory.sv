/*
    Data memory spec:
    ---
    * 32-bit words for simplicity, instead of the traditional 8-bit words, hence lb and lh 
        are not supported, and neither is any other instruction where words smaller than 
        32-bits would be accessed

        Use asm instructions like "lw rx, i", e.g., "lw r1, 1"  where i is the offset in data memory.
        Let's say data memory contains value 32'b0 (first 32 bits) at addr 0, and value 32'd5 at addr 1
        , then it would load value 5 from data memory into r1 of the register file.
    
*/
module DataMemory(
	input clk,
    input rst,
	input [31:0] addr,
	input we,
	input re,
	input [31:0] write_data,
	output reg [31:0] read_data 
);

    reg [31:0] data_mem [0:63];

    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            /* NOTE: we already fill data_mem[1] and data_mem[2] with data */
            data_mem[0] = 32'b0;  data_mem[1] = 32'd1;  data_mem[2] = 32'd0;  data_mem[3] = 32'b0;
            data_mem[4] = 32'd0;  data_mem[5] = 32'b0;  data_mem[6] = 32'b0;  data_mem[7] = 32'b0;
            data_mem[8] = 32'b0;  data_mem[9] = 32'b0;  data_mem[10] = 32'b0; data_mem[11] = 32'b0;
            data_mem[12] = 32'b0; data_mem[13] = 32'b0; data_mem[14] = 32'b0; data_mem[15] = 32'b0;
            data_mem[16] = 32'b0; data_mem[17] = 32'b0; data_mem[18] = 32'b0; data_mem[19] = 32'b0;
            data_mem[20] = 32'b0; data_mem[21] = 32'b0; data_mem[22] = 32'b0; data_mem[23] = 32'b0;
            data_mem[24] = 32'b0; data_mem[25] = 32'b0; data_mem[26] = 32'b0; data_mem[27] = 32'b0;
            data_mem[28] = 32'b0; data_mem[29] = 32'b0; data_mem[30] = 32'b0; data_mem[31] = 32'b0;
            data_mem[32] = 32'b0;  data_mem[33] = 32'b0;  data_mem[34] = 32'b0;  data_mem[35] = 32'b0;
            data_mem[36] = 32'b0;  data_mem[37] = 32'b0;  data_mem[38] = 32'b0;  data_mem[39] = 32'b0;
            data_mem[40] = 32'b0;  data_mem[41] = 32'b0;  data_mem[42] = 32'b0;  data_mem[43] = 32'b0;
            data_mem[44] = 32'b0;  data_mem[45] = 32'b0;  data_mem[46] = 32'b0;  data_mem[47] = 32'b0;
            data_mem[48] = 32'b0;  data_mem[49] = 32'b0;  data_mem[50] = 32'b0;  data_mem[51] = 32'b0;
            data_mem[52] = 32'b0;  data_mem[53] = 32'b0;  data_mem[54] = 32'b0;  data_mem[55] = 32'b0;
            data_mem[56] = 32'b0;  data_mem[57] = 32'b0;  data_mem[58] = 32'b0;  data_mem[59] = 32'b0;
            data_mem[60] = 32'b0;  data_mem[61] = 32'b0;  data_mem[62] = 32'b0;  data_mem[63] = 32'b0;
        end else if (we) begin 
            // write enabled
            data_mem[addr] <= write_data;
        end
    end

    always @(*) begin
        if (re) begin
            read_data = data_mem[addr];
        end else begin
            read_data = 32'b0;
        end

        
    end

endmodule