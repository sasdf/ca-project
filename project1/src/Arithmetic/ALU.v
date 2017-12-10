module ALU(
    data0_i,
    data1_i,
    aluctrl_i,
    data_o
);

input      [31:0] data0_i;
input	   [31:0] data1_i;
input	   [ 2:0] aluctrl_i;
output reg [31:0] data_o;

always@(*)
begin
    case (aluctrl_i)
        3'b000:  data_o = data0_i & data1_i; // and
        3'b001:  data_o = data0_i | data1_i; // or
        3'b010:  data_o = data0_i + data1_i; // add
        3'b110:  data_o = data0_i - data1_i; // sub
        3'b011:  data_o = data0_i * data1_i; // mul
    endcase
end

endmodule
