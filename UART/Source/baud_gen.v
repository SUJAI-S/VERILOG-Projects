module baud_gen (
    input wire clk,
    input wire rst_n,
    output reg baud_clk
);
    parameter DIVISOR = 434; // Adjust according to clk and baud rate

    reg [15:0] count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
            baud_clk <= 0;
        end else if (count == DIVISOR - 1) begin
            count <= 0;
            baud_clk <= ~baud_clk;
        end else begin
            count <= count + 1;
        end
    end
endmodule
