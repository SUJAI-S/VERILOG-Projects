module uart_rx (
    input wire clk,
    input wire rst_n,
    input wire rx_in,
    output reg [7:0] rx_data,
    output reg rx_data_ready
);
    parameter BAUD_TICKS = 434; 

    reg [3:0] bit_index;
    reg [15:0] baud_count;
    reg [7:0] rx_shift_reg;
    reg [1:0] state;
    reg rx_in_sync;

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_data <= 8'd0;
            rx_data_ready <= 0;
            state <= IDLE;
            baud_count <= 0;
            bit_index <= 0;
        end else begin
            rx_data_ready <= 0;
            rx_in_sync <= rx_in;

            case (state)
                IDLE: begin
                    if (rx_in_sync == 0) begin // Start bit detected
                        baud_count <= BAUD_TICKS / 2;
                        bit_index <= 0;
                        state <= START;
                    end
                end
                START: begin
                    if (baud_count > 0)
                        baud_count <= baud_count - 1;
                    else begin
                        baud_count <= BAUD_TICKS - 1;
                        state <= DATA;
                    end
                end
                DATA: begin
                    if (baud_count > 0)
                        baud_count <= baud_count - 1;
                    else begin
                        baud_count <= BAUD_TICKS - 1;
                        rx_shift_reg <= {rx_in_sync, rx_shift_reg[7:1]};
                        if (bit_index == 7)
                            state <= STOP;
                        else
                            bit_index <= bit_index + 1;
                    end
                end
                STOP: begin
                    if (baud_count > 0)
                        baud_count <= baud_count - 1;
                    else begin
                        rx_data <= rx_shift_reg;
                        rx_data_ready <= 1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
