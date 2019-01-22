`ifndef A__SV
`define A__SV
class A extends uvm_component;
   `uvm_component_utils(A)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
   super.build_phase(phase);
   `uvm_info("A", "build_phase", UVM_LOW)
endfunction

function void A::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   `uvm_info("A", "connect_phase", UVM_LOW)
endfunction

`endif
