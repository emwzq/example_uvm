`ifndef CHIP_ENV__SV
`define CHIP_ENV__SV
class chip_env extends uvm_env;
   `uvm_component_utils(chip_env)

   my_env         env_A;
   my_env         env_B;
   my_env         env_C;
   bus_agent      bus_agt;
   chip_reg_model chip_rm;
   my_adapter     reg_sqr_adapter;

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
   bus_agt = bus_agent::type_id::create("bus_agt", this);
   bus_agt.is_active = UVM_ACTIVE;
   chip_rm = chip_reg_model::type_id::create("chip_rm", this);
   chip_rm.configure(null, "");
   chip_rm.build();
   chip_rm.lock_model();
   chip_rm.reset();
   reg_sqr_adapter = new("reg_sqr_adapter");
   env_A.p_rm = this.chip_rm.A_rm;
   env_B.p_rm = this.chip_rm.B_rm;
   env_C.p_rm = this.chip_rm.C_rm;
endfunction

function void chip_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   env_A.ap.connect(env_B.i_export);
   env_B.ap.connect(env_C.i_export);
   chip_rm.default_map.set_sequencer(bus_agt.sqr, reg_sqr_adapter);
   chip_rm.default_map.set_auto_predict(1);
endfunction

`endif
