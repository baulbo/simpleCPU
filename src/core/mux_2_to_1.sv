module Mux2to1 (
    input sel,
    input [31:0] s0,
    input [31:0] s1,
    output [31:0] out
);

    assign out = (sel) ? s1 : s0;

endmodule