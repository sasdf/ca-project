module Sign_Extend(
    data_i,
    data_o
);

// Ports
input  [15:0] data_i;
output [31:0] data_o;

// Wires & Registers
reg    [31:0] data_o;

always@(data_i)
begin
    data_o <= { {16{data_i[15]}}, data_i };
end

endmodule
