module IF_ID
(
    clk_i,
    flush_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o,
);

input clk_i;
input [31:0] pc_i;
input [31:0] instr_i;
output [31:0] pc_o;
output [31:0] instr_o;

reg [31:0] pc_r;
reg [31:0] instr_r;

assign pc_o = pc_r;
assign instr_o = instr_r;

always@(posedge clk_i) 
begin
    if(flush_i)
    begin
        pc_r = 0;
        instr_r = 0;
    end
    else
    begin
        pc_r = pc_i;
        instr_r = instr_i;
    end
end
endmodule
