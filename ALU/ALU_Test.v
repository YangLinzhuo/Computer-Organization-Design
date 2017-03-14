`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:39:15 03/14/2017
// Design Name:   ALU
// Module Name:   D:/Xilinx/workspace/ALU/ALU_Test.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_Test;

	// Inputs
	reg clk;
	reg [31:0] ALU_A;
	reg [31:0] ALU_B;
	reg [4:0] ALU_OP;

	// Outputs
	wire [31:0] ALU_OUT;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.clk(clk), 
		.ALU_A(ALU_A), 
		.ALU_B(ALU_B), 
		.ALU_OP(ALU_OP), 
		.ALU_OUT(ALU_OUT)
	);

	initial begin
		// Initialize Inputs
		ALU_A = 0;
		ALU_B = 0;
		ALU_OP = 0;

		// Wait 100 ns for global reset to finish
		#100;
      ALU_A = 32'h0070;
		ALU_B = 32'h0007;
		#100;
		ALU_OP = 0;
		#50;
		ALU_OP = 1;
		#50;
		ALU_OP = 2;
		#50;
		ALU_OP = 3;
		#50;
		ALU_OP = 4;
		#50;
		ALU_OP = 5;
		#50;
		ALU_OP = 6;		
		// Add stimulus here

	end
	
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
endmodule

