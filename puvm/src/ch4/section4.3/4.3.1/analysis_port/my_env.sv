`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   A   A_inst;
   B   B_inst;
   C   C_inst;
   
   
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      A_inst = A::type_id::create("A_inst", this);
      B_inst = B::type_id::create("B_inst", this);
      C_inst = C::type_id::create("C_inst", this);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(my_env)
endclass

function void my_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   A_inst.A_ap.connect(B_inst.B_imp);
   A_inst.A_ap.connect(C_inst.C_imp);
endfunction

`endif
