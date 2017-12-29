module IF_ID
(
    clk_i,
    flush_i,
    hazard_i,
    pc_i,
    instr_i,
    stall_i,
    pc_o,
    instr_o,
);

input				clk_i;
input				flush_i;
input				hazard_i;
input				stall_i;
input [31:0]		pc_i;
input [31:0]		instr_i;

output reg [31:0]	pc_o = 32'd0;
output reg [31:0]	instr_o = 32'd0;

always@(posedge clk_i) 
begin
    if (~stall_i) begin
        pc_o	<= flush_i ? 32'b0 : hazard_i ? pc_o	: pc_i;
        instr_o <= flush_i ? 32'b0 : hazard_i ? instr_o : instr_i;
    end
end
endmodule
