`ifndef BUS_IF__SV
`define BUS_IF__SV

interface bus_if#(int ADDR_WIDTH=16, int DATA_WIDTH=16)(input clk, input rst_n);

   logic         bus_cmd_valid;
   logic         bus_op;
   logic [ADDR_WIDTH-1:0]  bus_addr;
   logic [DATA_WIDTH-1:0]  bus_wr_data;
   logic [DATA_WIDTH-1:0]  bus_rd_data;

endinterface

`endif
