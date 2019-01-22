`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "arbitor.sv"
`include "chip_dut.sv"
`include "../bus/bus_if.sv"
`include "../bus/bus_transaction.sv"
`include "../bus/bus_sequencer.sv"
`include "../bus/bus_driver.sv"
`include "../bus/bus_monitor.sv"
`include "../bus/bus_agent.sv"
`include "../bus/my_adapter.sv"
`include "../ip/my_if.sv"
`include "../ip/reg_model.sv"
`include "../ip/my_transaction.sv"
`include "../ip/my_sequencer.sv"
`include "../ip/my_driver.sv"
`include "../ip/my_monitor.sv"
`include "../ip/my_agent.sv"
`include "../ip/my_model.sv"
`include "../ip/my_scoreboard.sv"
`include "../ip/my_env.sv"
`include "chip_reg_model.sv"
`include "chip_env.sv"
`include "base_test.sv"
`include "my_case0.sv"

module top_tb;

reg clk;
reg rst_n;
reg[7:0] rxd;
reg rx_dv;
wire[7:0] txd;
wire tx_en;

my_if input_if_A(clk, rst_n);
my_if output_if_A(clk, rst_n);
my_if output_if_B(clk, rst_n);
my_if output_if_C(clk, rst_n);

bus_if b_if(clk, rst_n);

chip_dut my_dut(.clk(clk),
           .rst_n(rst_n),
           .bus_cmd_valid(b_if.bus_cmd_valid), 
           .bus_op       (b_if.bus_op       ), 
           .bus_addr     (b_if.bus_addr     ), 
           .bus_wr_data  (b_if.bus_wr_data  ), 
           .bus_rd_data  (b_if.bus_rd_data  ), 
           .rxd(input_if_A.data),
           .rx_dv(input_if_A.valid),
           .txd(output_if_C.data),
           .tx_en(output_if_C.valid));

assign output_if_A.data = my_dut.data0;
assign output_if_A.valid = my_dut.dv0;
assign output_if_B.data = my_dut.data1;
assign output_if_B.valid = my_dut.dv1;

initial begin
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

initial begin
   run_test();
end

initial begin
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.i_agt.drv", "vif", input_if_A);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.i_agt.mon", "vif", input_if_A);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.o_agt.mon", "vif", output_if_A);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_B.o_agt.mon", "vif", output_if_B);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_C.o_agt.mon", "vif", output_if_C);
   uvm_config_db#(virtual bus_if)::set(null, "uvm_test_top.env.bus_agt.drv", "vif", b_if);
   uvm_config_db#(virtual bus_if)::set(null, "uvm_test_top.env.bus_agt.mon", "vif", b_if);
end

initial begin
   $dumpfile("top_tb.vcd");
   $dumpvars(0, top_tb);
end

endmodule
