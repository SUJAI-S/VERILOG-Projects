module mod5_counter (
    input clk,           // Clock input
    input reset,         // Active-high synchronous reset
    output reg [3:0] count  // 4-bit output (BCD style)
);

always @(posedge clk) begin
    if (reset)
        count <= 4'd0;            // Reset to 0
    else if (count == 4'd4)
        count <= 4'd0;            // Wrap around after 4
    else
        count <= count + 1;       // Increment count
end

endmodule

