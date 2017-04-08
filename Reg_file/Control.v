`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:59 03/21/2017 
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
input										clk,
input										rst_n,
input				signed	[31:0]	ALU_OUT,
input				signed	[31:0]	r1_out,
input				signed	[31:0]	r2_out,
output	reg				[4:0]		r1_addr,
output	reg				[4:0]		r2_addr,
output	reg				[4:0]		r3_addr,
output	reg							r3_we,
output	reg				[31:0]	r3_in,
output	reg				[31:0]	ALU_A,
output	reg				[31:0]	ALU_B	
    );

parameter	read = 2'b00;
parameter	calculate = 2'b01;
parameter	write	= 2'b10;
parameter	idle = 2'b11;

reg	[4:0]	number = 5'h0;	//记录当前写入寄存器的次数
reg	[1:0]	state = 2'b11;
reg	[1:0]	count = 2'b00;

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		count <= 2'h0;
	else if(count == 2'h3)
		count <= 2'h0;
	else
		count <= count + 2'h1;
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		state <= idle;
	else if(count == 2'h3)
		begin
			case(state)
				idle: state <= read;
				read:	state <= calculate;
				calculate: state <= write;
				write: state <= idle;
				default: state <= idle;
			endcase
		end
	else
		state <= state;
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		number <= 5'h0;
	else if(number == 5'd31)
		number <= number;
	else if(state == write && count == 2'h3)
		number <= number + 5'h1;
	else
		number <= number;
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			r1_addr <= 5'h0;
			r2_addr <= 5'h1;
		end
	else if(number == 5'h0)
		begin
			r1_addr <= 5'h0;
			r2_addr <= 5'h1;
			r3_addr <= 5'h0;		//写入第一个寄存器
		end
	else if(number == 5'h1)
		begin
			r1_addr <= 5'h0;
			r2_addr <= 5'h1;
			r3_addr <= 5'h1;		//写入第二个寄存器
		end
	else
		begin
			r1_addr <= number - 5'h2;
			r2_addr <= number - 5'h1;
			r3_addr <= number;
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		r3_we <= 0;
	else if(state == write)
		r3_we <= 1;
	else
		r3_we <= 0;
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		r3_in <= 32'h0;
	else if(number == 5'h0 || number == 5'h1)
		r3_in <= 32'h1;
	else
		r3_in <= ALU_OUT;
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			ALU_A <= 32'h0;
			ALU_B <= 32'h0;
		end
	else if(state == read)
		begin
			ALU_A <= r1_out;
			ALU_B <= r2_out;
		end
end

endmodule
