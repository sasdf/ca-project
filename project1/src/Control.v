module Control(
    Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input  [5:0]     Op_i;
output RegDst_o, ALUSrc_o, RegWrite_o;
output [1:0]     ALUOp_o;

// Wires & Registers
reg    RegDst_o, ALUSrc_o, RegWrite_o;
reg    [1:0]     ALUOp_o;

always@(Op_i)
begin 
    case (Op_i)
        6'b000000:
            begin
                RegDst_o   = 1'b1;
                ALUSrc_o   = 1'b0;
                RegWrite_o = 1'b1;
                ALUOp_o    = 2'b11;
            end
        6'b001000:
            begin
                RegDst_o   = 1'b0;
                ALUSrc_o   = 1'b1;
                RegWrite_o = 1'b1;
                ALUOp_o    = 2'b00;
            end
    endcase
end

endmodule
