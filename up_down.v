module up_down(
    output reg [3:0] q,
    input clk,
    input rst,
    input sel
);

always @(posedge clk) begin
    if (rst == 1) begin
        q <= 4'd0;          // Synchronous reset
    end
    else if (sel == 1) begin
        q <= q + 1;         // Count up
    end
    else begin
        q <= q - 1;         // Count down
    end
end

endmodule

