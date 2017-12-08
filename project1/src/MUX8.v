module MUX8
(
	ID_EX_NOP_i,
	Control_i,
	data_o
);

input	[7:0] Control_i;
input	ID_EX_NOP_i;
output	[7:0] data_o;

assign data_o = (
	(ID_EX_NOP_i == 0)? Control_i:
	8'b0
);
endmodule
