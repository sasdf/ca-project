module HazardDetection
(
	ID_EX_memread_i,
	ID_EX_RT_i,
	IF_ID_RS_i,
	IF_ID_RT_i,
	ID_EX_nop_o,
	IF_ID_write_o,
	pc_write_o
);

input		ID_EX_memread_i;
input [4:0] ID_EX_RT_i;
input [4:0]	IF_ID_RS_i;
input [4:0]	IF_ID_RT_i;

output reg	ID_EX_nop_o;
output reg	IF_ID_write_o;
output reg	pc_write_o;

always@(*)
begin
	if (ID_EX_memread_i && (ID_EX_RT_i == IF_ID_RS_i || ID_EX_RT_i == IF_ID_RT_i))
	begin
		ID_EX_nop_o = 1'b1;
		IF_ID_write_o = 1'b0;
		pc_write_o = 1'b0;
	end
	else
	begin
		ID_EX_nop_o = 1'b0;
		IF_ID_write_o = 1'b1;
		pc_write_o = 1'b1;
	end
end
endmodule
