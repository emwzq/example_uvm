`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   my_agent   i_agt;
   my_agent   o_agt;
   my_model   mdl;
   my_scoreboard scb;
   
   uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
   
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      i_agt = my_agent::type_id::create("i_agt", this);
      o_agt = my_agent::type_id::create("o_agt", this);
      i_agt.is_active = UVM_ACTIVE;
      o_agt.is_active = UVM_PASSIVE;
      mdl = my_model::type_id::create("mdl", this);
      scb = my_scoreboard::type_id::create("scb", this);
      agt_mdl_fifo = new("agt_mdl_fifo", this);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(my_env)
endclass

function void my_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   i_agt.ap.connect(agt_mdl_fifo.analysis_export);
   mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   o_agt.ap.connect(scb.monitor_imp);
   mdl.ap[0].connect(scb.model0_imp);
   mdl.ap[1].connect(scb.model1_imp);
   mdl.ap[2].connect(scb.model2_imp);
   mdl.ap[3].connect(scb.model3_imp);
   mdl.ap[4].connect(scb.model4_imp);
   mdl.ap[5].connect(scb.model5_imp);
   mdl.ap[6].connect(scb.model6_imp);
   mdl.ap[7].connect(scb.model7_imp);
   mdl.ap[8].connect(scb.model8_imp);
   mdl.ap[9].connect(scb.model9_imp);
   mdl.ap[10].connect(scb.modela_imp);
   mdl.ap[11].connect(scb.modelb_imp);
   mdl.ap[12].connect(scb.modelc_imp);
   mdl.ap[13].connect(scb.modeld_imp);
   mdl.ap[14].connect(scb.modele_imp);
   mdl.ap[15].connect(scb.modelf_imp);
endfunction

`endif
