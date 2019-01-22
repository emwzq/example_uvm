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

class new_monitor extends my_monitor;
   `uvm_component_utils(new_monitor)
   function new(string name = "new_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual task main_phase(uvm_phase phase);
      fork
         super.main_phase(phase);
      join_none
      `uvm_info("new_monitor", "I am new monitor", UVM_MEDIUM)
   endtask
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

   set_inst_override_by_type("env.o_agt.mon", my_monitor::get_type(), new_monitor::get_type());
   //set_inst_override("env.o_agt.mon", "my_monitor", "new_monitor");
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           case0_sequence::type_id::get());
endfunction

function void my_case0::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //env.o_agt.mon.print_override_info("my_monitor");
   //factory.debug_create_by_type(my_monitor::get_type(), "uvm_test_top.env.o_agt.mon");
   //factory.print(2);
   //uvm_top.print_topology();
   uvm_top.print();
endfunction
`endif
