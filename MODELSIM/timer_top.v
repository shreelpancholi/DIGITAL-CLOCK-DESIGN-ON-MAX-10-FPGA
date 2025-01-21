module timer_top
   #(parameter CLOCK_FREQ = 32'd50_000_000)
   (
    input clk,
    input rst_n,
    output [6:0] o_HEX0,
    output [6:0] o_HEX1,
    output [6:0] o_HEX2,
    output [6:0] o_HEX3,
    output [6:0] o_HEX4,
    output [6:0] o_HEX5
   );

   wire [5:0] o_seconds;
   wire [5:0] o_minutes;
   wire [6:0] o_hours;
   wire [11:0] seconds_bcd;
   wire [11:0] minutes_bcd;
   wire [11:0] hours_bcd;

   timer #(.CLOCK_FREQ(CLOCK_FREQ))
      TMR0
   (
      .clk(clk),
      .rst_n(rst_n),
      .o_seconds(o_seconds),
      .o_minutes(o_minutes),
      .o_hours(o_hours)
   );

   bin2bcd
      B2D_SEC
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({2'b0, o_seconds}),
      .o_bcd(seconds_bcd)
   );

   bin2bcd
      B2D_MIN
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({2'b0,o_minutes}),
      .o_bcd(minutes_bcd)
   );

   bin2bcd
      B2D_HOUR
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({1'b0, o_hours}),
      .o_bcd(hours_bcd)
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      SEC0
   (
      .in(seconds_bcd[3:0]),
      .o_a(o_HEX0[0]),
      .o_b(o_HEX0[1]),
      .o_c(o_HEX0[2]),
      .o_d(o_HEX0[3]),
      .o_e(o_HEX0[4]),
      .o_f(o_HEX0[5]),
      .o_g(o_HEX0[6])
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      SEC1
   (
      .in(seconds_bcd[7:4]),
      .o_a(o_HEX1[0]),
      .o_b(o_HEX1[1]),
      .o_c(o_HEX1[2]),
      .o_d(o_HEX1[3]),
      .o_e(o_HEX1[4]),
      .o_f(o_HEX1[5]),
      .o_g(o_HEX1[6])
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      MIN0
   (
      .in(minutes_bcd[3:0]),
      .o_a(o_HEX2[0]),
      .o_b(o_HEX2[1]),
      .o_c(o_HEX2[2]),
      .o_d(o_HEX2[3]),
      .o_e(o_HEX2[4]),
      .o_f(o_HEX2[5]),
      .o_g(o_HEX2[6])
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      MIN1
   (
      .in(minutes_bcd[7:4]),
      .o_a(o_HEX3[0]),
      .o_b(o_HEX3[1]),
      .o_c(o_HEX3[2]),
      .o_d(o_HEX3[3]),
      .o_e(o_HEX3[4]),
      .o_f(o_HEX3[5]),
      .o_g(o_HEX3[6])
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      HOUR0
   (
      .in(hours_bcd[3:0]),
      .o_a(o_HEX4[0]),
      .o_b(o_HEX4[1]),
      .o_c(o_HEX4[2]),
      .o_d(o_HEX4[3]),
      .o_e(o_HEX4[4]),
      .o_f(o_HEX4[5]),
      .o_g(o_HEX4[6])
   );

   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      HOUR1
   (
      .in(hours_bcd[7:4]),
      .o_a(o_HEX5[0]),
      .o_b(o_HEX5[1]),
      .o_c(o_HEX5[2]),
      .o_d(o_HEX5[3]),
      .o_e(o_HEX5[4]),
      .o_f(o_HEX5[5]),
      .o_g(o_HEX5[6])
   );

endmodule
