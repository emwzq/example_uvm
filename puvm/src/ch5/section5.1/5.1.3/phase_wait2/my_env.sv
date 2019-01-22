`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   A   A_inst;
   B   B_inst;
   
   
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      A_inst = A::type_id::create("A_inst", this);
      B_inst = B::type_id::create("B_inst", this);

   endfunction

   `uvm_component_utils(my_env)
endclass


`endif
