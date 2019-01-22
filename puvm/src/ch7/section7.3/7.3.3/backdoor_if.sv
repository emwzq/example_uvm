`ifndef BACKDOOR_IF__SV
`define BACKDOOR_IF__SV

interface backdoor_if(input clk, input rst_n);

   function void poke_counter(input bit[31:0] value);
      top_tb.my_dut.counter = value;
   endfunction

   function void peek_counter(output bit[31:0] value);
      value = top_tb.my_dut.counter;
   endfunction
endinterface

`endif
