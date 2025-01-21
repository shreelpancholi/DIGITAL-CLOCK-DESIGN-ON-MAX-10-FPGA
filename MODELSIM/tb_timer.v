module tb_timer();
   parameter BUS_WIDTH = 4;
   reg clk = 0;
   reg rst_n;
   
   wire [6:0] o_HEX0, o_HEX1;
   wire [6:0] o_HEX2, o_HEX3;
   wire [6:0] o_HEX4, o_HEX5;
   
   parameter CLK_HALF_PERIOD = 10;
   parameter CLK_1ns = 1 * 10**6;
   
   timer_top #(.CLOCK_FREQ(CLK_1ns/(2*CLK_HALF_PERIOD))) TMR0 (
      .clk(clk),
      .rst_n(rst_n),
      .o_HEX0(o_HEX0),
      .o_HEX1(o_HEX1),
      .o_HEX2(o_HEX2),
      .o_HEX3(o_HEX3),
      .o_HEX4(o_HEX4),
      .o_HEX5(o_HEX5)
   );
   
   always begin 
      #(CLK_HALF_PERIOD) clk = ~clk;
   end
   
   initial begin 
      rst_n = 0;
      #1;
      rst_n = 1;
      
      repeat(60) @(posedge clk);
      #100;
      $stop;
   end
   
endmodule

		