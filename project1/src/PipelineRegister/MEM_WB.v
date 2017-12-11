module MEM_WB
(
    clk_i,
    memtoreg_i,
    regwrite_i,
    data_i,
    result_i,
    RD_i,
    memtoreg_o,
    regwrite_o,
    data_o,
    result_o,
    RD_o,
);

input				clk_i;
input				memtoreg_i;
input				regwrite_i;
input [31:0]		result_i;
input [31:0]		data_i;
input [4:0]			RD_i;

output reg			memtoreg_o = 1'b0;
output reg			regwrite_o = 1'b0;
output reg [31:0]	result_o = 32'b0;
output reg [31:0]	data_o = 32'b0;
output reg [4:0]	RD_o = 5'b0;

always@(posedge clk_i) begin
    memtoreg_o <= memtoreg_i;
	if(regwrite_i == 1'b1 || regwrite_i == 1'b0) begin
		regwrite_o	<= regwrite_i;
		RD_o		<= RD_i;
		data_o		<= data_i;
		result_o	<= result_i;
	end
end
endmodule
