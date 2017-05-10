`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:43 05/02/2017 
// Design Name: 
// Module Name:    Control_Unit_Signal 
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
module Control_Unit_Signal(
input					clk,
input					rst_n,
input		[3:0]		curState,
output	reg				IorD,			//ָ������ݱ�ʶ����0��ʾָ�1��ʾ����
output	reg				MemWrite,
output	reg				MemtoReg,
output	reg				IRWrite,
output	reg				PCWrite,
output	reg				RegWrite,
output	reg				RegDst,
output	reg				Branch,
output	reg	[1:0]		PCSrc,
output	reg	[2:0]		ALUControl,
output	reg				ALUSrcA,
output	reg	[1:0]		ALUSrcB,
output	reg	[2:0]		ALUOP
    );


parameter idle			= 4'b0000;
parameter fetch			= 4'b0001;		//ȡָ
parameter decode		= 4'b0010;		//����
parameter memAddress 	= 4'b0011;		//�����ַ
parameter memRead 		= 4'b0100;		//�ڴ��
parameter memWriteBack	= 4'b0101;		//�ڴ�д��
parameter memWrite		= 4'b0110;		//�ڴ�д
parameter execute		= 4'b0111;		//ִ��
parameter ALUWriteBack	= 4'b1000;		//ALUд��
parameter branch		= 4'b1001;		//��֧
parameter addiExecute	= 4'b1010;		//addiִ��
parameter addiWriteBack = 4'b1011;		//addiд��
parameter jump			= 4'b1100;		//��ת	
parameter suspend		= 4'b1101;


always@(*)
begin
	if(~rst_n)
	begin
		IorD		= 0;
		MemWrite	= 0;
		MemtoReg	= 0;
		IRWrite		= 0;
		PCWrite		= 0;
		RegWrite	= 0;
		RegDst		= 0;
		Branch		= 0;
		PCSrc		= 2'b00;
		ALUControl	= 3'b000;
		ALUSrcA		= 0;
		ALUSrcB		= 2'b00;
		ALUOP		= 2'b00;
	end
	else
	begin
		case(curState)
			idle:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b00;
				end
			fetch:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 1;
					PCWrite		= 1;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b01;
					ALUOP		= 2'b001;
				end
			suspend:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 1;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b01;
					ALUOP		= 2'b001;
				end
			decode:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b11;
					ALUOP		= 2'b001;
				end
			memAddress:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 1;
					ALUSrcB		= 2'b10;
					ALUOP		= 2'b001;
				end
			memRead:
				begin
					IorD		= 1;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			memWriteBack:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 1;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 1;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			memWrite:
				begin
					IorD		= 1;
					MemWrite	= 1;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			execute:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 1;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			ALUWriteBack:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 1;
					RegDst		= 1;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			branch:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 1;
					PCSrc		= 2'b01;
					ALUControl	= 3'b000;
					ALUSrcA		= 1;
					ALUSrcB		= 2'b00;
					ALUOP		= 3'b111;
				end
			addiExecute:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 1;
					ALUSrcB		= 2'b10;
					ALUOP		= 2'b001;
				end
			addiWriteBack:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 0;
					RegWrite	= 1;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b00;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
			jump:
				begin
					IorD		= 0;
					MemWrite	= 0;
					MemtoReg	= 0;
					IRWrite		= 0;
					PCWrite		= 1;
					RegWrite	= 0;
					RegDst		= 0;
					Branch		= 0;
					PCSrc		= 2'b10;
					ALUControl	= 3'b000;
					ALUSrcA		= 0;
					ALUSrcB		= 2'b00;
					ALUOP		= 2'b001;
				end
		endcase
	end
end
	
endmodule
