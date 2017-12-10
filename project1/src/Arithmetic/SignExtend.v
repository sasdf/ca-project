module SignExtend(
    extop_i,
    data_i,
    data_o
);

input		  extop_i;
input  [15:0] data_i;
output [31:0] data_o;

assign data_o = { {16{data_i[15]&extop_i}}, data_i };

endmodule
