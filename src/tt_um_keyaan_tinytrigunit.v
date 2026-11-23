/*
- Copyright (c) 2026 Keyaan Khatri
- SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_keyaan_tinytrigunit (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [3:0] step;
  // values of arctan of powers of 2 from 0 to -11, hardwired:
  reg [15:0] rom_val;
  always @(*) begin
    case (step[3:0])
      4'd0:  rom_val = 16'd11520;
      4'd1:  rom_val = 16'd6801 ;
      4'd2:  rom_val = 16'd3593 ;
      4'd3:  rom_val = 16'd1824 ;
      4'd4:  rom_val = 16'd916  ;
      4'd5:  rom_val = 16'd458  ;
      4'd6:  rom_val = 16'd229  ;
      4'd7:  rom_val = 16'd115  ;
      4'd8:  rom_val = 16'd57   ;
      4'd9:  rom_val = 16'd29   ;
      4'd10: rom_val = 16'd14   ;
      4'd11: rom_val = 16'd7    ;
      default: rom_val = 16'd0;
    endcase
  end

  reg [15:0] xval;
  reg [15:0] yval;
  reg [15:0] zval;
  wire [15:0] xout;
  wire [15:0] yout;
  wire [15:0] zout;
  reg state;

  cordic_keyaan main(
    .x (xval),
    .y (yval),
    .z (zval),

    .xnew (xout),
    .ynew (yout),
    .znew (zout),

    .i (step),
    .constant (rom_val)
  );

  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
      step <= 4'd0;
      xval <= 16'b0010011011011100; // 0.6072 in Q2.14
      yval <= 16'd0;
      zval <= 16'd0;
      state <= 0;
    end else begin
      if(state) begin
        if (step == 4'd11) begin
          step <= 4'd0;
          state <= 1'd0;
        end else begin
          step <= step + 1'b1;
        end
        xval <= xout;
        yval <= yout;
        zval <= zout;  
      end
      else begin
        zval[15:8] <= ui_in;
        if(uio_in[2]) begin
          state <= 1;
        end
      end
    end
  end

  // just for compiling atm
  assign uio_oe = 8'b00000000;
  assign uo_out = state ? zval[15:8]: xval[15:8];
  assign uio_out = 8'd8;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:3], uio_in[1:0],  1'b0};

endmodule