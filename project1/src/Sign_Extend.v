module Sign_Extend(
    ExtOp_i,
    data_i,
    data_o
);

input         ExtOp_i;
input  [15:0] data_i;
output [31:0] data_o;

assign data_o = { {16{data_i[15]&ExtOp_i}}, data_i };

endmodule
