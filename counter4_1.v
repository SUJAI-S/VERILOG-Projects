module counter4_1(q,clk,rst,sel);
output reg [3:0] q;
input clk,rst,sel;
always@( posedge clk)begin
if(rst==0 && sel==1)
 begin
 q <=q+4'd1;
 end
else if(rst==0 && sel==0)
 begin
 q <=q-4'd1;
 end
else
q <=0;
end
endmodule

