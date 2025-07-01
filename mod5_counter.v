module mod5_counter (
    input clk,
    input reset,
    output reg [2:0] count  // 3 bits are enough for mod-5 (0 to 4)
);

always @(posedge clk) begin
    if (reset)
        count <= 3'd0;                // Synchronous reset to 0
    else if (count == 3'd4)
        count <= 3'd0;                // Roll over at 5
    else
        count <= count + 1;           // Count up
end

endmodule

