module gates(y,a,b);
input [6:0] a,b;
output [6:0] y;
//and
assign y[0]=a[0]&b[0];
//or
assign y[1]=a[1]|b[1];
//not
assign y[2]= ~a[2];
//nand
assign y[3]= ~(a[3]&b[3]);
//nor
assign y[4]= ~(a[4]|b[4]);
//xor
assign y[5]=a[5]^b[5];
//xnor
assign y[6]= ~(a[6]^b[6]);
endmodule
