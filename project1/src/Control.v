module Control(
	Op_i,
	RegDst_o,
	ALUSrc_o,
	MemtoReg_o,
	RegWrite_o,
	MemRead_o,
	MemWrite_o,
	Branch_o,
	Jump_o,
	ExtOp_o,
	ALUOp_o,
);

input  [5:0]     Op_i;
output RegDst_o, ALUSrc_o, MemtoReg_o, RegWrite_o, MemRead_o, MemWrite_o, Branch_o, Jump_o, ExtOp_o;
output [1:0]     ALUOp_o;

wire [10:0] tbl[0:63];
assign tbl[6'b000000] = 11'b10010000x11;
assign tbl[6'b001000] = 11'b01010000001;
assign tbl[6'b100011] = 11'b01111000101;
assign tbl[6'b101011] = 11'bx1x00100101;
assign tbl[6'b000100] = 11'bx0x00010x10;
assign tbl[6'b000010] = 11'bxxx00001xxx;

assign {RegDst_o,ALUSrc_o,MemtoReg_o,RegWrite_o,MemRead_o,MemWrite_o,Branch_o,Jump_o,ExtOp_o,ALUOp_o} = tbl[Op_i];

endmodule
