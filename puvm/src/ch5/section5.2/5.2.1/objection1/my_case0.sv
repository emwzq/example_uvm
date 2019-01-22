`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   extern virtual task main_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   `uvm_component_utils(my_case0)
endclass

task my_case0::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   #100;
   phase.drop_objection(this);
endtask

task my_case0::run_phase(uvm_phase phase);
   for(int i = 0; i < 9; i++) begin
      #10;
      `uvm_info("case0", "run_phase is executed", UVM_LOW)
   end
endtask

function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

`endif
