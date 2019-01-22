`timescale 1ns/1ns
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_transaction.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"

module top_tb;

reg clk;
reg rst_n;

my_if input_if0(clk, rst_n);
my_if input_if1(clk, rst_n);
my_if output_if0(clk, rst_n);
my_if output_if1(clk, rst_n);

dut my_dut(.clk(clk),
           .rst_n(rst_n),
           .rxd0(input_if0.data),
           .rx_dv0(input_if0.valid),
           .rxd1(input_if1.data),
           .rx_dv1(input_if1.valid),
           .txd0(output_if0.data),
           .tx_en0(output_if0.valid),
           .txd1(output_if1.data),
           .tx_en1(output_if1.valid));

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
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env0.i_agt.drv", "vif", input_if0);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env0.i_agt.mon", "vif", input_if0);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env0.o_agt.mon", "vif", output_if0);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env1.i_agt.drv", "vif", input_if1);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env1.i_agt.mon", "vif", input_if1);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env1.o_agt.mon", "vif", output_if1);
end

endmodule
