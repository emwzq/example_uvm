module dut(clk,
           rst_n, 
           rxd0,
           rx_dv0,
           rxd1,
           rx_dv1,
           txd0,
           tx_en0,
           txd1,
           tx_en1);
input clk;
input rst_n;
input[7:0] rxd0;
input rx_dv0;
input[7:0] rxd1;
input rx_dv1;
output [7:0] txd0;
output tx_en0;
output [7:0] txd1;
output tx_en1;

reg[7:0] txd0;
reg tx_en0;
reg[7:0] txd1;
reg tx_en1;

always @(posedge clk) begin
   if(!rst_n) begin
      txd0 <= 8'b0;
      tx_en0 <= 1'b0;
      txd1 <= 8'b0;
      tx_en1 <= 1'b0;
   end
   else begin
      txd0 <= rxd0;
      tx_en0 <= rx_dv0;
      txd1 <= rxd1;
      tx_en1 <= rx_dv1;
   end
end
endmodule

