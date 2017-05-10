`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:29:59 04/16/2017
// Design Name:   Top
// Module Name:   D:/Xilinx/workspace/Computer Organization Design/Simple_MIPS_CPU/Test_Top.v
// Project Name:  Simple_MIPS_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Top;

	// Inputs
	reg clk;
	reg clk_r;
	reg rst_n;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.clk_r(clk_r), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#30;
      rst_n = 1; 
		// Add stimulus here

	end
	
	initial
	begin
		clk = 0;
		forever	#15	clk = ~clk;
	end
	
	initial
	begin
		clk_r = 1;
		forever #1 clk_r = ~clk_r;
	end
      
endmodule

