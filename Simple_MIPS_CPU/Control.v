`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:53 04/16/2017 
// Design Name: 
// Module Name:    Control 
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
module Control(
input							rst_n,
input				[31:0]	spoIM,
output	reg				MemtoReg,
output	reg				MemWrite,
output	reg				Branch,
output	reg	[2:0]		ALUcontrol,
output	reg				ALUsource,
output	reg				RegDst,
output	reg				RegWrite,
output	reg				Jump
    );

reg	[5:0]	OP = 6'h0;
reg	[5:0]	Funct = 6'h0;
reg	[2:0]	state = 3'h0;

parameter addi = 3'b000;
parameter add  = 3'b001;
parameter lw	= 3'b010;
parameter sw	= 3'b011;
parameter bgtz = 3'b100;
parameter j		= 3'b101;

always@(*)
begin
	OP = spoIM[31:26];
	Funct = spoIM[5:0];
end

always@(*)
begin
	case(OP)
		6'b000000:
			begin
				case(Funct)
					6'b100000: state = add;
				endcase
			end
		6'b001000: state = addi;
		6'b100011: state = lw;
		6'b101011: state = sw;
		6'b000111: state = bgtz;
		6'b000010: state = j;
	endcase
end

always@(*)
begin
	case(state)
		add:
			begin
				RegDst = 1;
				ALUsource = 0;
				Branch = 0;
				MemtoReg = 0;
				ALUcontrol = 3'b001;	//加法
				Jump = 0;
				MemWrite = 0;
				RegWrite = 1;
			end
		addi:
			begin
				RegDst = 0;
				ALUsource = 1;
				Branch = 0;
				MemtoReg = 0;
				ALUcontrol = 3'b001;	//加法
				Jump = 0;
				MemWrite = 0;
				RegWrite = 1;
			end
		lw:
			begin
				RegDst = 0;
				ALUsource = 1;
				Branch = 0;
				MemtoReg = 1;
				ALUcontrol = 3'b001;	//加法
				Jump = 0;
				MemWrite = 0;
				RegWrite = 1;
			end
		sw:
			begin
				RegDst = 0;
				ALUsource = 1;
				Branch = 0;
				MemtoReg = 0;
				ALUcontrol = 3'b001;	//加法
				Jump = 0;
				MemWrite = 1;
				RegWrite = 0;
			end
		bgtz:
			begin
				RegDst = 0;
				ALUsource = 1;
				Branch = 1;
				MemtoReg = 0;
				ALUcontrol = 3'b111;	
				Jump = 0;
				MemWrite = 0;
				RegWrite = 0;
			end
		j:
			begin
				RegDst = 0;
				ALUsource = 0;
				Branch = 0;
				MemtoReg = 0;
				ALUcontrol = 3'b000;	
				Jump = 1;
				MemWrite = 0;
				RegWrite = 0;
			end
		default:
			begin
				RegDst = 0;
				ALUsource = 0;
				Branch = 0;
				MemtoReg = 0;
				ALUcontrol = 3'b000;
				Jump = 0;
				MemWrite = 0;
				RegWrite = 0;
			end
	endcase
end

endmodule
