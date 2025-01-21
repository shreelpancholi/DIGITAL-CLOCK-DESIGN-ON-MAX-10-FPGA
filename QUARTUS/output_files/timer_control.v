module timer_control
   #(parameter CLOCK_FREQ = 32'd50_000_000)
   (
    input clk,
    input rst_n,
    input start_stop,
    output [5:0] o_seconds,
    output [5:0] o_minutes,
    output [6:0] o_hours
   );

   reg timer_en;
   wire timer_rst;

   assign timer_rst = ~rst_n | ~timer_en;

   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         timer_en <= 1'b0;
      end else begin
         if (start_stop) begin
            timer_en <= ~timer_en;
         end
      end
   end

   timer #(.CLOCK_FREQ(CLOCK_FREQ))
      TMR0
   (
      .clk(clk),
      .rst_n(timer_rst),
      .o_seconds(o_seconds),
      .o_minutes(o_minutes),
      .o_hours(o_hours)
   );

endmodule