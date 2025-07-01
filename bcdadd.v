module bcdadd(sum, car, a, b, cin);
  input cin;
  input [3:0] a, b;
  output reg [3:0] sum;
  output reg car;
  reg [4:0] temp;  // Declared internally instead of as an output
  wire [6:0] sumseg;
 wire [6:0] carseg;
  

  always @(*) begin
    temp = a + b + cin;
    if (temp > 9) begin
      temp = temp + 6;
      car = 1;
      sum=temp;
    end else begin
      car = 0;
      sum=temp;
    end
    // Assign only the lower 4 bits to sum

  end

seg_7 su (sumseg,sum);
seg_7 ca (carseg,{3'd0,car});
endmodule
