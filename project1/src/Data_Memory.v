module Data_Memory
(
    clk_i,
    MemWrite_i,
    MemRead_i,
    addr_i,
    data_i,
    data_o,
);

// Interface
input               clk_i,MemWrite_i,MemRead_i;
input   [31:0]      addr_i, data_i;
output  [31:0]      data_o;

// Instruction memory
reg     [7:0]     memory  [0:32];

assign  data_o = {memory[addr_i+3],memory[addr_i+2],memory[addr_i+1],memory[addr_i]};

always@(posedge clk_i) begin
    if (MemWrite_i) begin
        memory[addr_i+3] <= data_i[31:24];
        memory[addr_i+2] <= data_i[23:16];
        memory[addr_i+1] <= data_i[15: 8];
        memory[addr_i]   <= data_i[ 7: 0];
    end
end
endmodule
