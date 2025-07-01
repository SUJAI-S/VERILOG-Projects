module fulladder(y,car,a,b,cin);
input a,b,cin;
output y,car;
xor(y,a,b,cin);
assign car=((a^b)&cin)|(a&b);
endmodule
