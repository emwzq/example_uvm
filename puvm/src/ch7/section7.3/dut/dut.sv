module cadder(
      input  [15:0] augend,
      input  [15:0] addend,
      output [16:0] result);
assign result = {1'b0, augend} + {1'b0, addend};
endmodule

module dut(clk,
           rst_n,
           bus_cmd_valid,
           bus_op,
           bus_addr,
           bus_wr_data,
           bus_rd_data,
           rxd,
           rx_dv,
           txd,
           tx_en);
input          clk;
input          rst_n;
input          bus_cmd_valid;
input          bus_op;
input  [15:0]  bus_addr;
input  [15:0]  bus_wr_data;
output [15:0]  bus_rd_data;
input  [7:0]   rxd;
input          rx_dv;
output [7:0]   txd;
output         tx_en;

reg[7:0] txd;
reg tx_en;
reg invert;

always @(posedge clk) begin
   if(!rst_n) begin
      txd <= 8'b0;
      tx_en <= 1'b0;
   end
   else if(invert) begin
      txd <= ~rxd;
      tx_en <= rx_dv;
   end
   else begin
      txd <= rxd;
      tx_en <= rx_dv;
   end
end

reg [31:0]  counter;
wire [16:0] counter_low_result;
wire [16:0] counter_high_result;
cadder low_adder(
      .augend(counter[15:0]),
      .addend(16'h1),
      .result(counter_low_result));
cadder high_adder(
      .augend(counter[31:16]),
      .addend(16'h1),
      .result(counter_high_result));

always @(posedge clk) begin
   if(!rst_n) 
      counter[15:0] <= 16'h0;
   else if(rx_dv) begin 
      counter[15:0] <= counter_low_result[15:0]; 
   end
end

always @(posedge clk) begin
   if(!rst_n) 
      counter[31:16] <= 16'h0;
   else if(counter_low_result[16]) begin
      counter[31:16] <= counter_high_result[15:0];
   end
end

always @(posedge clk) begin
   if(!rst_n) 
      invert <= 1'b0;
   else if(bus_cmd_valid && bus_op) begin
      case(bus_addr)
         16'h5: begin
            if(bus_wr_data[0] == 1'b1)
               counter <= 32'h0;
         end
         16'h6: begin
            if(bus_wr_data[0] == 1'b1)
               counter <= 32'h0;
         end
         16'h9: begin
            invert <= bus_wr_data[0];
         end
         default: begin
         end
      endcase
   end
end

reg [15:0]  bus_rd_data;
always @(posedge clk) begin
   if(!rst_n)
      bus_rd_data <= 16'b0;
   else if(bus_cmd_valid && !bus_op) begin
      case(bus_addr)
         16'h5: begin
            bus_rd_data <= counter[31:16]; 
         end
         16'h6: begin
            bus_rd_data <= counter[15:0]; 
         end
         16'h9: begin
            bus_rd_data <= {15'b0, invert};
         end
         default: begin
            bus_rd_data <= 16'b0; 
         end
      endcase
   end
end

endmodule

