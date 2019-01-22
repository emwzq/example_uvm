`ifndef A__SV
`define A__SV
class A extends uvm_component;
   `uvm_component_utils(A)

   uvm_blocking_get_export#(my_transaction) A_export;
   uvm_blocking_get_imp#(my_transaction, A) A_imp;
   my_transaction tr_q[$];
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern virtual  task get(output my_transaction tr);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
   super.build_phase(phase);
   A_export = new("A_export", this);
   A_imp = new("A_imp", this);
endfunction

function void A::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   A_export.connect(A_imp); 
endfunction

task A::get(output my_transaction tr);
   while(tr_q.size() == 0) #2;
   tr = tr_q.pop_front();
endtask

task A::main_phase(uvm_phase phase);
   my_transaction tr;
   repeat(10) begin
      #10;
      tr = new("tr");
      tr_q.push_back(tr); 
   end
endtask

`endif
