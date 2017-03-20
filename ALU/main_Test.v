`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:09:18 03/15/2017
// Design Name:   main
// Module Name:   D:/Xilinx/workspace/Computer Organization Design/ALU/main_Test.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_Test;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [4:0] OP;

	// Outputs
	wire [31:0] OUT;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.A(A), 
		.B(B), 
		.OP(OP), 
		.OUT(OUT)
	);

	initial begin
		// Initialize Inputs
		A = 2;
		B = 2;
		OP = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

