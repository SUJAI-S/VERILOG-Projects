module braunmul1(y, a, b);
    input [3:0] a, b;
    output [7:0] y;

    wire [3:0] pp0, pp1, pp2, pp3;
    wire [3:0] s1, s2, s3;
    wire [3:0] c1, c2, c3;

    // Generate partial products
    assign pp0 = a & {4{b[0]}};
    assign pp1 = a & {4{b[1]}};
    assign pp2 = a & {4{b[2]}};
    assign pp3 = a & {4{b[3]}};

    // Row 0
    assign y[0] = pp0[0];

    // Row 1
    fulladd fa1(y[1], c1[0], pp0[1], pp1[0], 1'b0);
    fulladd fa2(s1[0], c1[1], pp0[2], pp1[1], c1[0]);
    fulladd fa3(s1[1], c1[2], pp0[3], pp1[2], c1[1]);
    assign s1[2] = pp1[3];  // Direct pass since only one bit remains
    assign c1[3] = 1'b0;    // No carry yet

    // Row 2
    fulladd fa4(y[2], c2[0], s1[0], pp2[0], 1'b0);
    fulladd fa5(s2[0], c2[1], s1[1], pp2[1], c2[0]);
    fulladd fa6(s2[1], c2[2], s1[2], pp2[2], c2[1]);
    fulladd fa7(s2[2], c2[3], c1[2], pp2[3], c2[2]);

    // Row 3
    fulladd fa8(y[3], c3[0], s2[0], pp3[0], 1'b0);
    fulladd fa9(s3[0], c3[1], s2[1], pp3[1], c3[0]);
    fulladd fa10(s3[1], c3[2], s2[2], pp3[2], c3[1]);
    fulladd fa11(s3[2], c3[3], c2[3], pp3[3], c3[2]);

    // Final output assignments
    assign y[4] = s3[0];
    assign y[5] = s3[1];
    assign y[6] = s3[2];
    assign y[7] = c3[3];

endmodule
