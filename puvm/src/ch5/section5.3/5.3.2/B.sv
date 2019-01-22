`ifndef B__SV
`define B__SV
class B extends uvm_component;
   uvm_domain new_domain;
   `uvm_component_utils(B)

   function new(string name, uvm_component parent);
      super.new(name, parent);
      new_domain = new("new_domain");
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      set_domain(new_domain);
   endfunction

   extern virtual  task reset_phase(uvm_phase phase);
   extern virtual  task post_reset_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
   extern virtual  task post_main_phase(uvm_phase phase);
endclass

task B::reset_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "enter into reset phase", UVM_LOW)
   #100;
   phase.drop_objection(this);
endtask

task B::post_reset_phase(uvm_phase phase);
   `uvm_info("B", "enter into post reset phase", UVM_LOW)
endtask

task B::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "enter into main phase", UVM_LOW)
   #500;
   phase.drop_objection(this);
endtask

task B::post_main_phase(uvm_phase phase);
   `uvm_info("B", "enter into post main phase", UVM_LOW)
endtask

`endif
