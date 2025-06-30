module crc_generator #(parameter WIDTH = 8, parameter POLY = 8'h07) (
    input wire clk,
    input wire reset,
    input wire data_valid,
    input wire [7:0] data_in,
    output reg [WIDTH-1:0] crc_out
);

    reg [WIDTH-1:0] crc;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            crc <= 0;
        end else if (data_valid) begin
            crc <= next_crc(crc, data_in);
        end
    end

    always @(*) begin
        crc_out = crc;
    end

    // Function to calculate next CRC value
    function [WIDTH-1:0] next_crc;
        input [WIDTH-1:0] current_crc;
        input [7:0] data_byte;

        reg [WIDTH-1:0] temp_crc;
        reg [7:0] temp_data;
        integer i;
        begin
            temp_crc = current_crc;
            temp_data = data_byte;

            for (i = 0; i < 8; i = i + 1) begin
                if ((temp_crc[WIDTH-1] ^ temp_data[7]) == 1'b1)
                    temp_crc = (temp_crc << 1) ^ POLY;
                else
                    temp_crc = temp_crc << 1;

                temp_data = temp_data << 1;
            end
            next_crc = temp_crc;
        end
    endfunction

endmodule

