`timescale 1ns/1ns

module SelectionSorter(input clk, rst, start, output reg outdone);
	wire gt;
	wire [7:0] addrBus;
	wire [15:0] inBus;

	reg rdyMem, readMem, writeMem, selectAdd, selectData, inzP1, inzP2, incP1, incP2, LdP2, D1Ld, D2Ld, P1co, P2co;
	wire [7:0] P1, P2;
	reg [15:0] D1, D2, outBus;

	controller CT(clk, rst, start, gt, P1co, P2co, outdone, readMem, writeMem, inzP1, inzP2, incP1, incP2, LdP2, D1Ld, D2Ld, selectAdd, selectData);
	
	Memory mem(clk, rst, readMem, writeMem, addrBus, inBus, rdyMem, outBus);

	MUX #(8) AddMUX(selectAdd,P1, P2, addrBus);
	MUX #(16) DataMUX(selectData, D1, D2, inBus);

	comparator cmp( D1, D2, gt);

	register_8bit_P1 regP1(clk, rst, inzP1, incP1, P1, P1co);
	register_8bit_P2 regP2(clk, rst, inzP2, incP2, LdP2, P1, P2, P2co);

	register_16bit regD1(clk, rst, D1Ld, outBus, D1);
	register_16bit regD2(clk, rst, D2Ld, outBus, D2);
endmodule
