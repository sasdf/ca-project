module HazardDetection
(
	ID_EX_MemRead_i,
	ID_EX_RT_i,
	IF_ID_RS_i,
	IF_ID_RT_i,
	ID_EX_NOP_o,
	IF_ID_Write_o,
	PC_Write_o
);

input ID_EX_MemRead_i;
input [4:0] ID_EX_RT_i, IF_ID_RS_i, IF_ID_RT_i;
output ID_EX_NOP_o, IF_ID_Write_o, PC_Write_o;

reg ID_EX_NOP_o, IF_ID_Write_o, PC_Write_o;

always@(ID_EX_MemRead_i, ID_EX_RT_i, IF_ID_RS_i, IF_ID_RT_i)
begin
	if (ID_EX_MemRead_i && (ID_EX_RT_i == IF_ID_RS_i || ID_EX_RT_i == IF_ID_RT_i))
	begin
		ID_EX_NOP_o = 1'b1;
		IF_ID_Write_o = 1'b0;
		PC_Write_o = 1'b0;
	end
	else
	begin
		ID_EX_NOP_o = 1'b0;
		IF_ID_Write_o = 1'b1;
		PC_Write_o = 1'b1;
	end
end
endmodule
