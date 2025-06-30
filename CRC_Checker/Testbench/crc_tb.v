`timescale 1ns/1ps

module crc_tb;

    reg clk, reset, data_valid;
    reg [7:0] data_in;
    wire [7:0] crc_out;

    reg [7:0] received_crc;
    wire error;

    // Instantiate CRC Generator
    crc_generator uut_gen (
        .clk(clk),
        .reset(reset),
        .data_valid(data_valid),
        .data_in(data_in),
        .crc_out(crc_out)
    );

    // Instantiate CRC Checker
    crc_checker uut_check (
        .received_crc(received_crc),
        .calculated_crc(crc_out),
        .error(error)
    );

    // Clock generation
    always #5 clk = ~clk;

    task send_byte(input [7:0] byte);
    begin
        data_valid = 1;
        data_in = byte;
        #10;
        data_valid = 0;
        #10; // Wait one clock cycle
    end
    endtask

    initial begin
        // Initialize signals
        clk = 0; reset = 1; data_valid = 0; data_in = 0; received_crc = 0;

        // Apply reset
        #20 reset = 0;

        // Send data bytes with 1-clock data_valid pulse
        #10;
        send_byte(8'hAB);
        send_byte(8'hCD);
        send_byte(8'hEF);

        // Wait for CRC to be calculated
        #30;

        // Use the correct CRC
        received_crc = crc_out;
        #10;

        if (error)
            $display("Test Failed: CRC Error Detected!");
        else
            $display("Test Passed: No CRC Error!");

        // Introduce a CRC error
        received_crc = crc_out ^ 8'h01;  // Flip 1 bit
        #10;

        if (error)
            $display("Test Passed: CRC Error Detected!");
        else
            $display("Test Failed: Error Not Detected!");

        #10 $stop;
    end

endmodule

