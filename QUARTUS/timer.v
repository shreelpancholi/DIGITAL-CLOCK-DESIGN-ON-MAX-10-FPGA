module timer
   #(parameter CLOCK_FREQ = 32'd50_000_000)  //assigning pins to all the input and output 
   (
    input clk, //50mhz clock input 
    input rst_n, //active low reset
    input start_stop, //start and stop switch 
    input select_seconds, //switch used to access the seconds counter only 
    input select_minutes, //switch used to access the minutes counter only 
    input select_hours, //switch used to acess the hour counter only 
    input increment, //push button for increment
    input save, //push button for save the increment
    output reg [5:0] o_seconds, //final output seconds 
    output reg [5:0] o_minutes, //final output minutes
    output reg [6:0] o_hours //final output hours 
   );
	
   localparam ONE_SECOND = CLOCK_FREQ - 1;  //this is the clock cycle after every 49999999 cycles 
	                                        //there is increment of 1 sec 
														 //local parameter is used so that it cannot be changed value should be the same 

   reg [5:0] seconds_cnt, seconds_temp;   //temp variables are for adjustment 
   reg [5:0] minutes_cnt, minutes_temp;    //cnt variables are or counting the timer 
   reg [6:0] hours_cnt, hours_temp;         //two sets of variables for counting as there are two sets of operation
   reg [31:0] counter_1sec;              //counter used for incrementing 

   // Edge detection for increment, save inputs, and select switches
   reg increment_prev, save_prev;    //previous is used for n-1 clock value that is one previous value
   reg select_seconds_prev, select_minutes_prev, select_hours_prev; 
   wire increment_edge, save_edge;   //edge value are used to store if there is increment or not 
   wire select_seconds_edge, select_minutes_edge, select_hours_edge;  //if there is increment then 1 value helps to increase counter

   always @(posedge clk or negedge rst_n) begin //the reset is an actie low reset so when it is not active low all the values are taken as 0
	
      if (!rst_n) begin
         increment_prev <= 0;
         save_prev <= 0;
         select_seconds_prev <= 0;
         select_minutes_prev <= 0;
         select_hours_prev <= 0;
      end else begin //if reset is active low then previous values will get current value and the cycle will be 1 count behind the actual clock cycle 
		
         increment_prev <= increment;
         save_prev <= save;
         select_seconds_prev <= select_seconds;
         select_minutes_prev <= select_minutes;
         select_hours_prev <= select_hours;
      end
   end
//edge triggers are used here and only when increment is 1 and prev is 0 then and then only edge is incremented 
//this helps in only one increment in one press
   assign increment_edge = increment & ~increment_prev;
   assign save_edge = save & ~save_prev;
   assign select_seconds_edge = select_seconds & ~select_seconds_prev;
   assign select_minutes_edge = select_minutes & ~select_minutes_prev;
   assign select_hours_edge = select_hours & ~select_hours_prev;

   always @(posedge clk or negedge rst_n) begin 
      if (!rst_n) begin
         counter_1sec <= 0;
         seconds_cnt <= 0;
         minutes_cnt <= 0;
         hours_cnt <= 0;
         seconds_temp <= 0;
         minutes_temp <= 0;
         hours_temp <= 0;
			//if the start is active with every select switch off then normal timer will run
      end else if (!select_seconds && !select_minutes && !select_hours && start_stop) begin // Timer runs
         if (counter_1sec == ONE_SECOND) begin
            counter_1sec <= 0;
            if (seconds_cnt == 6'd59) begin
               seconds_cnt <= 0;
               if (minutes_cnt == 6'd59) begin
                  minutes_cnt <= 0;
                  if (hours_cnt == 7'd23) begin
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
      end else begin // Timer is stopped or in adjust mode by activating stop switch 
         if (select_seconds_edge) seconds_temp <= seconds_cnt; //cnt value is given to temp value for calculation
         if (select_minutes_edge) minutes_temp <= minutes_cnt;
         if (select_hours_edge) hours_temp <= hours_cnt;

         if (select_seconds) begin
            if (increment_edge) begin
               if (seconds_temp == 6'd59) seconds_temp <= 0;
               else seconds_temp <= seconds_temp + 1'b1;
            end
            if (save_edge) seconds_cnt <= seconds_temp;
         end
         if (select_minutes) begin
            if (increment_edge) begin
               if (minutes_temp == 6'd59) minutes_temp <= 0;
               else minutes_temp <= minutes_temp + 1'b1;
            end
            if (save_edge) minutes_cnt <= minutes_temp;
         end
         if (select_hours) begin
            if (increment_edge) begin
               if (hours_temp == 7'd23) hours_temp <= 0;
               else hours_temp <= hours_temp + 1'b1;
            end
            if (save_edge) hours_cnt <= hours_temp; //if saved then the temp value is given to cnt
         end
      end
   end

   always @(posedge clk) begin //here the temp value is taken in o_seconds if adjustment is done 
	//cnt is taken when the value is taken from timer
      o_seconds <= select_seconds ? seconds_temp : seconds_cnt;  
      o_minutes <= select_minutes ? minutes_temp : minutes_cnt;
      o_hours <= select_hours ? hours_temp : hours_cnt;
   end

endmodule