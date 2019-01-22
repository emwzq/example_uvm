`ifndef B__SV
`define B__SV
class B extends uvm_component;
   `uvm_component_utils(B)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
   extern virtual  task main_phase(uvm_phase phase);
   extern virtual  task post_main_phase(uvm_phase phase);
endclass

task B::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "main phase start", UVM_LOW)
   #200;
   `uvm_info("B", "main phase end", UVM_LOW)
   phase.drop_objection(this);
endtask

task B::post_main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "post main phase start", UVM_LOW)
   #200;
   `uvm_info("B", "post main phase end", UVM_LOW)
   phase.drop_objection(this);
endtask

`endif
