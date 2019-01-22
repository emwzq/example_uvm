`ifndef MY_CASE0__SV
`define MY_CASE0__SV
event send_over;//global event
class drv0_seq extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   `uvm_object_utils(drv0_seq)

   function  new(string name= "drv0_seq");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      `uvm_do_with(m_trans, {m_trans.pload.size == 1500;})
      ->send_over;
      repeat (10) begin
         `uvm_do(m_trans)
         `uvm_info("drv0_seq", "send one transaction", UVM_MEDIUM)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask
endclass

class drv1_seq extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   `uvm_object_utils(drv1_seq)

   function  new(string name= "drv1_seq");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      @send_over;
      repeat (10) begin
         `uvm_do(m_trans)
         `uvm_info("drv1_seq", "send one transaction", UVM_MEDIUM)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask
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
                                           "env0.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           drv0_seq::type_id::get());
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env1.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           drv1_seq::type_id::get());
endfunction

`endif
