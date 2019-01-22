`ifndef BUS_SEQUENCER__SV
`define BUS_SEQUENCER__SV

class bus_sequencer extends uvm_sequencer #(bus_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(bus_sequencer)
endclass

`endif
