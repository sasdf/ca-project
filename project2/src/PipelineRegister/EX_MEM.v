module EX_MEM
(
    clk_i,
    memtoreg_i,
    regwrite_i,
    memwrite_i,
    result_i,
    data_i,
    RD_i,
    memtoreg_o,
    regwrite_o,
    memwrite_o,
    result_o,
    data_o,
    RD_o,
);

input clk_i;

input				memtoreg_i;
input				regwrite_i;
input				memwrite_i;
input [31:0]		result_i;
input [31:0]		data_i;
input [4:0]			RD_i;

output reg 			memtoreg_o; 
output reg			regwrite_o = 0;
output reg			memwrite_o = 0;
output reg [31:0]	result_o;
output reg [31:0]	data_o;
output reg [4:0]	RD_o;

always@(posedge clk_i) begin
    memtoreg_o	<=	memtoreg_i;
    regwrite_o	<=	regwrite_i;
    memwrite_o	<=	memwrite_i;
    result_o	<=	result_i;
    data_o		<=	data_i;
    RD_o		<=	RD_i;
end
endmodule
