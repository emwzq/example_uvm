`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task pre_body();
      `uvm_info("sequence0", "pre_body is called!!!", UVM_LOW)
   endtask
   
   virtual task post_body();
      `uvm_info("sequence0", "post_body is called!!!", UVM_LOW)
   endtask
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      #100;
      `uvm_info("sequence0", "body is called!!!", UVM_LOW)
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(case0_sequence)
endclass


class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
   case0_sequence cseq;
   super.build_phase(phase);

   cseq = new("cseq");
   uvm_config_db#(uvm_sequence_base)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           cseq);
endfunction

`endif
