`timescale 1ns/1ps

module uart_tb;

    // Clock and reset
    reg clk;
    reg rst_n;

    // UART Transmitter signals
    reg tx_start;
    reg [7:0] tx_data;
    wire tx_out;
    wire tx_busy;

    // UART Receiver signals
    wire [7:0] rx_data;
    wire rx_data_ready;

    // Clock generation: 100MHz clock -> Period = 10ns
    initial clk = 0;
    always #5 clk = ~clk;

    // Instantiate Transmitter
    uart_tx TX (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_out(tx_out),
        .tx_busy(tx_busy)
    );

    // Instantiate Receiver
    uart_rx RX (
        .clk(clk),
        .rst_n(rst_n),
        .rx_in(tx_out),
        .rx_data(rx_data),
        .rx_data_ready(rx_data_ready)
    );

    // Data to be sent
    reg [7:0] test_data [0:3]; // Array to store 4 bytes
    integer i;

    // Simulation sequence
    initial begin
        // Initialize
        rst_n = 0;
        tx_start = 0;
        tx_data = 8'd0;

        // Load test data
        test_data[0] = 8'hA5; // Example data 1
        test_data[1] = 8'h3C; // Example data 2
        test_data[2] = 8'h7E; // Example data 3
        test_data[3] = 8'h55; // Example data 4

        // Apply reset
        #50 rst_n = 1;

        // Send all bytes in sequence
        for (i = 0; i < 4; i = i + 1) begin
            send_byte(test_data[i]);
            // Wait for receiver to signal data ready
            wait (rx_data_ready == 1);
            // Check if received data matches sent data
            if (rx_data == test_data[i])
                $display("Test %0d PASSED: Sent = %h, Received = %h", i+1, test_data[i], rx_data);
            else
                $display("Test %0d FAILED: Sent = %h, Received = %h", i+1, test_data[i], rx_data);

            // Small gap between bytes
            #10000;
        end

        // Finish simulation
        #100 $finish;
    end

    // Task to send a single byte
    task send_byte(input [7:0] byte);
        begin
            tx_data = byte;
            tx_start = 1;
            #10 tx_start = 0; // Pulse tx_start for one clock cycle

            // Wait for transmission to complete (9 bits: 1 start + 8 data + stop)
            wait (tx_busy == 0);
        end
    endtask

endmodule
