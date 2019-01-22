`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   extern virtual task main_phase(uvm_phase phase); 
   extern virtual task reset_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass

task my_case0::reset_phase(uvm_phase phase);
   `uvm_info("case0", "reset_phase", UVM_LOW)
endtask

task my_case0::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("case0", "main_phase", UVM_LOW)
   #10000;
   phase.drop_objection(this);
endtask

function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

endfunction

`endif
