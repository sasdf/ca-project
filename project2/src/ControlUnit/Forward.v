module Forward
(
    MEM_WB_regwrite_i,
    EX_MEM_regwrite_i,
    MEM_WB_RD_i,
    EX_MEM_RD_i,
    ID_EX_RS_i,
    ID_EX_RT_i,
    forward_RS_o,
    forward_RT_o
);

input				MEM_WB_regwrite_i;
input				EX_MEM_regwrite_i;
input  [4:0]		MEM_WB_RD_i;
input  [4:0]		EX_MEM_RD_i;
input  [4:0]		ID_EX_RS_i;
input  [4:0]		ID_EX_RT_i;
output [1:0]        forward_RS_o;
output [1:0]        forward_RT_o;

wire memRS ;
wire wbRS ;
wire memRT ;
wire wbRT ;

assign memRS = EX_MEM_regwrite_i && EX_MEM_RD_i != 0 && EX_MEM_RD_i == ID_EX_RS_i ;
assign wbRS  = MEM_WB_regwrite_i && MEM_WB_RD_i != 0 && MEM_WB_RD_i == ID_EX_RS_i ;
assign memRT = EX_MEM_regwrite_i && EX_MEM_RD_i != 0 && EX_MEM_RD_i == ID_EX_RT_i ;
assign wbRT  = MEM_WB_regwrite_i && MEM_WB_RD_i != 0 && MEM_WB_RD_i == ID_EX_RT_i ;

assign forward_RS_o = memRS ? 2'd2 : wbRS ? 2'd1 : 2'd0 ;
assign forward_RT_o = memRT ? 2'd2 : wbRT ? 2'd1 : 2'd0 ;

endmodule
