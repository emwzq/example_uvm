`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(my_transaction);
   uvm_seq_item_pull_port #(ip_transaction) ip_tr_port; 

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ip_tr_port = new("ip_tr_port", this);
   endfunction

   `uvm_component_utils(my_sequencer)
endclass

`endif
