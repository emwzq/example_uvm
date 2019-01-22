`ifndef CHIP_ENV__SV
`define CHIP_ENV__SV
class chip_env extends uvm_env;
   `uvm_component_utils(chip_env)

   my_env         env_A;
   my_env         env_B;
   my_env         env_C;

   function new(string name = "chip_env", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
endclass

function void chip_env::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env_A  =  my_env::type_id::create("env_A", this); 
   env_B  =  my_env::type_id::create("env_B", this); 
   env_B.in_chip = 1;
   env_C  =  my_env::type_id::create("env_C", this); 
   env_C.in_chip = 1;
endfunction

function void chip_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   env_A.ap.connect(env_B.i_export);
   env_B.ap.connect(env_C.i_export);
endfunction

`endif
