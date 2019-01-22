`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class normal_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "normal_sequence");
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
      repeat (10) begin
         `uvm_do(m_trans)
         m_trans.print();
      end
      #100;
   endtask

   `uvm_object_utils(normal_sequence)
endclass

class crc_err_tr extends my_transaction;
   `uvm_object_utils(crc_err_tr)
   function  new(string name= "crc_err_tr");
      super.new(name);
   endfunction 

   constraint crc_err_cons{
      crc_err == 1;
   }
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

   factory.set_type_override_by_type(my_transaction::get_type(), crc_err_tr::get_type());
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           normal_sequence::type_id::get());
endfunction

`endif
