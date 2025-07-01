module mux8_1(
    output y,
    input [7:0] x,
    input [2:0] s
);
wire w0,w1;
mux4_1 f1(w0,x[3:0],en,s[1:0]);
mux4_1 f2(w1,x[7:4],en,s[1:0]);
assign y=(s[2]==1'b1) ? w1 : w0;
endmodule


