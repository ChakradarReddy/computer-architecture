module read_registers(
	output reg [31:0] read_data_1, read_data_2,
	input [31:0] write_data,
	input [4:0] read_reg_1, read_reg_2, write_reg, 
	input [5:0] opcode,
	input signal_regRead, signal_regWrite, signal_regDst, clk
);
   integer i,j;
	reg signed [31:0] registers [0:31];
	
	 initial begin
	 	$readmemb("registers.mem", registers);
	// 	$display("3");
	 end
	
	always @(write_data ,signal_regWrite) begin
		// Write
	if(signal_regWrite) begin
		
			// write to rt if signal_regDst is 0, otherwise write to rd 
			if(signal_regDst) begin
				
					registers[write_reg] <= write_data;
					 
				end
			
			else begin
			
					registers[read_reg_2]<= write_data;
				
				end
			
			// write to file
			$writememb("registers.mem",registers);
		end
		
	
	end
	
	always @(read_reg_1, read_reg_2) begin
		// Read
			//$readmemb("registers.mem", registers);
		if(signal_regRead) begin
			read_data_1 = registers[read_reg_1];
			read_data_2 = registers[read_reg_2];
		end
	end

endmodule
