module timer_top
   #(parameter CLOCK_FREQ = 32'd50_000_000)  // Default clock frequency: 50 MHz
   (
    input clk,              // Clock input
    input rst_n,            // Active-low reset
	 input start_stop,
	 input select_seconds,
	 input select_minutes,
	 input select_hours,
	 input increment,
	 inout save,
    output [6:0] o_HEX0,    // 7-segment display outputs
    output [6:0] o_HEX1,    // HEX0-HEX1: Seconds
    output [6:0] o_HEX2,    // HEX2-HEX3: Minutes
    output [6:0] o_HEX3,    // HEX4-HEX5: Hours
    output [6:0] o_HEX4,
    output [6:0] o_HEX5
   );
   //wires to connect modules
   wire [5:0] o_seconds;
   wire [5:0] o_minutes;
   wire [6:0] o_hours;
   wire [7:0] seconds_bcd;  //  8 bits
   wire [7:0] minutes_bcd;  //  8 bits
   wire [7:0] hours_bcd;    //  8 bits
   // Timer module instance
   timer #(.CLOCK_FREQ(CLOCK_FREQ))
      TMR0
   (
      .clk(clk),
      .rst_n(rst_n),
		.start_stop(start_stop),
		.select_seconds(select_seconds),
		.select_minutes(select_minutes),
		.select_hours(select_hours),
		.increment(increment),
		.save(save),
      .o_seconds(o_seconds),
      .o_minutes(o_minutes),
      .o_hours(o_hours)
   );
   // Binary to BCD converter for seconds
   bin2bcd
      B2D_SEC
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({2'b0, o_seconds}),  // completing the 8 bits
      .o_bcd(seconds_bcd)
   );
   // Binary to BCD converter for minutes
   bin2bcd
      B2D_MIN
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({2'b0,o_minutes}),   // completing the 8 bits
      .o_bcd(minutes_bcd)
   );
   // Binary to BCD converter for hours
   bin2bcd
      B2D_HOUR
   (
      .clk(clk),
      .rst_n(rst_n),
      .i_bin({1'b0, o_hours}),    // completing the 8 bits
      .o_bcd(hours_bcd)
   );
   // 7-segment decoders for each digit
   // Seconds - least significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))    
      SEC0
   (
      .in(seconds_bcd[3:0]),      // Use lower 4 bits of BCD seconds
      .o_a(o_HEX0[0]),
      .o_b(o_HEX0[1]),
      .o_c(o_HEX0[2]),
      .o_d(o_HEX0[3]),
      .o_e(o_HEX0[4]),
      .o_f(o_HEX0[5]),
      .o_g(o_HEX0[6])
   );
   // Seconds - most significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      SEC1
   (
      .in(seconds_bcd[7:4]),      // Use upper 4 bits of BCD seconds
      .o_a(o_HEX1[0]),
      .o_b(o_HEX1[1]),
      .o_c(o_HEX1[2]),
      .o_d(o_HEX1[3]),
      .o_e(o_HEX1[4]),
      .o_f(o_HEX1[5]),
      .o_g(o_HEX1[6])
   );
   // Minutes - least significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      MIN0
   (
      .in(minutes_bcd[3:0]),      // Use lower 4 bits of BCD minutes
      .o_a(o_HEX2[0]),
      .o_b(o_HEX2[1]),
      .o_c(o_HEX2[2]),
      .o_d(o_HEX2[3]),
      .o_e(o_HEX2[4]),
      .o_f(o_HEX2[5]),
      .o_g(o_HEX2[6])
   );
   // Minutes - most significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      MIN1
   (
      .in(minutes_bcd[7:4]),      // Use upper 4 bits of BCD minutes
      .o_a(o_HEX3[0]),
      .o_b(o_HEX3[1]),
      .o_c(o_HEX3[2]),
      .o_d(o_HEX3[3]),
      .o_e(o_HEX3[4]),
      .o_f(o_HEX3[5]),
      .o_g(o_HEX3[6])
   );
   // Hours - least significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      HOUR0
   (
      .in(hours_bcd[3:0]),        // Use lower 4 bits of BCD hours
      .o_a(o_HEX4[0]),
      .o_b(o_HEX4[1]),
      .o_c(o_HEX4[2]),
      .o_d(o_HEX4[3]),
      .o_e(o_HEX4[4]),
      .o_f(o_HEX4[5]),
      .o_g(o_HEX4[6])
   );
   // Hours - most significant digit
   hex_7seg_decoder
   #(.COMMON_ANODE_CATHODE(0))
      HOUR1
   (
      .in(hours_bcd[7:4]),        // Use upper 4 bits of BCD hours
      .o_a(o_HEX5[0]),
      .o_b(o_HEX5[1]),
      .o_c(o_HEX5[2]),
      .o_d(o_HEX5[3]),
      .o_e(o_HEX5[4]),
      .o_f(o_HEX5[5]),
      .o_g(o_HEX5[6])
   );
endmodule