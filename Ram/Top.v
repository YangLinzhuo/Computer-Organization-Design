`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:22 03/21/2017 
// Design Name: 
// Module Name:    Top 
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
module Top(
input			clk,
input			rst_n,
input			clka,
input			clkb
    );

parameter add = 5'h1;

wire		[31:0]	ALU_A;
wire		[31:0]	ALU_B;
wire		[31:0]	ALU_OUT;

wire		[4:0]		r1_addr;
wire		[4:0]		r2_addr;
wire		[4:0]		r3_addr;
wire					r3_we;
wire		[31:0]	r3_in;
wire		[31:0]	r1_out;
wire		[31:0]	r2_out;

wire					wea;
wire		[5:0]		addra;
wire		[31:0]	dina;
wire		[5:0] 	addrb;
wire		[31:0]	doutb;

ALU	u_ALU(
.ALU_OP			(add),
.ALU_A			(ALU_A),
.ALU_B			(ALU_B),
.ALU_OUT			(ALU_OUT)
);

RegFile	u_RegFile(
.clk				(clk),
.rst_n			(rst_n),
.r1_out			(r1_out),
.r2_out			(r2_out),
.r1_addr			(r1_addr),
.r2_addr			(r2_addr),
.r3_addr			(r3_addr),
.r3_in			(r3_in),
.r3_we			(r3_we)
);

Control u_Control(
.clk				(clk),
.rst_n			(rst_n),
.ALU_OUT			(ALU_OUT),
.r1_out			(r1_out),
.r2_out			(r2_out),
.r1_addr			(r1_addr),
.r2_addr			(r2_addr),
.r3_addr			(r3_addr),
.r3_in			(r3_in),
.r3_we			(r3_we),
.ALU_A			(ALU_A),
.ALU_B			(ALU_B),
.wea				(wea), // input [0 : 0] wea
.addra			(addra), // input [5 : 0] addra
.dina				(dina), // input [31 : 0] dina
.addrb			(addrb), // input [5 : 0] addrb
.doutb			(doutb) // output [31 : 0] doutb
);

Mem u_name(
.clka				(clka), // input clka
.wea				(wea), // input [0 : 0] wea
.addra			(addra), // input [5 : 0] addra
.dina				(dina), // input [31 : 0] dina
.clkb				(clkb), // input clkb
.addrb			(addrb), // input [5 : 0] addrb
.doutb			(doutb) // output [31 : 0] doutb
);

endmodule
