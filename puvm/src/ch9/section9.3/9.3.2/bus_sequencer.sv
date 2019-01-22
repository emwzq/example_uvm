`ifndef BUS_SEQUENCER__SV
`define BUS_SEQUENCER__SV

class bus_sequencer#(int ADDR_WIDTH=16, int DATA_WIDTH=16) extends uvm_sequencer #(bus_transaction#(ADDR_WIDTH, DATA_WIDTH));
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(bus_sequencer#(ADDR_WIDTH, DATA_WIDTH))
endclass

`endif
