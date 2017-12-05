module Forward(
    MemRegisterRd_i,
    MemRegWrite_i,
    ExRegWrite_i,
    ExRegisterRd_i,
    IdRs_i,
    IdRt_i,
    ForwardRs_o,
    ForwardRt_o
);

// Ports
input            MemRegWrite_i, ExRegWrite_i;
input  [4:0]     MemRegisterRd_i, ExRegisterRd_i, IdRs_i, IdRt_i;
output [2:0]     ForwardRs_o, ForwardRt_o;

// Wires & Registers
reg    [2:0]     ForwardRs_o, ForwardRt_o;

always@(*)
begin 
    if (ExRegWrite_i
        && ExRegisterRd_i != 0
        && ExRegisterRd_i == IdRs_i
        )
        ForwardRs_o[1] = 1'b1;
    else
        ForwardRs_o[1] = 1'b0;

    if (ExRegWrite_i
        && ExRegisterRd_i != 0
        && ExRegisterRd_i == IdRt_i
        )
        ForwardRt_o[1] = 1'b1;
    else
        ForwardRt_o[1] = 1'b0;

    if (MemRegWrite_i
        && MemRegisterRd_i != 0
        && ExRegisterRd_i != IdRs_i
        && MemRegisterRd_i == IdRs_i
        )
        ForwardRs_o[0] = 1'b1;
    else
        ForwardRs_o[0] = 1'b0;

    if (MemRegWrite_i
        && MemRegisterRd_i != 0
        && ExRegisterRd_i != IdRt_i
        && MemRegisterRd_i == IdRt_i
        )
        ForwardRt_o[0] = 1'b1;
    else
        ForwardRt_o[0] = 1'b0;
end

endmodule
