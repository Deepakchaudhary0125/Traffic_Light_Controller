module traffic_light( clk, rst, n_c, n_g, s_c, s_g, e_c, e_g, w_c, w_g, north_both, south_both, east_both, west_both);

input  clk;
input  rst;
reg [1:0] state;
reg [5:0]count;

output reg [1:0] n_c, n_g, s_c, s_g, e_c, e_g, w_c, w_g;   // c->coming lane & g-> going lane

output reg [1:0] north_both, south_both, east_both,west_both; // to combine both lanes

parameter red       = 2'b00, 
          yellow    = 2'b01, 
          green     = 2'b11;

parameter north_on  = 2'b00,
          south_on  = 2'b01,
          west_on   = 2'b10,
          east_on   = 2'b11 ;


always @(posedge clk or posedge rst) begin
     if(rst) begin
          state <= north_on;
          count <= 0;
          // Initialize all lights to RED
            north_both <= red;
            south_both <= red;
            east_both  <= red;
            west_both  <= red;
     end else begin 
          count <= count+1;

          case(state)
               north_on , south_on : begin
                    // Combined lanes (Road)
                    north_both <= green;
                    south_both <= green;
                    east_both <= red;  west_both <= red;  // here it DOESN'T mean that whole east or west lane will be off . Only 1 from each will be ON
                   
                    // Individual lanes
                    n_c <= green;
                    n_g <= green;
                    s_c <= green;
                    s_g <= green;

                    // Status of other lanes
                    e_g <= green;
                    w_g <= green;
                    e_c <= red;
                    w_c <= red;
                    count <= count+1;
               if(count>=20 && count < 31 )begin
                    north_both <= yellow;
                    south_both <= yellow;
                    west_both  <= red;
                    east_both  <= red;
                end else if(count==31) begin
                    state<=east_on;
                    count<=0;
                end
               end

               east_on , west_on: begin
                    // Combined lanes (Road)
                    east_both <= green;
                    west_both <= green;
                    north_both <= red; south_both <= red; // here it DOESN'T mean that whole east or west lane will be off . Only 1 from each will be ON
                   
                    // Individual lanes
                    e_g <= green;
                    w_g <= green;
                    e_c <= green;
                    w_c <= green;

                    // Status of other lanes
                    n_c <= red;
                    n_g <= green;
                    s_c <= red;
                    s_g <= green;
                    count <= count+1;
               if(count >=20  && count <31 )begin
                    west_both <= yellow;
                    east_both <= yellow;
                    south_both<=red;
                    north_both<=red;
                end else if(count==31) begin
                    state<= north_on;
                    count<=0;
                end
               end
               default: begin
                    // Fail-safe: all red
                    n_c <= red; n_g <= red;
                    s_c <= red; s_g <= red;
                    e_c <= red; e_g <= red;
                    w_c <= red; w_g <= red;
                    north_both <= red;
                    south_both <= red;
                    east_both  <= red;
                    west_both  <= red;
                end

          endcase
          
     end
end

endmodule
          
          

