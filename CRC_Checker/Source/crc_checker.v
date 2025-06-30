module crc_checker #(parameter WIDTH = 8) (
    input wire [WIDTH-1:0] received_crc,
    input wire [WIDTH-1:0] calculated_crc,
    output wire error
);
    assign error = (received_crc != calculated_crc);
endmodule
