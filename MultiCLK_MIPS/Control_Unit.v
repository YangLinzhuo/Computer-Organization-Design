`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:20 05/02/2017 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(
input					clk,
input					rst_n,
input		[31:0]		memOut,
input					IorD,			
input					MemWrite,
input					MemtoReg,
input					IRWrite,
input					PCWrite,
input					RegWrite,
input					RegDst,
input					Branch,
input		[1:0]		PCSrc,
input		[2:0]		ALUControl,
input					ALUSrcA,
input		[1:0]		ALUSrcB,
input		[2:0]		ALUOP,
input		[31:0]		ALUResult,
input		[31:0]		r1_out,
input		[31:0]		r2_out,
input					zero,

output	reg	[7:0]		MemAddr,
output	reg	[31:0]		MemData,
output	reg	[4:0] 		r1_addr,
output	reg	[4:0]		r2_addr,
output	reg	[4:0]		r3_addr,
output	reg	[31:0]		r3_in,
output	reg	[31:0]		ALU_A,
output	reg	[31:0]		ALU_B,
output	reg	[31:0]		instr,
output	reg	[31:0]		data
    );


//reg			[4:0]	PCBranch = 5'h0;
reg	signed	[31:0]	sign_extend = 32'h0;
//reg			[8:0]	count = 8'h0;
//reg			[4:0]	aIM_out = 5'h0;

reg			[31:0]		pc_sec	= 32'h0;
reg			[31:0]		PC		= 32'h0;
reg						PCEN	= 0;
reg			[31:0]		ALUOut	= 32'h0;

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		instr <= 32'h0;
	end
	else
	begin
		instr <= IRWrite ? memOut : instr;
	end
end

always@(*)
begin
	if(~rst_n)
	begin
		data = 32'h0;
	end
	else
	begin
		data = memOut;
	end
end

/* Extend Sign */
always@(*)
begin
	sign_extend = $signed(instr[15:0]);
end


/* Registers */
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
		r1_addr = instr[25:21];
		r2_addr = instr[20:16];
		r3_addr = RegDst ? instr[15:11] : instr[20:16];
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
		ALU_A = ALUSrcA ? r1_out : PC;
		case(ALUSrcB)
			2'b00:	ALU_B = r2_out;
			2'b01:	ALU_B = 32'h4;
			2'b10:	ALU_B = sign_extend;
			2'b11:	ALU_B = (sign_extend << 2);
		endcase
	end
end


/* ALU Out */
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		ALUOut <= 32'h0;
	end
	else
	begin
		ALUOut <= ALUResult;
	end
end


/* Register Data */
always@(*)
begin
	if(~rst_n)
	begin
		r3_in = 32'h0;
	end
	else
	begin
		r3_in = MemtoReg ? data : ALUOut;
	end
end



/* Mem Address */
always@(*)
begin
	if(~rst_n)
	begin
		MemAddr = 8'd100;
	end
	else
	begin
		MemAddr = IorD ? (ALUOut >> 2) : (PC >> 2);		
	end
end
	
	
/* Mem Data */
always@(*)
begin
	if(~rst_n)
	begin
		MemData = 32'h0;
	end
	else
	begin
		MemData = r2_out;
	end
end


/* PC */
always@(*)
begin
	if(~rst_n)
	begin
		pc_sec = 32'h0;
	end
	else
	begin
		case(PCSrc)
			2'b00:	pc_sec = ALUResult;
			2'b01:	pc_sec = ALUOut;
			2'b10:	pc_sec = {PC[31:28], instr[25:0], 2'b00};
		endcase
	end
end
	

always@(*)
begin
	if(~rst_n)
	begin
		PCEN = 0;
	end
	else
	begin
		PCEN = (zero && Branch) || PCWrite;
	end
end	
	
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		PC <= 32'h0;
	end
	else
	begin
		PC <= PCEN ? pc_sec : PC;
	end
end

	
endmodule
