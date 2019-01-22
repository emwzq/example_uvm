`ifndef MY_IF__SV
`define MY_IF__SV

interface my_if(input clk, input rst_n);

   logic [7:0] data;
   logic valid;
endinterface

`endif
