`include "ControlUnit/Control.v"
`include "ControlUnit/ALUControl.v"
`include "ControlUnit/Forward.v"
`include "ControlUnit/HazardDetection.v"
`include "Memory/InstructionMemory.v"
`include "Memory/DataMemory.v"
`include "Arithmetic/ALU.v"
`include "Arithmetic/Adder.v"
`include "Arithmetic/Equal.v"
`include "Arithmetic/SignExtend.v"
`include "Arithmetic/Shift2.v"
`include "MUX/MUX5.v"
`include "MUX/MUX8.v"
`include "MUX/MUX32.v"
`include "MUX/MUXForward.v"
`include "PipelineRegister/IF_ID.v"
`include "PipelineRegister/ID_EX.v"
`include "PipelineRegister/EX_MEM.v"
`include "PipelineRegister/MEM_WB.v"

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


InstructionMemory InstructionMemory(
    .addr_i     (PC.pc_o),
    .instr_o    ()
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
	.pc_write_i	(HazardDetection.pc_write_o),
    .pc_i       (MUXJump.data_o),
    .pc_o       ()
);


Adder AddPC(
    .data0_i	(PC.pc_o),
    .data1_i	(32'd4),
    .data_o     ()
);


MUX32 MUXBranch(
	.data0_i	(AddPC.data_o),
	.data1_i	(AddBranch.data_o),
	.select_i	((Control.branch_o & RegisterEq.data_o)),
	.data_o		()
);


IF_ID IF_ID(
	.clk_i		(clk_i),
	.flush_i	((Control.branch_o & RegisterEq.data_o) | Control.jump_o),
	.hazard_i	(~HazardDetection.IF_ID_write_o),
	.pc_i		(PC.pc_o),
	.instr_i	(InstructionMemory.instr_o),
	.pc_o		(),
	.instr_o	()
);


Control Control(
    .op_i       (IF_ID.instr_o[31:26]),
    .regdst_o   (),
    .alusrc_o   (),
	.memtoreg_o (),
	.regwrite_o (),
	.memread_o	(),
	.memwrite_o (),
	.branch_o	(),
	.jump_o		(),
	.extop_o	(),
    .aluop_o    ()
);


MUX8 MUX8(
	.ID_EX_nop_i	(HazardDetection.ID_EX_nop_o),
	.control_i		({
						Control.regdst_o,
						Control.alusrc_o,
						Control.memtoreg_o,
						Control.regwrite_o,
						Control.memread_o,
						Control.memwrite_o,
						Control.aluop_o   
					}),
	.data_o			()
);


Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (IF_ID.instr_o[25:21]),
    .RTaddr_i   (IF_ID.instr_o[20:16]),
    .RDaddr_i   (MEM_WB.RD_o),
    .RDdata_i   (MUXWriteReg.data_o),
    .regwrite_i (MEM_WB.regwrite_o),
    .RSdata_o   (),
    .RTdata_o   ()
);


Equal RegisterEq(
	.data0_i	(Registers.RSdata_o),
	.data1_i	(Registers.RTdata_o),
	.data_o		()
);


SignExtend SignExtend(
	.extop_i	(Control.extop_o),
    .data_i     (IF_ID.instr_o[15:0]),
    .data_o     ()
);


Shift2 Shift2(
	.data_i		(SignExtend.data_o),
	.data_o		()
);


Adder AddBranch(
	.data0_i 	(IF_ID.pc_o),
	.data1_i	(Shift2.data_o),
	.data_o		()
);

HazardDetection HazardDetection(
	.ID_EX_memread_i	(ID_EX.memread_o),
	.ID_EX_RT_i			(ID_EX.RTaddr_o),
	.IF_ID_RS_i			(IF_ID.instr_o[25:21]),
	.IF_ID_RT_i			(IF_ID.instr_o[20:16]),
	.ID_EX_nop_o		(),
	.IF_ID_write_o		(),
	.pc_write_o			()
);


MUX32 MUXJump(
	.data0_i	(MUXBranch.data_o),
	.data1_i	({IF_ID.pc_o[31:28], IF_ID.instr_o[25:0], 2'b0}),
	.select_i	(Control.jump_o),
	.data_o		()
);


ID_EX ID_EX(
    .clk_i			(clk_i),
    .regdst_i		(MUX8.data_o[7]),
    .alusrc_i		(MUX8.data_o[6]),
    .memtoreg_i		(MUX8.data_o[5]),
    .regwrite_i		(MUX8.data_o[4]),
	.memread_i		(MUX8.data_o[3]),
    .memwrite_i		(MUX8.data_o[2]),
    .aluop_i		(MUX8.data_o[1:0]),
    .RS_i			(Registers.RSdata_o),
    .RT_i			(Registers.RTdata_o),
    .signextend_i	(SignExtend.data_o),
	.RSaddr_i		(IF_ID.instr_o[25:21]),
	.RTaddr_i		(IF_ID.instr_o[20:16]),
    .RDaddr_i		(IF_ID.instr_o[15:11]),
    .regdst_o		(),
    .alusrc_o		(),
    .memtoreg_o		(),
    .regwrite_o		(),
	.memread_o		(),
    .memwrite_o		(),
    .aluop_o		(),
    .RS_o			(),
    .RT_o			(),
    .signextend_o	(),
	.RSaddr_o		(),
	.RTaddr_o		(),
    .RDaddr_o		()
);

ALUControl ALUControl(
    .funct_i    (ID_EX.signextend_o[5:0]),
    .aluop_i    (ID_EX.aluop_o),
    .aluctrl_o  ()
);


MUX5 MUXRegDst(
    .data0_i    (ID_EX.RTaddr_o),
    .data1_i    (ID_EX.RDaddr_o),
    .select_i   (ID_EX.regdst_o),
    .data_o     ()
);


Forward Forward(
    .MEM_WB_RD_i			(MEM_WB.RD_o),
    .MEM_WB_regwrite_i		(MEM_WB.regwrite_o),
    .EX_MEM_regwrite_i		(EX_MEM.regwrite_o),
    .EX_MEM_RD_i			(EX_MEM.RD_o),
    .ID_EX_RS_i				(ID_EX.RSaddr_o),
    .ID_EX_RT_i				(ID_EX.RTaddr_o),
    .forward_RS_o			(),
    .forward_RT_o			()
);


MUXForward ForwardRS(
	.data0_i	(ID_EX.RS_o),
	.data1_i	(MUXWriteReg.data_o),
	.data2_i	(EX_MEM.result_o),
	.select_i	(Forward.forward_RS_o),
	.data_o		()
);


MUXForward ForwardRT(
	.data0_i	(ID_EX.RT_o),
	.data1_i	(MUXWriteReg.data_o),
	.data2_i	(EX_MEM.result_o),
	.select_i	(Forward.forward_RT_o),
	.data_o		()
);


MUX32 MUXALUSrc(
    .data0_i    (ForwardRT.data_o),
    .data1_i    (ID_EX.signextend_o),
    .select_i   (ID_EX.alusrc_o),
    .data_o     ()
);


ALU ALU(
    .data0_i    (ForwardRS.data_o),
    .data1_i    (MUXALUSrc.data_o),
    .aluctrl_i  (ALUControl.aluctrl_o),
    .data_o     ()
);


EX_MEM EX_MEM(
    .clk_i		(clk_i),
    .memtoreg_i	(ID_EX.memtoreg_o),
    .regwrite_i	(ID_EX.regwrite_o),
    .memwrite_i	(ID_EX.memwrite_o),
    .result_i	(ALU.data_o),
    .data_i		(ForwardRT.data_o),
    .RD_i		(MUXRegDst.data_o),
    .memtoreg_o	(),
    .regwrite_o	(),
    .memwrite_o	(),
    .result_o	(),
    .data_o		(),
    .RD_o		()
);


DataMemory DataMemory(
    .clk_i      (clk_i),
    .memwrite_i (EX_MEM.memwrite_o),
    .memread_i  (1'b1),
    .addr_i     (EX_MEM.result_o),
    .data_i     (EX_MEM.data_o),
    .data_o     ()
);


MEM_WB MEM_WB(
    .clk_i		(clk_i),
    .memtoreg_i	(EX_MEM.memtoreg_o),
    .regwrite_i	(EX_MEM.regwrite_o),
    .data_i		(DataMemory.data_o),
    .result_i	(EX_MEM.result_o),
    .RD_i		(EX_MEM.RD_o),
    .memtoreg_o	(),
    .regwrite_o	(),
    .data_o		(),
    .result_o	(),
    .RD_o		()
);


MUX32 MUXWriteReg(
	.data0_i	(MEM_WB.result_o),
	.data1_i	(MEM_WB.data_o),
	.select_i	(MEM_WB.memtoreg_o),
	.data_o		()
);

endmodule
