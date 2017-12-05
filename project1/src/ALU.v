module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    ForwardRs_i,
    ForwardRt_i,
    ExData_i,
    MemData_i,
    data_o
);

// Ports
input  [31:0] data1_i, data2_i, ExData_i, MemData_i;
input  [ 2:0] ALUCtrl_i, ForwardRs_i, ForwardRt_i;
output [31:0] data_o;

// Wires & Registers
reg    [31:0] data1, data2;
reg    [31:0] data_o;

always@(data1_i, data2_i, ALUCtrl_i, ForwardRs_i, ForwardRt_i, ExData_i, MemData_i)
begin
    if (ForwardRs_i[1])
        data1 = ExData_i;
    else if (ForwardRs_i[0])
        data1 = MemData_i;
    else 
        data1 = data1_i;

    if (ForwardRt_i[1])
        data2 = ExData_i;
    else if (ForwardRt_i[0])
        data2 = MemData_i;
    else 
        data2 = data2_i;

    case (ALUCtrl_i)
        3'b000:  data_o = data1 & data2; // and
        3'b001:  data_o = data1 | data2; // or
        3'b010:  data_o = data1 + data2; // add
        3'b110:  data_o = data1 - data2; // sub
        3'b011:  data_o = data1 * data2; // mul
    endcase
end

endmodule
