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
input	signed	[31:0]	ALU_A,		//������A
input	signed	[31:0]	ALU_B,		//������B
input			[2:0]	ALU_OP,		//�����
output	reg		[31:0]	ALU_OUT,	//���
output	reg				zero		//�������Ƿ�Ϊ0
    );

parameter	A_NOP	= 3'h0;			//������
parameter	A_ADD	= 3'h1;			//���ż�
parameter	A_SUB	= 3'h2;			//���ż�
parameter	A_AND	= 3'h3;			//������
parameter	A_OR	= 3'h4;			//���Ż�
parameter	A_XOR	= 3'h5;			//�������
parameter	A_NOR	= 3'h6;			//���Ż��
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
	zero = ALU_OUT ? 0 : 1;		// ALU_OUT ����ʱ zero Ϊ 0������Ϊ 1
end

endmodule