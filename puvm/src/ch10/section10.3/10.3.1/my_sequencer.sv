`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(my_transaction);
   
   virtual my_if vif;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_sequencer", "virtual interface must be set for vif!!!")
   endfunction
   
   `uvm_component_utils(my_sequencer)
endclass

`endif
