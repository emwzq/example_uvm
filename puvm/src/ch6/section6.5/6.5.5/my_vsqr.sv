`ifndef MY_VSQR__SV
`define MY_VSQR__SV

class my_vsqr extends uvm_sequencer;
  
   my_sequencer p_sqr[4];
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(my_vsqr)
endclass

`endif
