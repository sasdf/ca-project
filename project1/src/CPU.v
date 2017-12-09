module CPU
(
    clk_i,
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;


Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o),
    .instr_o    ()
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (MUX_Jump.data_o),
    .pc_o       ()
);


Adder Add_PC(
    .data1_i	(PC.pc_o),
    .data2_i	(32'd4),
    .data_o     ()
);


MUX32 MUX_Branch(
	.data1_i	(Add_PC.data_o),
	.data2_i	(Add_Branch.data_o),
	.select_i	((Control.Branch_o & RegisterEq.data_o)),
	.data_o		()
);


IF_ID IF_ID(
	.clk_i		(clk_i),
	.flush_i	((Control.Branch_o & RegisterEq.data_o) | Control.Jump_o),
	.hazard_i	(~HazardDetection.IF_ID_Write_o),
	.pc_i		(PC.pc_o),
	.instr_i	(Instruction_Memory.instr_o),
	.pc_o		(),
	.instr_o	()
);


wire	[31: 0] _instr, _pc;
assign	_instr = IF_ID.instr_o;
assign	_pc = IF_ID.pc_o;


Control Control(
    .Op_i       (_instr[31:26]),
    .RegDst_o   (),
    .ALUSrc_o   (),
	.MemtoReg_o (),
	.RegWrite_o (),
	.MemRead_o	(),
	.MemWrite_o (),
	.Branch_o	(),
	.Jump_o		(),
	.ExtOp_o	(),
    .ALUOp_o    ()
);


MUX8 MUX8(
	.ID_EX_NOP_i	(HazardDetection.ID_EX_NOP_o),
	.Control_i		({
						Control.RegDst_o,
						Control.ALUSrc_o,
						Control.MemtoReg_o,
						Control.RegWrite_o,
						Control.MemRead_o,
						Control.MemWrite_o,
						Control.ALUOp_o   
					}),
	.data_o			()
);


Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (IF_ID.instr_o[25:21]),
    .RTaddr_i   (IF_ID.instr_o[20:16]),
    .RDaddr_i   (MEM_WB.RD_o),
    .RDdata_i   (MUX_WriteReg.data_o),
    .RegWrite_i (MEM_WB.RegWrite_o),
    .RSdata_o   (),
    .RTdata_o   ()
);


Equal RegisterEq(
	.data1_i	(Registers.RSdata_o),
	.data2_i	(Registers.RTdata_o),
	.data_o		()
);


Sign_Extend Sign_Extend(
	.ExtOp_i	(Control.ExtOp_o),
    .data_i     (_instr[15:0]),
    .data_o     ()
);


Shift2 Shift2(
	.data_i		(Sign_Extend.data_o),
	.data_o		()
);


Adder Add_Branch(
	.data1_i 	(IF_ID.pc_o),
	.data2_i	(Shift2.data_o),
	.data_o		()
);

HazardDetection HazardDetection(
	.ID_EX_MemRead_i	(ID_EX.MemRead_o),
	.ID_EX_RT_i			(ID_EX.RTAddr_o),
	.IF_ID_RS_i			(_instr[25:21]),
	.IF_ID_RT_i			(_instr[20:16]),
	.ID_EX_NOP_o		(),
	.IF_ID_Write_o		(),
	.PC_Write_o			()
);


