`ifndef C__SV
`define C__SV
class C extends uvm_component;
   `uvm_component_utils(C)

   uvm_analysis_imp#(my_transaction, C) C_imp;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern function void write(my_transaction tr);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void C::build_phase(uvm_phase phase);
   super.build_phase(phase);
   C_imp = new("C_imp", this);
endfunction

function void C::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction

function void C::write(my_transaction tr);
   `uvm_info("C", "receive a transaction", UVM_LOW) 
   tr.print();
endfunction

task C::main_phase(uvm_phase phase);
endtask

`endif
