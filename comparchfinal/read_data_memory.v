module read_data_memory(
	output [31:0] read_data,
	input  [31:0] address,
					  write_data,
	input [5:0] opcode,
	input sig_mem_read,
			sig_mem_write
);
	assign read_data = data_mem[address];
	reg [31:0] data_mem [0:255];
	
	initial begin
		$readmemb("data.dat", data_mem);
	end
	
	always @(address) begin
		if(sig_mem_write) begin
			
				data_mem[address] = write_data;
                                  $writememb("data.dat", data_mem);
			end
		
			// write to file
			
		
      $writememb("data.dat", data_mem);
	end


endmodule
