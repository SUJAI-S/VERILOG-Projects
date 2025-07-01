module dflip(
    input wire clk,
    input wire rst,  // active-high reset
    input wire d,
    output reg q0,
    output wire q
);

    // On positive clock edge, store D to Q0
    always @(posedge clk) begin
        if (rst)
            q0 <= 1'b0;     // Reset output to 0
        else
            q0 <= d;        // Normal D Flip-Flop operation
    end

    assign q = ~q0;  // Complementary output

endmodule

