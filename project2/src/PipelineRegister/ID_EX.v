module ID_EX
(
    clk_i,
    regdst_i,
    alusrc_i,
    memtoreg_i,
    regwrite_i,
	memread_i,
    memwrite_i,
    aluop_i,
    RS_i,
    RT_i,
    signextend_i,
    RSaddr_i,
    RTaddr_i,
    RDaddr_i,
    stall_i,
    regdst_o,
    alusrc_o,
    memtoreg_o,
    regwrite_o,
	memread_o,
    memwrite_o,
    aluop_o,
    RS_o,
    RT_o,
    signextend_o,
    RSaddr_o,
    RTaddr_o,
    RDaddr_o,
);

input clk_i;

input				regdst_i;
input				alusrc_i; 
input				memtoreg_i; 
input				regwrite_i; 
input				memread_i; 
input				memwrite_i;
input				stall_i;
input [1:0]			aluop_i;
input [31:0]		RS_i;
input [31:0]		RT_i;
input [31:0]		signextend_i;
input [4:0]			RSaddr_i;
input [4:0]			RTaddr_i;
input [4:0]			RDaddr_i;

output reg 			regdst_o; 
output reg			alusrc_o; 
output reg			memtoreg_o; 
output reg			regwrite_o = 0; 
output reg			memread_o = 0;
output reg			memwrite_o = 0;
output reg [1:0]	aluop_o;
output reg [31:0]	RS_o; 
output reg [31:0]	RT_o; 
output reg [31:0]	signextend_o;
output reg [4:0]	RSaddr_o; 
output reg [4:0]	RTaddr_o; 
output reg [4:0]	RDaddr_o;

always@(posedge clk_i) begin
    if (stall_i) begin
    end
    else begin
        regdst_o		<= regdst_i;
        alusrc_o		<= alusrc_i;
        memtoreg_o		<= memtoreg_i;
        regwrite_o		<= regwrite_i;
        memread_o		<= memread_i;
        memwrite_o		<= memwrite_i;
        aluop_o			<= aluop_i;
        RS_o			<= RS_i;
        RT_o			<= RT_i;
        signextend_o	<= signextend_i;
        RSaddr_o		<= RSaddr_i;
        RTaddr_o		<= RTaddr_i;
        RDaddr_o		<= RDaddr_i;
    end
end
endmodule