MUX32 MUX_Jump(
	.data1_i	(MUX_Branch.data_o),
	.data2_i	({_pc[31:28], _instr[25:0], 2'b0}),
	.select_i	(Control.Jump_o),
	.data_o		()
);


ID_EX ID_EX(
    .clk_i			(clk_i),
    .RegDst_i		(MUX8.data_o[7]),
    .ALUSrc_i		(MUX8.data_o[6]),
    .MemtoReg_i		(MUX8.data_o[5]),
    .RegWrite_i		(MUX8.data_o[4]),
	.MemRead_i		(MUX8.data_o[3]),
    .MemWrite_i		(MUX8.data_o[2]),
    .ALUop_i		(MUX8.data_o[1:0]),
    .RS_i			(Registers.RSdata_o),
    .RT_i			(Registers.RTdata_o),
    .SignExtend_i	(Sign_Extend.data_o),
	.RSAddr_i		(_instr[25:21]),
	.RTAddr_i		(_instr[20:16]),
    .RDAddr_i		(_instr[15:11]),
    .RegDst_o		(),
    .ALUSrc_o		(),
    .MemtoReg_o		(),
    .RegWrite_o		(),
	.MemRead_o		(),
    .MemWrite_o		(),
    .ALUop_o		(),
    .RS_o			(),
    .RT_o			(),
    .SignExtend_o	(),
	.RSAddr_o		(),
	.RTAddr_o		(),
    .RDAddr_o		()
);


ALU_Control ALU_Control(
    .funct_i    (ID_EX.SignExtend_o[5:0]),
    .ALUOp_i    (ID_EX.ALUop_o),
    .ALUCtrl_o  ()
);


MUX5 MUX_RegDst(
    .data1_i    (ID_EX.RTAddr_o),
    .data2_i    (ID_EX.RDAddr_o),
    .select_i   (ID_EX.RegDst_o),
    .data_o     ()
);


Forward Forward(
    .MemRegisterRd_i	(MEM_WB.RD_o),
    .MemRegWrite_i		(MEM_WB.RegWrite_o),
    .ExRegWrite_i		(EX_MEM.RegWrite_o),
    .ExRegisterRd_i		(EX_MEM.RD_o),
    .IdRs_i				(ID_EX.RSAddr_o),
    .IdRt_i				(ID_EX.RTAddr_o),
    .ForwardRs_o		(),
    .ForwardRt_o		()
);


MUX_Forward Forward_Rs(
	.data0_i	(ID_EX.RS_o),
	.data1_i	(MUX_WriteReg.data_o),
	.data2_i	(EX_MEM.Result_o),
	.select_i	(Forward.ForwardRs_o),
	.data_o		()
);


MUX_Forward Forward_Rt(
	.data0_i	(ID_EX.RT_o),
	.data1_i	(MUX_WriteReg.data_o),
	.data2_i	(EX_MEM.Result_o),
	.select_i	(Forward.ForwardRt_o),
	.data_o		()
);


MUX32 MUX_ALUSrc(
    .data1_i    (Forward_Rt.data_o),
    .data2_i    (ID_EX.SignExtend_o),
    .select_i   (Control.ALUSrc_o),
    .data_o     ()
);


ALU ALU(
    .data1_i    (Forward_Rs.data_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     ()
);


EX_MEM EX_MEM(
    .clk_i		(clk_i),
    .MemtoReg_i	(ID_EX.MemtoReg_o),
    .RegWrite_i	(ID_EX.RegWrite_o),
    .MemWrite_i	(ID_EX.MemWrite_o),
    .Result_i	(ALU.data_o),
    .Data_i		(Forward_Rt.data_o),
    .RD_i		(MUX_RegDst.data_o),
    .MemtoReg_o	(),
    .RegWrite_o	(),
    .MemWrite_o	(),
    .Result_o	(),
    .Data_o		(),
    .RD_o		()
);

Data_Memory Data_Memory(
    .clk_i      (clk_i),
    .MemWrite_i (EX_MEM.MemWrite_o),
    .MemRead_i  (1'b1),
    .addr_i     (EX_MEM.Result_o),
    .data_i     (EX_MEM.Data_o),
    .data_o     ()
);


MEM_WB MEM_WB(
    .clk_i		(clk_i),
    .MemtoReg_i	(EX_MEM.MemtoReg_o),
    .RegWrite_i	(EX_MEM.RegWrite_o),
    .Data_i		(Data_Memory.data_o),
    .Result_i	(EX_MEM.Result_o),
    .RD_i		(EX_MEM.RD_o),
    .MemtoReg_o	(),
    .RegWrite_o	(),
    .Data_o		(),
    .Result_o	(),
    .RD_o		()
);


MUX32 MUX_WriteReg(
	.data1_i	(MEM_WB.Result_o),
	.data2_i	(MEM_WB.Data_o),
	.select_i	(MEM_WB.MemtoReg_o),
	.data_o		()
);

endmodule
