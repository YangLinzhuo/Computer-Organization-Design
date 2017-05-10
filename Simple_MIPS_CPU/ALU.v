`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:49 04/16/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
input	signed	[31:0]	ALU_A,		//操作数A
input	signed	[31:0]	ALU_B,		//操作数B
input			[2:0]	ALU_OP,		//运算符
output	reg		[31:0]	ALU_OUT,	//输出
output	reg				zero		//输出结果是否为0
    );

parameter	A_NOP	= 3'h0;			//空运算
parameter	A_ADD	= 3'h1;			//符号加
parameter	A_SUB	= 3'h2;			//符号减
parameter	A_AND	= 3'h3;			//符号与
parameter	A_OR	= 3'h4;			//符号或
parameter	A_XOR	= 3'h5;			//符号异或
parameter	A_NOR	= 3'h6;			//符号或非
parameter	BGTZ	= 3'b111;


always@(*)
begin
	case(ALU_OP)
		A_NOP:		ALU_OUT = 32'h0;
		A_ADD:		ALU_OUT = ALU_A + ALU_B;
		A_SUB:		ALU_OUT = ALU_A - ALU_B;
		A_AND:		ALU_OUT = ALU_A & ALU_B;
		A_OR:		ALU_OUT = ALU_A | ALU_B;
		A_XOR:		ALU_OUT = ALU_A ^ ALU_B;
		A_NOR:		ALU_OUT = ~(ALU_A | ALU_B);
		BGTZ:		ALU_OUT = (ALU_A > 0) ? 32'h0 : 32'h1;
		default: 	ALU_OUT = 32'h0;
	endcase
end

always@(*)
begin
	zero = ALU_OUT ? 0 : 1;		// ALU_OUT 非零时 zero 为 0，否则为 1
end

endmodule