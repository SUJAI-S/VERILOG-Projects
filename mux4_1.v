module mux4_1(y,x,en,s);
output reg y;
input en;
input [3:0] x;
input [1:0]s;
assign en=1'b1;
always@(*) begin
case(s)
 2 'b00: y = x[0];
 2 'b01: y = x[1];
 2 'b10: y = x[2];
 2 'b11: y = x[3];
endcase
end
endmodule
