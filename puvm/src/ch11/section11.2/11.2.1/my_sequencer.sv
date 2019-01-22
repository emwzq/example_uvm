`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(my_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
      `uvm_update_sequence_lib_and_item(my_transaction)
   endfunction 
   
   `uvm_sequencer_utils(my_sequencer)
endclass

`endif
