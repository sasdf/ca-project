module MEM_WB
(
    clk_i,
    RegWrite_i,
    Result_i,
    Data_i,
    RD_i,
    ALUSrc_o,
    MemtoReg_o,
    RegWrite_o,
    MemWrite_o,
    Result_o,
    Data_o
    RD_o,
);

input clk_i;

input RegWrite_i;
input [31:0] Resulti;
input [31:0] Data_i,
input [4:0] RD_i;
output RegWrite_o;
output [31:0] Result_o;
output [31:0] Data_o,
output [4:0] RD_o;

reg RegWrite_r;
reg [31:0] Result_r;
reg [31:0] Data_r,
reg [4:0] RD_r;

assign RegWrite_o = RegWrite_r;
assign Result_o = Result_r;
assign Data_o = Data_r;
assign RD_o = RD_r;

always@(posedge clk_i) begin
    RegWrite_r = RegWrite_i;
    Result_r = Result_i;
    Data_r = Data_i;
    RD_r = RD_i;
end
endmodule
