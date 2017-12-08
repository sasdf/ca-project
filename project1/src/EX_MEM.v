module EX_MEM
(
    clk_i,
    MemtoReg_i,
    RegWrite_i,
    MemWrite_i,
    Result_i,
    Data_i,
    RD_i,
    MemtoReg_o,
    RegWrite_o,
    MemWrite_o,
    Result_o,
    Data_o,
    RD_o,
);

input clk_i;

input MemtoReg_i;
input RegWrite_i;
input MemWrite_i;
input [31:0] Result_i;
input [31:0] Data_i;
input [4:0] RD_i;
output MemtoReg_o;
output RegWrite_o;
output MemWrite_o;
output [31:0] Result_o;
output [31:0] Data_o;
output [4:0] RD_o;

reg MemtoReg_r;
reg RegWrite_r;
reg MemWrite_r;
reg [31:0] Result_r;
reg [31:0] Data_r;
reg [4:0] RD_r;

assign MemtoReg_o = MemtoReg_r;
assign RegWrite_o = RegWrite_r;
assign MemWrite_o = MemWrite_r;
assign Result_o = Result_r;
assign Data_o = Data_r;
assign RD_o = RD_r;

always@(posedge clk_i) begin
    MemtoReg_r <= MemtoReg_i;
    RegWrite_r <= RegWrite_i;
    MemWrite_r <= MemWrite_i;
    Result_r <= Result_i;
    Data_r <= Data_i;
    RD_r <= RD_i;
end
endmodule
