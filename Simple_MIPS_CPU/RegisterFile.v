`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:33 04/16/2017 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(
input										clk,
input										clk_r,
input										rst_n,
input			 		  		[4:0] 	r1_addr,	//��ȡ��ַ1
input			 		  		[4:0] 	r2_addr,	//��ȡ��ַ2
input					  		[4:0] 	r3_addr,	//д���ַ
input				signed	[31:0]	r3_in,	//д������
input										r3_we,	//дʹ��
output	reg 	signed	[31:0]	r1_out,	//���1
output	reg 	signed	[31:0]	r2_out	//���2
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

always@(posedge clk_r or negedge rst_n)
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
