`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         `uvm_do(m_trans)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(case0_sequence)
endclass

class my_callback extends A;

   virtual task pre_tran(my_driver drv, ref my_transaction tr);
      `uvm_info("my_callback", "this is pre_tran task", UVM_MEDIUM)
   endtask

   `uvm_object_utils(my_callback)
endclass

class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   extern virtual function void connect_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           case0_sequence::type_id::get());
endfunction

function void my_case0::connect_phase(uvm_phase phase);
   my_callback my_cb;
   super.connect_phase(phase);

   my_cb = my_callback::type_id::create("my_cb");
   A_pool::add(env.i_agt.drv, my_cb);
endfunction

`endif
