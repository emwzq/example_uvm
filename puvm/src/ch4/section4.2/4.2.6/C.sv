`ifndef C__SV
`define C__SV
class C extends uvm_component;
   `uvm_component_utils(C)

   B B_inst;

   uvm_blocking_put_export#(my_transaction) C_export;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void C::build_phase(uvm_phase phase);
   super.build_phase(phase);
   C_export = new("C_export", this);
   B_inst = B::type_id::create("B_inst", this); 
endfunction

function void C::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   this.C_export.connect(B_inst.B_export);
endfunction

task C::main_phase(uvm_phase phase);

endtask

`endif
