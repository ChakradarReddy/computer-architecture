module ALU32bit(ALU_result, sig_branch, opcode, rs_content, rt_content, shamt, ALU_control, immediate);
	
	input [5:0] ALU_control, opcode;
	input [4:0] shamt; 
	input [15:0] immediate;
	input [31:0] rs_content, rt_content; 
	
	output reg sig_branch;
	output reg [31:0] ALU_result; 
	
	integer i; 	
	reg signed [31:0] temp, signed_rs, signed_rt; 
	reg [31:0] signExtend, zeroExtend;

	always @ (ALU_control, rs_content, rt_content, shamt, immediate) begin
		
		
		
		signed_rs = rs_content;
		signed_rt = rt_content;
			
			
	     // R type
		if(opcode == 6'h0) begin
			
			case(ALU_control)
			    
				
				6'h20 : //add
					ALU_result = signed_rs + signed_rt;
				
				6'h21 : //addu
					ALU_result = rs_content + rt_content;
					
				6'h22 : //sub
					ALU_result = signed_rs - signed_rt;
					
				6'h23 : //subu
					ALU_result = rs_content - rt_content;
					
				6'h24 : //and
					ALU_result = rs_content & rt_content;
					
				6'h25 : //or
					ALU_result = rs_content | rt_content;
					
				6'h27 : //nor
					ALU_result = ~(rs_content | rt_content);
				
							
				6'h2a : //slt
					begin
						if(signed_rs < signed_rt) begin
							ALU_result = 1;
						end else begin
							ALU_result = 0;
						end
					end
			
			endcase //case
			
		end // if
		
		
		
		// I type
		else begin
			
			signExtend = {{16{immediate[15]}}, immediate};
			zeroExtend = {{16{1'b0}}, immediate};
			
			case(opcode)
		        6'b111110:  //mul
				    begin
				    ALU_result<=signed_rs*signed_rt;
					//$display("hi");
					//$display(signed_rs);

					//$display(signed_rt);
					//$display("hi1");

					end
				6'h8 : // addi
					ALU_result = signed_rs + signExtend;
					
				6'h9 : // addiu
					ALU_result = rs_content + signExtend;
				
							
				6'h4 : // beq
					begin
						// if the result is zero, they are equal go branch!
						ALU_result = signed_rs - signed_rt;
						if(ALU_result == 0) begin
							sig_branch = 1'b1;
						end
						else begin
							sig_branch = 1'b0;
						end
					end
				
				6'h5 : // bne
					begin
					
						
						ALU_result = signed_rs - signed_rt;
						if(ALU_result != 0) begin
							sig_branch = 1'b1;
							ALU_result = 1'b0;
						end
						else begin
							sig_branch = 1'b0;
						end
					end
							
							
				
				6'b101011 : // sw
					ALU_result = signed_rs + signExtend;
				6'h23 : // lw
					ALU_result = signed_rs + signExtend;
				
				
			endcase
		
		end
		
	end
	
	

	
endmodule
