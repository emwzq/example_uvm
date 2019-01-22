`ifndef A__SV
`define A__SV
class A extends uvm_component;
   `uvm_component_utils(A)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
   extern virtual  task post_main_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task A::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("A", "main phase start", UVM_LOW)
   #100;
   `uvm_info("A", "main phase end", UVM_LOW)
   phase.drop_objection(this);
endtask

task A::post_main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("A", "post main phase start", UVM_LOW)
   #300;
   `uvm_info("A", "post main phase end", UVM_LOW)
   phase.drop_objection(this);
endtask

`endif
