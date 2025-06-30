module uart_tx (
    input wire clk,
    input wire rst_n,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx_out,
    output reg tx_busy
);
    parameter BAUD_TICKS = 434; // Adjust as per clock and baud rate

    reg [3:0] bit_index;
    reg [15:0] baud_count;
    reg [9:0] tx_shift_reg;

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_out <= 1'b1;
            tx_busy <= 1'b0;
            state <= IDLE;
            baud_count <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx_out <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        tx_shift_reg <= {1'b1, tx_data, 1'b0}; // {stop, data, start}
                        baud_count <= 0;
                        bit_index <= 0;
                        tx_busy <= 1'b1;
                        state <= START;
                    end
                end
                START, DATA, STOP: begin
                    if (baud_count < BAUD_TICKS - 1)
                        baud_count <= baud_count + 1;
                    else begin
                        baud_count <= 0;
                        tx_out <= tx_shift_reg[0];
                        tx_shift_reg <= {1'b1, tx_shift_reg[9:1]};
                        if (bit_index == 9)
                            state <= IDLE;
                        else
                            bit_index <= bit_index + 1;
                    end
                end
            endcase
        end
    end
endmodule
