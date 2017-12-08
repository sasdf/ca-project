module ID_EX
(
    clk_i,
    RegDst_i,
    ALUSrc_i,
    MemtoReg_i,
    RegWrite_i,
	MemRead_i,
    MemWrite_i,
    ALUop_i,
    RS_i,
    RT_i,
    SignExtend_i,
    instr_i,
    RegDst_o,
    ALUSrc_o,
    MemtoReg_o,
    RegWrite_o,
	MemRead_o,
    MemWrite_o,
    ALUop_o,
    RS_o,
    RT_o,
    SignExtend_o,
    instr_o,
);

input clk_i;

input RegDst_i;
input ALUSrc_i;
input MemtoReg_i;
input RegWrite_i;
input MemRead_i;
input MemWrite_i;
input ALUop_i;
input [31:0] RS_i;
input [31:0] RT_i;
input [31:0] SignExtend_i;
input [25:11] instr_i;
output RegDst_o;
output ALUSrc_o;
output MemtoReg_o;
output RegWrite_o;
output MemRead_o;
output MemWrite_o;
output ALUop_o;
output [31:0] RS_o;
output [31:0] RT_o;
output [31:0] SignExtend_o;
output [25:11] instr_o;

reg RegDst_r;
reg ALUSrc_r;
reg MemtoReg_r;
reg RegWrite_r;
reg MemRead_r;
reg MemWrite_r;
reg ALUop_r;
reg [31:0] RS_r;
reg [31:0] RT_r;
reg [31:0] SignExtend_r;
reg [25:11] instr_r;

assign RegDst_o = RegDst_r;
assign ALUSrc_o = ALUSrc_r;
assign MemtoReg_o = MemtoReg_r;
assign RegWrite_o = RegWrite_r;
assign MemRead_o  = MemRead_r;
assign MemWrite_o = MemWrite_r;
assign ALUop_o = ALUop_r;
assign RS_o = RS_r;
assign RT_o = RT_r;
assign SignExtend_o = SignExtend_r;
assign instr_o = instr_r;

always@(posedge clk_i) begin
    RegDst_r <= RegDst_i;
    ALUSrc_r <= ALUSrc_i;
    MemtoReg_r <= MemtoReg_i;
    RegWrite_r <= RegWrite_i;
	MemRead_r <= MemRead_i;
    MemWrite_r <= MemWrite_i;
    ALUop_r <= ALUop_i;
    RS_r <= RS_i;
    RT_r <= RT_i;
    SignExtend_r <= SignExtend_i;
    instr_r <= instr_i;
end
endmodule
