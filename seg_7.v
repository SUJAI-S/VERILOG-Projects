module seg_7(y,x);
output reg [6:0] y;
input [3:0] x;
always@(*)begin
case(x)
        
            4'd0 : y = 7'b1111110;
            4'd1 : y = 7'b0110000;
            4'd2 : y = 7'b1101101;
            4'd3 : y = 7'b1111001;
            4'd4 : y = 7'b0110011;
            4'd5 : y = 7'b1011011;
            4'd6 : y = 7'b1011111;
            4'd7 : y = 7'b1110000;
            4'd8 : y = 7'b1111111;
            4'd9 : y = 7'b1111011;
endcase
end
endmodule
