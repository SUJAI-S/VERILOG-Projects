module mux16_1(y,x,s,en);
output y;
input en;
input [15:0] x;
input [3:0] s;
wire [3:0]w;
assign en=1'b1;
 mux4_1 f1(w[0],x[3:0],en,s[1:0]);
 mux4_1 f2(w[1],x[7:4],en,s[1:0]);
 mux4_1 f3(w[2],x[11:8],en,s[1:0]);
 mux4_1 f4(w[3],x[15:12],en,s[1:0]);
 mux4_1 f5(y,w[3:0],en,s[3:2]);
endmodule

