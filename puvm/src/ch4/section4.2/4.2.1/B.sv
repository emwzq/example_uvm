`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   uvm_blocking_put_export#(my_transaction) B_export;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void B::build_phase(uvm_phase phase);
   super.build_phase(phase);
   B_export = new("B_export", this);
endfunction

task B::main_phase(uvm_phase phase);
endtask

`endif
