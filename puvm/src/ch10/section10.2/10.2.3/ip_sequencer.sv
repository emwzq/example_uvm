`ifndef IP_SEQUENCER__SV
`define IP_SEQUENCER__SV

class ip_sequencer extends uvm_sequencer #(ip_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(ip_sequencer)
endclass

`endif
