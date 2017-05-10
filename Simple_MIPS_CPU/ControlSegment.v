`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:34 04/16/2017 
// Design Name: 
// Module Name:    ControlSegment 
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
module ControlSegment(
input					clk,
input					rst_n,
input		[31:0]	spoIM,
input					MemtoReg,
input					MemWrite,
input					Branch,
input		[2:0]		ALUcontrol,
input					ALUsource,
input					RegDst,
input					RegWrite,
input					Jump,
input				[31:0]	r1_out,
input				[31:0]	r2_out,
input							zero,
input				[31:0]	ALU_OUT,
input				[31:0]	spo,
output	reg	[4:0]		aIM,
output	reg	[4:0] 	r1_addr,
output	reg	[4:0]		r2_addr,
output	reg	[4:0]		r3_addr,
output	reg	[31:0]	r3_in,
output	reg	[31:0]	ALU_A,
output	reg	[31:0]	ALU_B,
output	reg	[31:0]	d,
output	reg	[4:0]		a
    );

reg	PCSrc = 0;
reg	[4:0]	 PCBranch = 5'h0;
reg	signed [31:0] sign_extend = 32'h0;
reg	[8:0]	count = 8'h0;
reg	[4:0]	aIM_out = 5'h0;


/* Sign immediate */
always@(*)
begin
	sign_extend = $signed(spoIM[15:0]);
end

/* ALU_A	ALU_B */
always@(*)
begin
	if(~rst_n)
	begin
		r1_addr = 5'h0;
		r2_addr = 5'h0;
		r3_addr = 5'h0;
	end
	else
	begin
		r1_addr = spoIM[25:21];
		r2_addr = spoIM[20:16];
		r3_addr = RegDst ? spoIM[15:11] : spoIM[20:16];
	end
end

/* ALU source */
always@(*)
begin
	if(~rst_n)
	begin
		ALU_A = 32'h0;
		ALU_B = 32'h0;
	end
	else
	begin
		ALU_A = r1_out;
		ALU_B = ALUsource ? sign_extend : r2_out;		// 根据 ALUsource 赋值
	end
end


/* Mem Address */
always@(*)
begin
	if(~rst_n)
	begin
		a = 5'h0;
	end
	else
	begin
		a = (ALU_OUT >> 2);		// 地址需要除以4, 因为空间小
	end
end


/* Mem Data */
always@(*)
begin
	d = r2_out;
end


/* Result */
always@(*)
begin
	r3_in = MemtoReg ? spo : ALU_OUT;
end


/* PC source */
always@(*)
begin
	PCSrc = zero & Branch;
end


/* PC + 4, PC branch control, PC jump control*/
always@(*)
begin
	if(~rst_n)
		aIM_out = 5'h0;
	else
	begin
		aIM_out = aIM;
		aIM_out = aIM_out + 5'h1;
		PCBranch = aIM_out + sign_extend;
		aIM_out = PCSrc ? PCBranch : aIM_out;
		aIM_out = Jump ? spoIM[4:0] : aIM_out;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		aIM = 5'h0;
	else
	begin
		aIM = aIM_out;
	end
end

endmodule
