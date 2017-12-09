module MEM_WB
(
    clk_i,
    MemtoReg_i,
    RegWrite_i,
    Data_i,
    Result_i,
    RD_i,
    MemtoReg_o,
    RegWrite_o,
    Data_o,
    Result_o,
    RD_o,
);

input clk_i;
input MemtoReg_i;
input RegWrite_i;
input [31:0] Result_i;
input [31:0] Data_i;
input [4:0] RD_i;

output reg MemtoReg_o = 1'b0;
output reg RegWrite_o = 1'b0;
output reg [31:0] Result_o = 32'b0;
output reg [31:0] Data_o = 32'b0;
output reg [4:0] RD_o = 32'b0;

always@(posedge clk_i) begin
    MemtoReg_o <= MemtoReg_i;
	if(RegWrite_i == 1'b1 || RegWrite_i == 1'b0) begin
		RegWrite_o <= RegWrite_i;
		RD_o <= RD_i;
		Data_o <= Data_i;
		Result_o <= Result_i;
	end
end
endmodule
