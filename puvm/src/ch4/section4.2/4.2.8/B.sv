`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   uvm_blocking_transport_imp#(my_transaction, my_transaction, B) B_imp;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern task transport(my_transaction req, output my_transaction rsp);
endclass

function void B::build_phase(uvm_phase phase);
   super.build_phase(phase);
   B_imp = new("B_imp", this);
endfunction

task B::transport(my_transaction req, output my_transaction rsp);
   `uvm_info("B", "receive a transaction", UVM_LOW) 
   req.print();
   //do something according to req
   #5;
   rsp = new("rsp");
endtask
`endif
