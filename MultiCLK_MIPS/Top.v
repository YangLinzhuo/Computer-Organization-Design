`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:20 05/02/2017 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(
input			clk,
input			rst_n
    );

wire	[2:0]	add = 3'h1;

wire	[31:0]	memOut;
wire	[31:0]	PC;
wire			IorD;
wire			MemWrite;
wire			MemtoReg;
wire			IRWrite;
wire			PCWrite;
wire			RegWrite;
wire			RegDst;
wire			Branch;
wire	[1:0]	PCSrc;
wire	[2:0]	ALUControl;
wire			ALUSrcA;
wire	[1:0]	ALUSrcB;
wire	[2:0]	ALUOP;
wire	[31:0]	ALUResult;
wire	[31:0]	r1_out;
wire	[31:0]	r2_out;
wire	[31:0]	r3_in;

wire	[31:0]	ALU_A;
wire	[31:0]	ALU_B;
wire			zero;

wire	[7:0]	MemAddr;
wire	[31:0]	MemData;
wire	[4:0]	r1_addr;	
wire	[4:0]	r2_addr;
wire	[4:0]	r3_addr;

wire	[31:0]	data;
wire	[31:0]	instr;


wire	[3:0]	currentState;

Finite_State_Machine	u_Finite_State_Machine(
.clk		(clk),
.rst_n		(rst_n),
.In			(instr),
.currentState		(currentState)
);

ALU			u_ALU(
.ALU_A		(ALU_A),		//操作数A
.ALU_B		(ALU_B),		//操作数B
.ALU_OP		(ALUOP),		//运算符
.ALU_OUT	(ALUResult),	//输出
.zero		(zero)		//输出结果是否为0
);

Control_Unit		u_Control_Unit(
.clk				(clk),
.rst_n				(rst_n),
.memOut				(memOut),
.IorD				(IorD),			
.MemWrite			(MemWrite),
.MemtoReg			(MemtoReg),
.IRWrite			(IRWrite),
.PCWrite			(PCWrite),
.RegWrite			(RegWrite),
.RegDst				(RegDst),
.Branch				(Branch),
.PCSrc				(PCSrc),
.ALUControl			(ALUControl),
.ALUSrcA			(ALUSrcA),
.ALUSrcB			(ALUSrcB),
.ALUOP				(ALUOP),
.ALUResult			(ALUResult),
.r1_out				(r1_out),
.r2_out				(r2_out),
.zero				(zero),

.MemAddr			(MemAddr),
.MemData			(MemData),
.r1_addr			(r1_addr),	
.r2_addr			(r2_addr),
.r3_addr			(r3_addr),
.r3_in				(r3_in),
.ALU_A				(ALU_A),
.ALU_B				(ALU_B),
.instr				(instr),
.data				(data)
);


Control_Unit_Signal		u_Control_Unit_Signal(
.clk				(clk),
.rst_n				(rst_n),
.curState			(currentState),
.IorD				(IorD),			
.MemWrite			(MemWrite),
.MemtoReg			(MemtoReg),
.IRWrite			(IRWrite),
.PCWrite			(PCWrite),
.RegWrite			(RegWrite),
.RegDst				(RegDst),
.Branch				(Branch),
.PCSrc				(PCSrc),
.ALUControl			(ALUControl),
.ALUSrcA			(ALUSrcA),
.ALUSrcB			(ALUSrcB),
.ALUOP				(ALUOP)
);


Register_File		u_Register_File(
.clk				(clk),
.rst_n				(rst_n),
.r1_addr			(r1_addr),	//读取地址1
.r2_addr			(r2_addr),	//读取地址2
.r3_addr			(r3_addr),	//写入地址
.r3_in				(r3_in),	//写入数据
.r3_we				(RegWrite),	//写使能
.r1_out				(r1_out),	//输出1
.r2_out				(r2_out)	//输出2
);

Instruction_Data_Memory		u_Instruction_Data_Memory(
.clka		(clk),
.wea		(MemWrite),
.addra		(MemAddr),
.dina		(MemData),
.douta		(memOut)
);

endmodule
