`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   A   A_inst0;
   A   A_inst1;
   A   A_inst2;
   A   A_inst3;
   
   
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      A_inst0 = A::type_id::create("dddd", this);
      A_inst1 = A::type_id::create("zzzz", this);
      A_inst2 = A::type_id::create("jjjj", this);
      A_inst3 = A::type_id::create("aaaa", this);

   endfunction

   `uvm_component_utils(my_env)
endclass

`endif
