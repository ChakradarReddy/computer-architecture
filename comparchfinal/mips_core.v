module mips_core(clock);

	input clock;
	
	
	reg[31:0] PC = 32'b0;
	
	
	wire [31:0] instruction;
	
	wire [5:0] funct;
	wire [4:0] rs, rt, rd, shamt;
	wire [25:0] address;
	wire [15:0] immediate;
	wire [5:0] opcode;
reg[31:0] out;
	
	// Signals
	wire read_reg_signal, write_reg_signal, regDst_signal;
	wire read_mem_signal, write_mem_signal;
	wire branch_signal;
	
	// Registers contents
	wire [31:0] write_data, rs_content, rt_content, memory_read_data;
	
	
	// Read the instruction
	read_instructions inst_mem (instruction, PC);
	
	inst_parser parse (opcode, rs, rt, rd, shamt, funct, immediate, address, instruction, PC);
	
	control_unit signals (read_reg_signal, write_reg_signal,read_mem_signal, write_mem_signal, regDst_signal, 
								 branch_signal, opcode, funct);
			 
	ALU32bit alu_process (write_data, branch_signal, opcode, rs_content, rt_content, shamt, funct, immediate);
	
	read_data_memory dataMemory (memory_read_data, write_data, rt_content, opcode, read_mem_signal, write_mem_signal);
	
	read_registers contents (rs_content, rt_content, write_data, rs, rt, rd, opcode, 
									read_reg_signal, write_reg_signal, regDst_signal, clock);
	
	// PC operations
	always @(posedge clock) begin 
        
		// jump 
		if(opcode == 6'b000010) begin
			PC = address;
		end
		
		// branch
		else if(write_data == 0 & branch_signal == 1) begin
			 out ={{16 {immediate [ 15 ]}},immediate};
                         //$display(out);
			PC = PC + 1 + out; 
			
		end
		else begin
			PC = PC+1;
		end
	end 


endmodule
