module MUX8
(
	ID_EX_nop_i,
	control_i,
	data_o
);

input  [7:0]	control_i;
input			ID_EX_nop_i;
output [7:0]	data_o;

assign data_o = (
	(ID_EX_nop_i == 0)? control_i:
	8'b0
);
endmodule
