module Control(
	op_i,
	regdst_o,
	alusrc_o,
	memtoreg_o,
	regwrite_o,
	memread_o,
	memwrite_o,
	branch_o,
	jump_o,
	extop_o,
	aluop_o,
);

input  [5:0]	op_i;
output			regdst_o;
output			alusrc_o; 
output			memtoreg_o; 
output			regwrite_o; 
output			memread_o; 
output			memwrite_o; 
output			branch_o; 
output			jump_o; 
output			extop_o;
output [1:0]    aluop_o;

wire [10:0] tbl[0:63];
assign tbl[6'b000000] = 11'b10010000x11;
assign tbl[6'b001000] = 11'b01010000001;
assign tbl[6'b100011] = 11'b01111000101;
assign tbl[6'b101011] = 11'bx1x00100101;
assign tbl[6'b000100] = 11'bx0x00010x10;
assign tbl[6'b000010] = 11'bxxx00001xxx;

assign {
	regdst_o,
	alusrc_o,
	memtoreg_o,
	regwrite_o,
	memread_o,
	memwrite_o,
	branch_o,
	jump_o,
	extop_o,
	aluop_o} 
= tbl[op_i];

endmodule
