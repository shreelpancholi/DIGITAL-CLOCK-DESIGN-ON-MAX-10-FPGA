module hex_7seg_decoder
   #(parameter COMMON_ANODE_CATHODE = 0) //0 for common Anode 
   ( 
    input [3:0]in,   // 4-bit input representing hexadecimal digit (0-15)
    output  o_a,     // Outputs for each segment of the 7-segment display
    output  o_b,
    output  o_c,
    output  o_d, 
    output  o_e,
    output  o_f,
    output  o_g
   );
	
   // Internal registers for each element 
   reg a,b,c,d,e,f,g;

   // Combinational form for the hexadecimal input to display on 7-segment display pattern
   always @(*) begin
      case (in)
        // Each case represents a hexadecimal digit (0-15)
        // The 7-bit pattern represents which segments should be on (1) or off (0)
        4'd0 : {a,b,c,d,e,f,g} = 7'b1111110; // 0
        4'd1 : {a,b,c,d,e,f,g} = 7'b0110000; // 1
        4'd2 : {a,b,c,d,e,f,g} = 7'b1101101; // 2
        4'd3 : {a,b,c,d,e,f,g} = 7'b1111001; // 3
        4'd4 : {a,b,c,d,e,f,g} = 7'b0110011; // 4
        4'd5 : {a,b,c,d,e,f,g} = 7'b1011011; // 5
        4'd6 : {a,b,c,d,e,f,g} = 7'b1011111; // 6
        4'd7 : {a,b,c,d,e,f,g} = 7'b1110000; // 7
        4'd8 : {a,b,c,d,e,f,g} = 7'b1111111; // 8
        4'd9 : {a,b,c,d,e,f,g} = 7'b1111011; // 9
        4'd10 : {a,b,c,d,e,f,g} = 7'b1110111; // A
        4'd11 : {a,b,c,d,e,f,g} = 7'b0011111; // b
        4'd12 : {a,b,c,d,e,f,g} = 7'b1001110; // C
        4'd13 : {a,b,c,d,e,f,g} = 7'b0111101; // D
        4'd14 : {a,b,c,d,e,f,g} = 7'b1001111; // E
        4'd15 : {a,b,c,d,e,f,g} = 7'b1000111; // F
        default : {a,b,c,d,e,f,g} = 7'b1111110; // Default to '0' display
      endcase 
   end

   assign {o_a,o_b,o_c,o_d,o_e,o_f,o_g} = COMMON_ANODE_CATHODE ? {a,b,c,d,e,f,g} : ~{a,b,c,d,e,f,g};
endmodule