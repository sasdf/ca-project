module PC
(
    clk_i,
    rst_i,
    start_i,
    pc_i,
	pc_write_i,
    pc_o
);

// ports
input               clk_i;
input               rst_i;
input               start_i;
input				pc_write_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// wires, registers
reg     [31:0]      pc_o;


always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        pc_o <= 32'b0;
    end
    else begin
        if((start_i && pc_write_i == 1) || (pc_write_i != 1 && pc_write_i != 0))
            pc_o <= pc_i;
        else if(pc_write_i == 0)
            pc_o <= pc_o;
    end
end

endmodule
