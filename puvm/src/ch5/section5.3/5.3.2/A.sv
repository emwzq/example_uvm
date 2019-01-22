`ifndef A__SV
`define A__SV
class A extends uvm_component;
   `uvm_component_utils(A)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern virtual  task reset_phase(uvm_phase phase);
   extern virtual  task post_reset_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
   extern virtual  task post_main_phase(uvm_phase phase);
endclass

task A::reset_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("A", "enter into reset phase", UVM_LOW)
   #300;
   phase.drop_objection(this);
endtask

task A::post_reset_phase(uvm_phase phase);
   `uvm_info("A", "enter into post reset phase", UVM_LOW)
endtask

task A::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("A", "enter into main phase", UVM_LOW)
   #200;
   phase.drop_objection(this);
endtask

task A::post_main_phase(uvm_phase phase);
   `uvm_info("A", "enter into post main phase", UVM_LOW)
endtask


`endif
