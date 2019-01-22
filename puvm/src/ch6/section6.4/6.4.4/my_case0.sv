`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   `uvm_object_utils(case0_sequence)
   `uvm_declare_p_sequencer(my_sequencer)

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         `uvm_do_with(m_trans, {m_trans.dmac == p_sequencer.dmac;
                                m_trans.smac == p_sequencer.smac;})
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

   uvm_config_db#(bit[47:0])::set(this, "env.i_agt.sqr", "dmac", 48'hF9765); 
   uvm_config_db#(bit[47:0])::set(this, "env.i_agt.sqr", "smac", 48'h89F23); 
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           case0_sequence::type_id::get());
endfunction

`endif
