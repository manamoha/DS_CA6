`timescale 1ns/1ns

module SSTB();
	reg clk, rst = 0,  start = 0, done;
	initial begin
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		start = 1;
		#5;
		clk = 1;
		#5;
		clk = 0;
		start = 0;

		forever begin
			#5;
			clk = ~clk;
		end
	end
	SelectionSorter SS(clk, rst, start, done);
endmodule
