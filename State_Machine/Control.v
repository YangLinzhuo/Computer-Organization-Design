`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:20 04/08/2017 
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
output	reg				[31:0]	ALU_B,
output	reg				[4:0]		ALU_OP,
output 	reg						   wea,
output   reg				[7:0] 	addra,
output 	reg				[31:0] 	dina,
output 	reg				[7:0] 	addrb,
input 			signed	[31:0] 	doutb
    );

parameter	IDLE = 0;
parameter	READ = 1;

reg	[5:0]	count = 5'h0;	//记录当前读取寄存器的次数
reg	[3:0]	alu_num = 4'h0; //记录当前读取到数字的次数
reg	[3:0] alu_op = 4'h0;	//记录读取运算符的次数 
reg			sign = 0;	//记录是否读到符号 -1
reg	[1:0]	cur_state = IDLE;
reg	[1:0] next_state = IDLE;


/* 时钟分频 */
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		count <= 2'h0;
	else if(count == 2'h3)
		count <= 2'h0;
	else
		count <= count + 2'h1;
end


/* 处理 sign*/
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		sign <= 0;
	else if(doutb == -1 || sign == 1)
		sign <= 1;
end


/* 处理 cur_state */
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		cur_state <= IDLE;
	else if(sign == 1)
		cur_state <= IDLE;
	else
		cur_state <= next_state;
end


/* 处理 next_state */
always@(*)
begin
	if(~rst_n)
		next_state = IDLE;
	else if(sign == 1)
		next_state = IDLE;
	else
	begin
		case(cur_state)
			IDLE: next_state = READ;
			READ: next_state = READ;
			default: next_state = IDLE;
		endcase
	end
end


/* 处理 ram 写地址 */
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		addra <= 8'd200;
		r3_addr <= 5'h0;
	end
	else if(count >= 9 && count % 3 == 0 && sign != 1) /**/
	begin
		addra <= addra + 8'h1;
	end
	else
	begin
		addra <= addra;
		r3_addr <= r3_addr;
	end
end


/* 处理 ram 读地址*/

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		count <= 4'h0;
	end 
	else if(cur_state != IDLE)
	begin
		count <= count + 4'h1;
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		alu_num <= 0;
	else if(next_state != IDLE)
	begin
		if(count == 0)
			alu_num <= alu_num;
		else if(count % 3 == 0 || count % 3 == 1)
			alu_num <= alu_num + 1;
		else if(count == 2)
			alu_num <= alu_num + 1;
		else
			alu_num <= alu_num;
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		addrb <= 8'h0;
		alu_op <= 4'h0;
	end
	else if(next_state != IDLE)
	begin
		if(count % 3 == 0 || count % 3 == 1)
		begin	
			if(count <= 1)
				addrb <= count;
			else 
				addrb <= alu_num;
		end
		else if(count % 3 == 2)
		begin
			addrb <= alu_op + 8'd100;
			alu_op <= alu_op + 4'h1;
		end
	end
	else
	begin
		addrb <= addrb;
		alu_op <= alu_op;
	end
end


/* 读取计算 */

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		ALU_A <= 32'h0;
		ALU_B <= 32'h0;
		ALU_OP <= 5'h0;
	end
	else if(cur_state != IDLE)
	begin
		if(count >= 5)
		begin
			case(count % 3)
				5'h2: ALU_A <= r1_out;
				5'h0: ALU_B <= r2_out;
				5'h1: ALU_OP <= r1_out;
			endcase
		end
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		r1_addr <= 5'h0;
		r2_addr <= 5'h1;
		r3_addr <= 5'h0;
	end
	else
	begin
		if(cur_state != IDLE && count >= 5 && count % 3 == 2)
			r1_addr <= r1_addr + 5'h2;
		else if(cur_state != IDLE && count >= 5 && count % 3 == 0) 
		begin
			r1_addr <= r1_addr + 5'h1;
		end
		if(cur_state != IDLE && count >= 5 && count % 3 == 1)
		begin
			r2_addr <= r2_addr + 5'h3;
		end
		if(cur_state != IDLE && count >= 3)
		begin
			r3_addr <= r3_addr + 5'h1;
		end
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		r3_in <= 32'h0;
	end
	else if(cur_state != IDLE)
	begin
		r3_in <= doutb;
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		r3_we <= 0;
	end
	
	else if(cur_state != IDLE && count >= 2 && sign != 1)
	begin
		r3_we <= 1;
	end
	
	else
	begin
		r3_we <= 0;
	end
end


/* 写入 */
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		wea <= 0;
	end
	else if(count >= 7 && count % 3 == 2)
	begin
		wea <= 1;
	end
	else
	begin
		wea <= 0;
	end
end


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		dina <= 32'h0;
	end
	else if(count >= 8 && count % 3 == 2)
	begin
		dina <= ALU_OUT;
	end
end

endmodule
