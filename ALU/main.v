`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:29 03/14/2017 
// Design Name: 
// Module Name:    main 
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
module main(
input				[31:0]	A,
input				[31:0]	B,
input				[4:0]		OP,
output			[31:0]	OUT
    );

parameter	A_NOP = 5'h00;			//¿ÕÔËËã
parameter	A_ADD	= 5'h01;			//·ûºÅ¼Ó
parameter	A_SUB = 5'h02;			//·ûºÅ¼õ
parameter	A_AND	= 5'h03;			//·ûºÅÓë
parameter	A_OR	= 5'h04;			//·ûºÅ»ò
parameter	A_XOR = 5'h05;			//·ûºÅÒì»ò
parameter	A_NOR	= 5'h06;			//·ûºÅ»ò·Ç

wire	[31:0]	tempOUT1;

ALU u_ALU1(
.ALU_A	(A),
.ALU_B	(B),
.ALU_OP	(OP),
.ALU_OUT	(tempOUT1)
);

wire	[31:0]	tempOUT2;

ALU u_ALU2(
.ALU_A	(tempOUT1),
.ALU_B	(B),
.ALU_OP	(OP),
.ALU_OUT	(tempOUT2)
);

wire	[31:0]	tempOUT3;

ALU u_ALU3(
.ALU_A	(tempOUT1),
.ALU_B	(tempOUT2),
.ALU_OP	(OP),
.ALU_OUT	(tempOUT3)
);

ALU u_ALU4(
.ALU_A	(tempOUT3),
.ALU_B	(tempOUT2),
.ALU_OP	(OP),
.ALU_OUT	(OUT)
);

endmodule
