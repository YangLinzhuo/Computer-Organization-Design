`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:46 04/12/2017 
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
input	signed	[31:0]	ALU_A,	//������A
input	signed	[31:0]	ALU_B,	//������B
input				[4:0]		ALU_OP,	//�����
output reg		[31:0]	ALU_OUT	//���
    );

parameter	A_NOP = 5'h00;			//������
parameter	A_ADD	= 5'h01;			//���ż�
parameter	A_SUB = 5'h02;			//���ż�
parameter	A_AND	= 5'h03;			//������
parameter	A_OR	= 5'h04;			//���Ż�
parameter	A_XOR = 5'h05;			//�������
parameter	A_NOR	= 5'h06;			//���Ż��


always@(*)
begin
	case(ALU_OP)
		A_NOP:	ALU_OUT = 32'h0;
		A_ADD:	ALU_OUT = ALU_A + ALU_B;
		A_SUB:	ALU_OUT = ALU_A - ALU_B;
		A_AND:	ALU_OUT = ALU_A & ALU_B;
		A_OR:		ALU_OUT = ALU_A | ALU_B;
		A_XOR:	ALU_OUT = ALU_A ^ ALU_B;
		A_NOR:	ALU_OUT = ~(ALU_A | ALU_B);
		default: ALU_OUT = 32'h0;
	endcase
end

endmodule
