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

// Ports
input  [5:0]     Op_i;
output RegDst_o, ALUSrc_o, MemtoReg_o, RegWrite_o, MemRead_o, MemWrite_o, Branch_o, Jump_o, ExtOp_o;
output [1:0]     ALUOp_o;

// Wires & Registers
reg    RegDst_o, ALUSrc_o, MemtoReg_o, RegWrite_o, MemRead_o, MemWrite_o, Branch_o, Jump_o, ExtOp_o;
reg    [1:0]     ALUOp_o;

always@(Op_i)
begin 
    case (Op_i)
		// R-type (ALUop = 2'b11)
        6'b000000:
		begin
			RegDst_o   = 1'b1;
			ALUSrc_o   = 1'b0;
			MemtoReg_o = 1'b0;
			RegWrite_o = 1'b1;
			MemRead_o  = 1'b0;
			MemWrite_o = 1'b0;
			Branch_o   = 1'b0;
			Jump_o     = 1'b0;
			// ExtOp_o    = don't care
			ALUOp_o    = 2'b11;
		end
		// ori (ALUop = 2'b00)
		6'b001101:
		begin
			RegDst_o   = 1'b0;
			ALUSrc_o   = 1'b1;
			MemtoReg_o = 1'b0;
			RegWrite_o = 1'b1;
			MemRead_o  = 1'b0;
			MemWrite_o = 1'b0;
			Branch_o   = 1'b0;
			Jump_o     = 1'b0;
			ExtOp_o    = 1'b0;
			ALUOp_o    = 2'b00;
		end
		// lw (ALUop = 2'b01)
        6'b100011:
		begin
			RegDst_o   = 1'b0;
			ALUSrc_o   = 1'b1;
			MemtoReg_o = 1'b1;
			RegWrite_o = 1'b1;
			MemRead_o  = 1'b1;
			MemWrite_o = 1'b0;
			Branch_o   = 1'b0;
			Jump_o     = 1'b0;
			ExtOp_o    = 1'b1;
			ALUOp_o    = 2'b01;
		end
		// sw (ALUop = 2'b01)
		6'b101011:
		begin
			// RegDst_o   = don't care
			ALUSrc_o   = 1'b1;
			// MemtoReg_o = don't care
			RegWrite_o = 1'b0;
			MemRead_o  = 1'b0;
			MemWrite_o = 1'b1;
			Branch_o   = 1'b0;
			Jump_o     = 1'b0;
			ExtOp_o    = 1'b1;
			ALUOp_o    = 2'b01;
		end
		// beq (ALUop = 2'b10)
		6'b000100:
		begin
			// RegDst_o   = don't care
			ALUSrc_o   = 1'b0;
			// MemtoReg_o = don't care
			RegWrite_o = 1'b0;
			MemRead_o  = 1'b0;
			MemWrite_o = 1'b0;
			Branch_o   = 1'b1;
			Jump_o     = 1'b0;
			// ExtOp_o    = don't care
			ALUop_o    = 2'b10;
		end
		// jump (ALUop = don't care)
		6'b000010:
		begin
			// RegDst_o   = don't care
			// ALUSrc_o   = don't care
			// MemtoReg_o = don't care
			RegWrite_o = 1'b0;
			MemRead_o  = 1'b0;
			MemWrite_o = 1'b0;
			Branch_o   = 1'b0;
			Jump_o     = 1'b1;
			// ExtOp_o    = don't care
			// ALUop_o    = don't care
		end
    endcase
end

endmodule
