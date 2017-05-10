`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:21 05/02/2017 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File(
input							clk,
input							rst_n,
input			 		 [4:0] 	r1_addr,	//读取地址1
input			 		 [4:0] 	r2_addr,	//读取地址2
input					 [4:0] 	r3_addr,	//写入地址
input			signed	[31:0]	r3_in,	//写入数据
input							r3_we,	//写使能
output	reg 	signed	[31:0]	r1_out,	//输出1
output	reg 	signed	[31:0]	r2_out	//输出2
    );

reg [31:0] reg_stack [31:0];
integer i;

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		for(i = 0; i < 32; i = i + 1)
		begin
			reg_stack[i] <= 32'h0;
		end
	end
	else if(r3_we)
	begin
		reg_stack[r3_addr] <= r3_in;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			r1_out <= 32'h0;
			r2_out <= 32'h0;	
		end
	else
		begin
			r1_out <= reg_stack[r1_addr];
			r2_out <= reg_stack[r2_addr];
		end
end

endmodule
