`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
endclass

`endif
