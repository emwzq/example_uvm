`ifndef BUS_IF__SV
`define BUS_IF__SV

interface bus_if(input clk, input rst_n);

   logic         bus_cmd_valid;
   logic         bus_op;
   logic [15:0]  bus_addr;
   logic [15:0]  bus_wr_data;
   logic [15:0]  bus_rd_data;

endinterface

`endif
