`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   my_agent   i_agt;
   my_agent   o_agt;
   my_model   mdl;
   my_scoreboard scb;

   bit in_chip;
   uvm_analysis_port#(my_transaction) ap;
   uvm_analysis_export#(my_transaction) i_export;

   uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo;
   uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
   uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo;
   
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
      in_chip = 0;
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!in_chip) begin
         i_agt = my_agent::type_id::create("i_agt", this);
         i_agt.is_active = UVM_ACTIVE;
      end
      o_agt = my_agent::type_id::create("o_agt", this);
      o_agt.is_active = UVM_PASSIVE;
      mdl = my_model::type_id::create("mdl", this);
      scb = my_scoreboard::type_id::create("scb", this);
      agt_scb_fifo = new("agt_scb_fifo", this);
      agt_mdl_fifo = new("agt_mdl_fifo", this);
      mdl_scb_fifo = new("mdl_scb_fifo", this);

      if(in_chip)
         i_export = new("i_export", this);
   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(my_env)
endclass

function void my_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   ap = o_agt.ap;
   if(in_chip) begin
      i_export.connect(agt_mdl_fifo.analysis_export);
   end
   else begin
      i_agt.ap.connect(agt_mdl_fifo.analysis_export);
   end
   mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   mdl.ap.connect(mdl_scb_fifo.analysis_export);
   scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
   o_agt.ap.connect(agt_scb_fifo.analysis_export);
   scb.act_port.connect(agt_scb_fifo.blocking_get_export); 
endfunction

`endif
