module ALUControl(
    funct_i,
    aluop_i,
    aluctrl_o
);

// Ports
input  [5:0] funct_i;
input  [1:0] aluop_i;
output [2:0] aluctrl_o;

// Wires & Registers
reg    [2:0] aluctrl_o;

always@(funct_i, aluop_i)
begin
    case (aluop_i)
		// R-type
        2'b11:
            begin
                case (funct_i)
                    6'b100000: aluctrl_o = 3'b010; // add
                    6'b100010: aluctrl_o = 3'b110; // sub
                    6'b100100: aluctrl_o = 3'b000; // and
                    6'b100101: aluctrl_o = 3'b001; // or
                    6'b011000: aluctrl_o = 3'b011; // mul
                endcase
            end
		// Or
		2'b00: aluctrl_o = 3'b001;
		// add
		2'b01: aluctrl_o = 3'b010;
		// subtract
		2'b10: aluctrl_o = 3'b110;
    endcase
end

endmodule
