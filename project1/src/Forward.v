module Forward(
    MemR_i,
    MemW_i,
    ExW_i,
    ExR_i,
    IdRs_i,
    IdRt_i,
    ForwardA_o,
    ForwardB_o
);

// Ports
input            MemW_i, ExW_i;
input  [4:0]     MemR_i, ExR_i, IdRs_i, IdRt_i;
output [2:0]     ForwardA_o, ForwardB_o;

// Wires & Registers
reg    [2:0]     ForwardA_o, ForwardB_o;

always@(MemR_i, MemW_i, ExW_i, ExR_i, IdRs_i, IdRt_i)
begin 
    if (ExW_i
        && ExR_i != 0
        && ExR_i == IdRs_i
        )
        ForwardA_o[1] = 1'b1;
    else
        ForwardA_o[1] = 1'b0;

    if (ExW_i
        && ExR_i != 0
        && ExR_i == IdRt_i
        )
        ForwardB_o[1] = 1'b1;
    else
        ForwardB_o[1] = 1'b0;

    if (MemW_i
        && MemR_i != 0
        && ExR_i != IdRs_i
        && MemR_i == IdRs_i
        )
        ForwardA_o[0] = 1'b1;
    else
        ForwardA_o[0] = 1'b0;

    if (MemW_i
        && MemR_i != 0
        && ExR_i != IdRt_i
        && MemR_i == IdRt_i
        )
        ForwardB_o[0] = 1'b1;
    else
        ForwardB_o[0] = 1'b0;
end

endmodule
