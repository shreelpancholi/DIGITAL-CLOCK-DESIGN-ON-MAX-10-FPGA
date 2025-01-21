module bin2bcd(
   input clk,             // clock input 
   input rst_n,           // reset input 
   input [7:0] i_bin,     // binary input (output from the timer for sec min hour)
   output reg [7:0] o_bcd // 8-bit bcd output (conversion is this code)
);
  // internal registers 
  reg [7:0] scratch_space; // temporary hardware space to store and to shift values for bcd value calculation
  reg [3:0] i;             // iteration used for for-loop and to calculate each binary digit   
  reg [7:0] bin_ff;        // store input binary value

  // register input binary values 
  always @(posedge clk) begin 
    if(!rst_n) begin
      bin_ff <= 0; // reset
    end else begin
      bin_ff <= i_bin[6:0]; // store input of each cycle, only using 7 bits (0-99)
    end 
  end 

  // conversion logic
  always @(*) begin 
    scratch_space = 0; // start with 0 and empty space  
     
    for (i=0; i<4'd7; i=i+1'b1) begin // changed to 7 iterations for 7 bits
      scratch_space = {scratch_space[6:0], bin_ff[6-i]}; // left shifts the existing contents of scratch space by one bit 
        
      if(i < 4'd6 && scratch_space[3:0] > 4'd4) begin 
        scratch_space[3:0] = scratch_space[3:0] + 4'd3; 
      end 
      if(i < 4'd6 && scratch_space[7:4] > 4'd4) begin 
        scratch_space[7:4] = scratch_space[7:4] + 4'd3; 
      end 
    end
  end 
 
  always @(posedge clk) begin
    if (!rst_n) begin
      o_bcd <= 0;
    end else begin
      o_bcd <= scratch_space; // giving the bcd value to the output variable
    end   
  end 
  
endmodule