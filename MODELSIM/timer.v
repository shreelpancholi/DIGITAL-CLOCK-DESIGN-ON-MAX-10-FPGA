module timer
   #(parameter CLOCK_FREQ = 32'd50_000_000)
   (
    input clk,
    input rst_n,
    output  [5:0] o_seconds,
    output  [5:0] o_minutes,
    output  [6:0] o_hours
   );

   localparam ONE_SECOND = CLOCK_FREQ - 1;

   reg [5:0] seconds_cnt;
	reg [5:0] minutes_cnt;
	reg [6:0] hours_cnt;
	reg [31:0] counter_1sec;

   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         counter_1sec <= 0;
         seconds_cnt <= 0;
         minutes_cnt <= 0;
         hours_cnt <= 0;
      end else begin
         if (counter_1sec == ONE_SECOND) begin
            counter_1sec <= 0;

            if (seconds_cnt == 6'd59) begin
               seconds_cnt <= 0;

               if (minutes_cnt == 6'd59) begin
                  minutes_cnt <= 0;

                  if (hours_cnt == 7'd9) begin
                     hours_cnt <= 0;
                  end else begin
                     hours_cnt <= hours_cnt + 1'b1;
                  end
               end else begin
                  minutes_cnt <= minutes_cnt + 1'b1;
               end
            end else begin
               seconds_cnt <= seconds_cnt + 1'b1;
            end
         end else begin
            counter_1sec <= counter_1sec + 1'b1;
         end
      end
   end
	
	assign o_seconds = seconds_cnt;
	assign o_minutes = minutes_cnt;
	assign o_hours = hours_cnt;

endmodule