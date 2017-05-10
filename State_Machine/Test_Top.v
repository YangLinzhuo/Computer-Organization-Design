`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:10:07 04/08/2017
// Design Name:   Top
// Module Name:   D:/Xilinx/workspace/Computer Organization Design/State_Machine/Test_Top.v
// Project Name:  State_Machine
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
	reg rst_n;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst_n = 1;  
		// Add stimulus here
	end
	
	initial begin
		clk = 0;
		
		forever #5 clk = ~clk;
	end
      
endmodule

