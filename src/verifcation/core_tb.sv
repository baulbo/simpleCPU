module core_test; 

    // clock
    reg clk = 0;
    always #5 clk = !clk;

    // modules
    reg rst = 1'b1; // active low reset

    wire [31:0] full_instr;
    wire [1:0] alu_op_out;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] alu_mux_out_wire;
    wire [31:0] write_register;
    Core core ( .clk(clk), .rst(rst), 
                .current_instructions(full_instr), 
                .alu_op_out(alu_op_out),
                // register file in- and outputs
                .out1(read_data1),
                .out2(read_data2),
                .write_register(write_register),
                .alu_mux_out_wire(alu_mux_out_wire)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, core_test);

        rst = 1'b0;
        #10 rst = 1'b1;

        #100; // let 100 / 10 instructions execute.
        $finish();
    end
endmodule
