`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   uvm_blocking_get_port#(my_transaction) B_port;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void B::build_phase(uvm_phase phase);
   super.build_phase(phase);
   B_port = new("B_port", this);
endfunction

task B::main_phase(uvm_phase phase);
   my_transaction tr;
   while(1) begin
      B_port.get(tr);
      `uvm_info("B", "get a transaction", UVM_LOW) 
      tr.print();
   end
endtask

`endif
