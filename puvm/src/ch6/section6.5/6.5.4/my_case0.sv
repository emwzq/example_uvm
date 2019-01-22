`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class drv0_seq extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   `uvm_object_utils(drv0_seq)

   function  new(string name= "drv0_seq");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) begin
         starting_phase.raise_objection(this);
         `uvm_info("drv0_seq", "raise objection", UVM_MEDIUM)
      end
      else begin
         `uvm_info("drv0_seq", "starting_phase is null, can't raise objection", UVM_MEDIUM)
      end
      repeat (10) begin
         `uvm_do(m_trans)
      end
      if(starting_phase != null) begin
         starting_phase.drop_objection(this);
         `uvm_info("drv0_seq", "drop objection", UVM_MEDIUM)
      end
      else begin
         `uvm_info("drv0_seq", "starting_phase is null, can't drop objection", UVM_MEDIUM)
      end
   endtask
endclass

class case0_vseq extends uvm_sequence;
   `uvm_object_utils(case0_vseq)
   `uvm_declare_p_sequencer(my_vsqr) 
   function new(string name = "case0_vseq");
      super.new(name);
   endfunction

   virtual task body();
      drv0_seq seq0;
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      `uvm_do_on(seq0, p_sequencer.p_sqr0);
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
                                           "v_sqr.main_phase", 
                                           "default_sequence", 
                                           case0_vseq::type_id::get());
endfunction
`endif
