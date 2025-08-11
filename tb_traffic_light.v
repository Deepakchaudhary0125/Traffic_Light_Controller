`timescale 1ns/1ps
module tb_traffic_sys;

reg clk;
reg rst;

wire [1:0]  n_c, n_g, s_c, s_g, e_c, e_g, w_c, w_g;
wire [1:0] north_both, south_both, east_both, west_both;

traffic_light uut(
     .clk(clk),
    .rst(rst),
    .n_c(n_c),
    .n_g(n_g),
    .s_c(s_c),
    .s_g(s_g),
    .e_c(e_c),
    .e_g(e_g),
    .w_c(w_c),
    .w_g(w_g),
    .north_both(north_both), 
    .south_both(south_both),
    .east_both(east_both), 
    .west_both(west_both)
   );


initial begin
    clk=0;
    forever
    #10 clk=~clk;
end

// Test sequence
initial begin
    // Monitor output
    $monitor("Time=%0t | N=%b S=%b E=%b W=%b Count=%0d",
             $time, north_both, south_both, east_both, west_both, uut.count);

    // Apply reset
    rst = 1;
    #20;
    rst = 0; 
  
    // Run simulation for enough time to see multiple cycles
    #1225;

    $finish;
end
initial begin
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, tb_traffic_sys);
end


endmodule