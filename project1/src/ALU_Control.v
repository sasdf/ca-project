module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

// Ports
input  [5:0] funct_i;
input  [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;

// Wires & Registers
reg    [2:0] ALUCtrl_o;

always@(funct_i, ALUOp_i)
begin
    case (ALUOp_i)
		// R-type
        2'b11:
            begin
                case (funct_i)
                    6'b100000: ALUCtrl_o = 3'b010; // add
                    6'b100010: ALUCtrl_o = 3'b110; // sub
                    6'b100100: ALUCtrl_o = 3'b000; // and
                    6'b100101: ALUCtrl_o = 3'b001; // or
                    6'b011000: ALUCtrl_o = 3'b011; // mul
                endcase
            end
		// Or
		2'b00: ALUCtrl_o = 3'b001;
		// Add
		2'b01: ALUCtrl_o = 3'b010;
		// Subtract
		2'b10: ALUCtrl_o = 3'b110;
    endcase
end

endmodule
