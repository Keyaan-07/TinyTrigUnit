`default_nettype none

module cordic (
    input wire signed [15:0]x,
    input wire signed [15:0]y,
    input wire signed [15:0]z,
    output wire signed [15:0]xnew,
    output wire signed [15:0]ynew,
    output wire signed [15:0]znew,
    input wire [3:0]i,
    input wire signed [15:0]constant
);
wire d;
assign d = z[15];
wire signed [15:0]xshift = x>>>i;
wire signed [15:0]yshift = y>>>i;
assign xnew = x - ({16{d}}^yshift)   - (d);
assign ynew = y + ({16{d}}^xshift)   + (d);
assign znew = z - ({16{d}}^constant) - (d);


endmodule