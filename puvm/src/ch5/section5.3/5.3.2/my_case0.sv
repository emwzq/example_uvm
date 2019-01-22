`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   `uvm_component_utils(my_case0)
endclass

`endif
