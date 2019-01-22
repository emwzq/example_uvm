`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   uvm_blocking_put_export#(my_transaction) B_export;
   uvm_blocking_put_imp#(my_transaction, B) B_imp;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern function void put(my_transaction tr);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void B::build_phase(uvm_phase phase);
   super.build_phase(phase);
   B_export = new("B_export", this);
   B_imp = new("B_imp", this);
endfunction

function void B::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   B_export.connect(B_imp);
endfunction

function void B::put(my_transaction tr);
   `uvm_info("B", "receive a transaction", UVM_LOW) 
   tr.print();
endfunction

task B::main_phase(uvm_phase phase);
endtask

`endif
