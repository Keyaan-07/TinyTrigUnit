module tb_cordic;

reg signed [15:0]x;
reg signed [15:0]y;
reg signed [15:0]z;
wire signed [15:0]xnew;
wire signed [15:0]ynew;
wire signed [15:0]znew;
reg [3:0]i;
reg signed [15:0]constant;

cordic c0 (
    .x (x),
    .y (y),
    .z (z),
    .xnew (xnew),
    .ynew (ynew),
    .znew (znew),
    .i (i),
    .constant (constant)
);

initial begin
    x = 9950; // 0.6072 in Q2.14
    y = 9950; // from i=0
    z = -3840; // 30 deg in Q8.8
    i = 1; // first iteration
    constant = 6801; // 26.5664 deg in Q8.8 (close enough to 26.5651, which is required)
    #5;
    $display ("xnew = %0d", xnew);
    $display ("ynew = %0d", ynew);
    $display ("znew = %0d", znew);
    $finish;
end

endmodule

/*
okay so the first iteration with these values:  
    x = 9950; // 0.6072 in Q2.14
    y = 0;    // 0 in Q2.14
    z = 7680; // 30 deg in Q8.8
    i = 0;    // first iteration
    constant = 11520; // 45 deg in Q8.8
gave these outputs:  
    xnew = 9950  // 0.6072 in Q2.14
    ynew = 9950  // 0.6072 in Q2.14
    znew = -3840 // -15 in Q2.14

this is i = 0 (first iteration)
now, putting these xnew, ynew and znew values in x, y and z gives us the following values for the second iteration(i=1):  
    x = 9950; // 0.6072 in Q2.14
    y = 9950; // from i=0
    z = -3840; // 30 deg in Q8.8
    i = 1; // first iteration
    constant = 6801; // 26.5664 deg in Q8.8 (close enough to 26.5651, which is required)
which gives us the output:  
    xnew = 14925 // 0.9109 in Q2.14
    ynew = 4975  // 0.3036 in Q2.14
    znew = 2961  // 11.566 deg in Q8.8
*/