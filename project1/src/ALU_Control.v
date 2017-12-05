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
        2'b11:
            begin
                case (funct_i)
                    6'b100000: ALUCtrl_o = 3'b010;
                    6'b100010: ALUCtrl_o = 3'b110;
                    6'b100100: ALUCtrl_o = 3'b000;
                    6'b100101: ALUCtrl_o = 3'b001;
                    6'b011000: ALUCtrl_o = 3'b011; // mul
                endcase
            end
        2'b00: ALUCtrl_o = 3'b010;
    endcase
end

endmodule
