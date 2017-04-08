`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:02:57 03/27/2017
// Design Name:   Top
// Module Name:   D:/Xilinx/workspace/Computer Organization Design/Ram_2/Test_top.v
// Project Name:  Ram_2
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

module Test_top;

	// Inputs
	reg clk;
	reg rst_n;
	reg clka;
	reg clkb;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.clka(clka), 
		.clkb(clkb)
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
   
	initial begin
		clka = 0;
		forever #5 clka = ~clka;
	end
	
	initial begin
		clkb = 0;
		forever #5 clkb = ~clkb;
	end
	
endmodule

