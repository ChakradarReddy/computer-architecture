module mips_testbench ();

	reg clock;
	wire result;
	
	mips_core uut(clock);
        initial begin
  $dumpfile("mips.vcd");
  $dumpvars(0,mips_testbench);
	 clock = 1;
end
	always
		#50 clock=~clock; 
	


endmodule
