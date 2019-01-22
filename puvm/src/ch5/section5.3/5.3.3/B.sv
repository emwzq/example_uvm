`ifndef B__SV
`define B__SV
class B extends uvm_component;
   uvm_domain new_domain;
   bit has_jumped;
   `uvm_component_utils(B)

   function new(string name, uvm_component parent);
      super.new(name, parent);
      new_domain = new("new_domain");
      has_jumped = 0;
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      set_domain(new_domain);
   endfunction

   extern virtual  task reset_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
endclass

task B::reset_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "enter into reset phase", UVM_LOW)
   #100;
   phase.drop_objection(this);
endtask

task B::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("B", "enter into main phase", UVM_LOW)
   #500;
   if(!has_jumped) begin
      phase.jump(uvm_reset_phase::get());
      has_jumped = 1'b1;
   end
   phase.drop_objection(this);
endtask
`endif
