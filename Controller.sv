module controller (input clk, rst, start, gt, P1co, P2co, output reg outdone, readmem, writemem, inzP1, inzP2, incP1, incP2, LdP2, D1Ld, D2Ld, selectAdd, selectData);
	reg [4:0]ns, ps;
	parameter [4:0] idle = 4'd0, AddInzing = 4'd1, D1Lding = 4'd2, D2Lding = 4'd3, LdWaiting = 4'd4, swap1 = 4'd5, swap2 = 4'd6, incAdd2 = 4'd7, inc2Waiting = 4'd8, incAdd1 = 4'd9, inc1Waiting = 4'd10, done = 4'd11;
	
	always @(posedge clk, posedge rst) begin
		if(rst) ps <= 4'b0;
		else ps <= ns;
	end


	always @(ps, start)begin
		case(ps)
			idle : ns<= start ? AddInzing : idle;
			AddInzing : ns <= D1Lding;
			D1Lding : ns <= D2Lding;
			D2Lding : ns <= LdWaiting;
			LdWaiting : ns <= gt ? swap1 : incAdd2;
			swap1 : ns <= swap2;
			swap2 : ns <= incAdd2;
			incAdd2 : ns <= inc2Waiting;
			inc2Waiting : ns <= P2co ? incAdd1 : D1Lding;
			incAdd1 : ns <= inc1Waiting;
			inc1Waiting : ns <= P1co ? done : D1Lding;
			done : ns <= idle;
			default : ns <= idle;
		endcase
	end


	always @(ns,  start)begin
		outdone = 1'b0; readmem = 1'b0; writemem = 1'b0; inzP1 = 1'b0; inzP2 = 1'b0; incP1 = 1'b0; incP2 = 1'b0; LdP2 = 1'b0; selectAdd = 1'b0; selectData = 1'b0; D1Ld = 1'b0; D2Ld = 1'b0;
		case(ns)
			AddInzing :	begin
					inzP1 <= 1'b1;
					inzP2 <= 1'b1;
					end
			D1Lding :	begin
					selectAdd <= 1'b0;
					readmem <= 1'b1;
					D1Ld <= 1'b1;
					end
			D2Lding :	begin
					selectAdd <= 1'b1;
					readmem <= 1'b1;
					D2Ld <= 1'b1;
					end
			swap1 :		begin
					writemem <= 1'b1;
					selectAdd <= 1'b0;
					selectData <= 1'b1;
					end
			swap2 :		begin
					writemem <= 1'b1;
					selectAdd <= 1'b1;
					selectData <= 1'b0;
					end
			incAdd2 :	begin
					incP2 <= 1'b1;
					end
			incAdd1 :	begin
					incP1 <= 1'b1;
					end
			inc1Waiting :	begin
					LdP2 <= 1'b1;
					end
			done :		begin
					outdone <= 1'b1;
					end
		endcase
	end

endmodule
