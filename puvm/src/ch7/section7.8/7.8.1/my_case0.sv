`ifndef MY_CASE0__SV
`define MY_CASE0__SV
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

class case0_cfg_vseq extends uvm_sequence;

   `uvm_object_utils(case0_cfg_vseq)
   `uvm_declare_p_sequencer(my_vsqr)
   
   function  new(string name= "case0_cfg_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      uvm_status_e   status;
      uvm_reg_data_t value;
      bit[31:0] counter;
      uvm_reg_block blks[$];
      reg_model p_rm;
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      uvm_reg_block::get_root_blocks(blks);
      if(blks.size() == 0)
          `uvm_fatal("case0_cfg_vseq", "can't find root blocks")
      else begin
         if(!$cast(p_rm, blks[0]))
             `uvm_fatal("case0_cfg_vseq", "can't cast to reg_model")
      end
          
      p_rm.invert.read(status, value, UVM_FRONTDOOR);
      `uvm_info("case0_cfg_vseq", $sformatf("invert's initial value is %0h", value), UVM_LOW)
      p_rm.invert.write(status, 1, UVM_FRONTDOOR);
      p_rm.invert.read(status, value, UVM_FRONTDOOR);
      `uvm_info("case0_cfg_vseq", $sformatf("after set, invert's value is %0h", value), UVM_LOW)
      p_rm.counter.read(status, value, UVM_FRONTDOOR);
      counter = value;
      `uvm_info("case0_cfg_vseq", $sformatf("counter's initial value(FRONTDOOR) is %0h", counter), UVM_LOW)
      p_rm.counter.poke(status, 32'hFFFD);
      p_rm.counter.read(status, value, UVM_FRONTDOOR);
      counter = value;
      `uvm_info("case0_cfg_vseq", $sformatf("after poke, counter's value(FRONTDOOR) is %0h", counter), UVM_LOW)
      p_rm.counter.peek(status, value);
      counter = value;
      `uvm_info("case0_cfg_vseq", $sformatf("after poke, counter's value(BACKDOOR) is %0h", counter), UVM_LOW)
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

endclass

class case0_vseq extends uvm_sequence;

   `uvm_object_utils(case0_vseq)
   `uvm_declare_p_sequencer(my_vsqr)
   
   function  new(string name= "case0_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      case0_sequence dseq;
      uvm_status_e   status;
      uvm_reg_data_t value;
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      #10000;
      dseq = case0_sequence::type_id::create("dseq");
      dseq.start(p_sequencer.p_my_sqr);
      
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
                                           "v_sqr.configure_phase", 
                                           "default_sequence", 
                                           case0_cfg_vseq::type_id::get());
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.main_phase", 
                                           "default_sequence", 
                                           case0_vseq::type_id::get());
endfunction

`endif
