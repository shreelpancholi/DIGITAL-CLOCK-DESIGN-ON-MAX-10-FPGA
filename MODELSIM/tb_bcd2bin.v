module tb_bcd2bin();
    parameter BUS_WIDTH = 4;
    reg  clk = 0;
    reg  rst_n;
    reg  [7:0] i_bin;
    wire [11:0] o_bcd;

    parameter CLK_HALF_PERIOD = 10;

    bin2bcd BCD2BIN (
        .clk(clk),
        .rst_n(rst_n),
        .i_bin(i_bin),
        .o_bcd(o_bcd)
    );

    always begin
        #(CLK_HALF_PERIOD); 
        clk = ~clk;
    end
     
    initial begin
        rst_n = 0; 
        i_bin = 0;
        @(posedge clk); 
        rst_n = 1;
         
        @(posedge clk); 
        i_bin = 8'd4;
        @(posedge clk); 
        i_bin = 8'd10;
        @(posedge clk); 
        i_bin = 8'd64;
        @(posedge clk); 
        i_bin = 8'd128;
        @(posedge clk); 
        i_bin = 8'd255;
        repeat(30) @(posedge clk);
        $stop;
    end
endmodule
