module Adder(
    data1_i,
    data2_i,
    data_o,
);

// Ports
input  [31:0] data1_in, data2_in;
output [31:0] data_o;

assign data_o = data1_in + data2_in;

endmodule
