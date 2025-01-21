module bin2bcd(
   input clk,
   input rst_n,
   input [7:0] i_bin,  
   output reg [11:0] o_bcd
);
  
  reg [11:0] scratch_space;
  reg [3:0] i;
  reg [7:0] bin_ff;
  
  always @(posedge clk) begin 
    if(!rst_n) begin
      bin_ff <= 0;
    end else begin
      bin_ff <= i_bin;
    end 
  end 
  
  always @(*) begin 
    scratch_space = 0;
     
    for (i=0; i<4'd8; i=i+1'b1) begin
      scratch_space = {scratch_space[10:0], bin_ff[7-i]};
        
      if(i < 4'd7 && scratch_space[3:0] > 4'd4) begin scratch_space[3:0] = scratch_space[3:0] + 4'd3; end 
      if(i < 4'd7 && scratch_space[7:4] > 4'd4) begin scratch_space[7:4] = scratch_space[7:4] + 4'd3; end 
      if(i < 4'd7 && scratch_space[11:8] > 4'd4) begin scratch_space[11:8] = scratch_space[11:8] + 4'd3; end
    end
  end 
 
  always @(posedge clk) begin
    if (!rst_n) begin
      o_bcd <= 0;
    end else begin
      o_bcd <= scratch_space;
    end   
  end 
  
endmodule