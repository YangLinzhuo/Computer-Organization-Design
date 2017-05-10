`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:09 04/16/2017 
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
input			clk_r,
input			rst_n
    );


wire		[31:0]	ALU_A;
wire		[31:0]	ALU_B;
wire		[31:0]	ALU_OUT;
wire					zero;
wire		[2:0]		ALUcontrol;

wire		[4:0]		r1_addr;
wire		[4:0]		r2_addr;
wire		[4:0]		r3_addr;
wire					RegWrite;
wire		[31:0]	r3_in;
wire		[31:0]	r1_out;
wire		[31:0]	r2_out;

wire					MemWrite;


wire				MemtoReg;
wire				Branch;
wire				ALUsource;
wire				RegDst;
wire				Jump;

wire		[4:0]		aIM;
wire		[31:0]	spoIM;


wire		[4:0]		a;
wire		[31:0]	d;
wire		[31:0]	spo;


ALU	u_ALU(
.ALU_OP			(ALUcontrol),
.ALU_A			(ALU_A),
.ALU_B			(ALU_B),
.ALU_OUT			(ALU_OUT),
.zero				(zero)
);

RegisterFile	u_RegisterFile(
.clk				(clk),
.clk_r			(clk_r),
.rst_n			(rst_n),
.r1_out			(r1_out),
.r2_out			(r2_out),
.r1_addr			(r1_addr),
.r2_addr			(r2_addr),
.r3_addr			(r3_addr),
.r3_in			(r3_in),
.r3_we			(RegWrite)
);

Control u_Control(
.rst_n			(rst_n),
.spoIM			(spoIM),
.MemtoReg		(MemtoReg),
.MemWrite		(MemWrite),
.Branch			(Branch),
.ALUcontrol		(ALUcontrol),
.ALUsource		(ALUsource),
.RegDst			(RegDst),
.RegWrite		(RegWrite),
.Jump				(Jump)
);

ControlSegment u_ControlSegment(
.clk						(clk),
.rst_n					(rst_n),
.spoIM					(spoIM),
.MemtoReg				(MemtoReg),
.MemWrite				(MemWrite),
.Branch					(Branch),
.ALUcontrol				(ALUcontrol),
.ALUsource				(ALUsource),
.RegDst					(RegDst),
.RegWrite				(RegWrite),
.Jump						(Jump),
.r1_out					(r1_out),
.r2_out					(r2_out),
.zero						(zero),
.ALU_OUT					(ALU_OUT),
.spo						(spo),
.aIM						(aIM),
.r1_addr					(r1_addr),
.r2_addr					(r2_addr),
.ALU_A					(ALU_A),
.ALU_B					(ALU_B),
.d							(d),
.a							(a),
.r3_addr					(r3_addr),
.r3_in					(r3_in)
);


InstructionMemory u_InstructionMemory(
.a					(aIM),	// input [4 : 0] a
.spo				(spoIM)
);

DataMemory	u_DataMemory(
.clk				(clk),
.we				(MemWrite),
.a					(a),
.d					(d),
.spo				(spo)
);

endmodule
