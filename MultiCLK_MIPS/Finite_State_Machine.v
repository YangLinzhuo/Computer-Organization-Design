`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:01 05/02/2017 
// Design Name: 
// Module Name:    Finite_State_Machine 
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
module Finite_State_Machine(
input					clk,
input					rst_n,
input		[31:0]		In,
output	reg	[3:0]		currentState
    );
	
reg	[5:0]	OP 		= 6'h0;
reg	[5:0]	Funct	= 6'h0;
reg	[3:0]	State	= 4'h0;

reg	[3:0]	curState	= 4'h0;
reg	[3:0]	nextState	= 4'h0;

parameter idle			= 4'b0000;
parameter fetch			= 4'b0001;		//取指
parameter decode		= 4'b0010;		//译码
parameter memAddress 	= 4'b0011;		//计算地址
parameter memRead 		= 4'b0100;		//内存读
parameter memWriteBack	= 4'b0101;		//内存写回
parameter memWrite		= 4'b0110;		//内存写
parameter execute		= 4'b0111;		//执行
parameter ALUWriteBack	= 4'b1000;		//ALU写回
parameter branch		= 4'b1001;		//分支
parameter addiExecute	= 4'b1010;		//addi执行
parameter addiWriteBack = 4'b1011;		//addi写回
parameter jump			= 4'b1100;		//跳转
parameter suspend		= 4'b1101;


parameter addi	= 6'b001000;
parameter add	= 6'b000000;
parameter lw	= 6'b100011;
parameter sw	= 6'b101011;
parameter bgtz	= 6'b000111;
parameter j		= 6'b000010;

always@(*)
begin
	OP = In[31:26];
	Funct = In[5:0];
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		curState <= idle;
	end
	else
	begin
		curState <= nextState;
	end
end

always@(*)
begin
	if(~rst_n)
	begin
		nextState = fetch;
	end
	else
	begin
		case(curState)
			idle:			nextState = fetch;
			fetch:			nextState = suspend;
			suspend:		nextState = decode;
			decode:
				case(OP)
					lw:		nextState = memAddress;
					sw:		nextState = memAddress;
					add:	nextState = execute;
					bgtz:	nextState = branch;
					addi:	nextState = addiExecute;
					j:		nextState = jump;
				endcase
			memAddress:		nextState = OP == lw ? memRead : memWrite;
			memRead:		nextState = memWriteBack;
			memWriteBack:	nextState = fetch;
			memWrite:		nextState = fetch;
			execute:		nextState = ALUWriteBack;
			ALUWriteBack:	nextState = fetch;
			branch:			nextState = fetch;
			addiExecute:	nextState = addiWriteBack;
			addiWriteBack:	nextState = fetch;
			jump:			nextState = fetch;
		endcase
	end
end


always@(*)
begin
	if(~rst_n)
	begin
		currentState = idle;
	end
	else
	begin
		currentState = curState;
	end
end

endmodule
