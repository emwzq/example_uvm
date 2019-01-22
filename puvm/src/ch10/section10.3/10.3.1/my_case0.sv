`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class heartbeat_sequence extends uvm_sequence #(my_transaction);

   function  new(string name= "heartbeat_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      my_transaction heartbeat_tr;
      while(1) begin
         repeat(100) @(posedge p_sequencer.vif.clk);
         grab();
         starting_phase.raise_objection(this);
         `uvm_do_with(heartbeat_tr, {heartbeat_tr.pload.size == 50;})
         `uvm_info("hb_seq", "this is a heartbeat transaction", UVM_MEDIUM)
         starting_phase.drop_objection(this);
         ungrab();
      end
   endtask

   `uvm_object_utils(heartbeat_sequence)
   `uvm_declare_p_sequencer(my_sequencer)
endclass

class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      repeat (10) begin
         `uvm_do(m_trans)
      end
   endtask

   `uvm_object_utils(case0_sequence)
endclass

class case0_vseq extends uvm_sequence #(my_transaction);

   function  new(string name= "case0_vseq");
      super.new(name);
   endfunction 
   
   virtual task pre_body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
   endtask
   
   virtual task post_body();
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask
   
   virtual task body();
      case0_sequence normal_seq;
      heartbeat_sequence heartbeat_seq;
      heartbeat_seq = new("heartbeat_seq");
      heartbeat_seq.starting_phase = this.starting_phase;
      fork
         heartbeat_seq.start(p_sequencer.p_sqr);
      join_none
      `uvm_do_on(normal_seq, p_sequencer.p_sqr)
   endtask

   `uvm_object_utils(case0_vseq)
   `uvm_declare_p_sequencer(my_vsqr)
endclass


class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "vsqr.main_phase", 
                                           "default_sequence", 
                                           case0_vseq::type_id::get());
endfunction

`endif
