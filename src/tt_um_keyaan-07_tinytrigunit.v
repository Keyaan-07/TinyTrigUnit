/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_tinytrigunit (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  // state = 0 is idle, and state = 1 is compute
  reg state = 0; 
  reg [15:0] x_reg;
  reg [15:0] y_reg;


  // values of arctan of powers of 2 from 0 to -11, preloaded: 
  reg [15:0] rom [15:0] = {16'd11520, 16'd6801, 16'd3593, 16'd1824, 16'd916, 16'd458, 16'd229, 16'd115, 16'd57, 16'd29, 16'd14, 16'd7};
  

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
