`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(my_transaction);
   bit[47:0] dmac;
   bit[47:0] smac;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      void'(uvm_config_db#(bit[47:0])::get(this, "", "dmac", dmac));
      void'(uvm_config_db#(bit[47:0])::get(this, "", "smac", smac));
   endfunction

   `uvm_component_utils(my_sequencer)
endclass

`endif
