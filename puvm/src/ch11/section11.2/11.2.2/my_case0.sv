`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
      `uvm_info("case0_sequence", "body is called",  UVM_MEDIUM)
   endfunction 
   
   virtual task body();
      uvm_test_done.raise_objection(this);
      repeat (10) begin
         `uvm_do(m_trans)
      end
      #100;
      uvm_test_done.drop_objection(this);
   endtask

   `uvm_sequence_utils(case0_sequence, my_sequencer)
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
   set_config_string("env.i_agt.sqr", "default_sequence", "case0_sequence");
endfunction

`endif
