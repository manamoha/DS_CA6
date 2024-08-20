`timescale 1ns/1ns



module MUX #(parameter BIT_SIZE) (input select,input [BIT_SIZE-1:0] in1, in2,output [BIT_SIZE-1:0] out);
	assign out=(~select)?in1:in2;
endmodule



module comparator(input [15:0] A, B,output gt);
	assign gt = (A>B) ? 1 : 0;
endmodule



module register_8bit_P1(input clk,rst,inzP1,incP1,output reg [7:0]PO1,output reg CO1);
	always @(posedge clk,posedge rst) begin
		if(rst) PO1 <= 8'd0;
		else begin
			if(inzP1)
				PO1<=8'd0;	
			if(incP1)begin
				PO1<=PO1+1;
			end
		end
	end
	assign CO1 = &(PO1);
endmodule



module register_8bit_P2(input clk,rst,inzP2,incP2,LdP2,input [7:0] PI1,output reg [7:0]PO2,output reg CO2);
	always @(posedge clk,posedge rst) begin
		if(rst) PO2 <= 8'd1;
		else begin
			if(inzP2)
				PO2<=8'b1;	
			if(incP2)begin
				PO2<=PO2+1;
			end
			if(LdP2) begin
				PO2 <= PI1 + 1;
			end
		end
	end

	assign CO2 = ~(|(PO2));
endmodule






module register_16bit(input clk,rst,ld,input [15:0]PI,output reg [15:0] PO);
	always @(posedge clk, posedge rst) begin
		if (rst)
			PO<=16'd0;
		else begin
		if(ld)
			PO<=PI+1;
		end
	end
endmodule



