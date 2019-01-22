`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   uvm_nonblocking_put_imp#(my_transaction, B) B_imp;
   my_transaction tr_q[$];
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function bit can_put();
   extern function bit try_put(my_transaction tr);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void B::build_phase(uvm_phase phase);
   super.build_phase(phase);
   B_imp = new("B_imp", this);
endfunction

function bit B::can_put();
   if(tr_q.size() > 0)
      return 0;
   else 
      return 1;
endfunction

function bit B::try_put(my_transaction tr);
   `uvm_info("B", "receive a transaction", UVM_LOW) 
   if(tr_q.size() > 0)
      return 0;
   else begin
      tr_q.push_back(tr);
      return 1;
   end
endfunction

task B::main_phase(uvm_phase phase);
    my_transaction tr;
    while(1) begin
       if(tr_q.size() > 0)
          tr = tr_q.pop_front();
       else
          #25;
    end
endtask

`endif
