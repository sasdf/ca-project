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
output reg [1:0]    forward_RS_o;
output reg [1:0]    forward_RT_o;

always@(*)
begin 
    if (EX_MEM_regwrite_i
        && EX_MEM_RD_i != 0
        && EX_MEM_RD_i == ID_EX_RS_i)
        forward_RS_o[1] = 1'b1;
    else
        forward_RS_o[1] = 1'b0;

    if (EX_MEM_regwrite_i
        && EX_MEM_RD_i != 0
        && EX_MEM_RD_i == ID_EX_RT_i)
        forward_RT_o[1] = 1'b1;
    else
        forward_RT_o[1] = 1'b0;

    if (MEM_WB_regwrite_i
        && MEM_WB_RD_i != 0
        && EX_MEM_RD_i != ID_EX_RS_i
        && MEM_WB_RD_i == ID_EX_RS_i)
        forward_RS_o[0] = 1'b1;
    else
        forward_RS_o[0] = 1'b0;

    if (MEM_WB_regwrite_i
        && MEM_WB_RD_i != 0
        && EX_MEM_RD_i != ID_EX_RT_i
        && MEM_WB_RD_i == ID_EX_RT_i)
        forward_RT_o[0] = 1'b1;
    else
        forward_RT_o[0] = 1'b0;
end

endmodule
