`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class simple_seq_library extends uvm_sequence_library#(my_transaction);
   function  new(string name= "simple_seq_library");
      super.new(name);
      init_sequence_library();
   endfunction

   `uvm_object_utils(simple_seq_library)
   `uvm_sequence_library_utils(simple_seq_library);

endclass

class seq0 extends uvm_sequence#(my_transaction);
   function  new(string name= "seq0");
      super.new(name);
   endfunction

   `uvm_object_utils(seq0)
   `uvm_add_to_seq_lib(seq0, simple_seq_library)
   virtual task body();
      repeat(10) begin
         `uvm_do(req)
         `uvm_info("seq0", "this is seq0", UVM_MEDIUM)
      end
   endtask 
endclass

class seq1 extends uvm_sequence#(my_transaction);
   function  new(string name= "seq1");
      super.new(name);
   endfunction

   `uvm_object_utils(seq1)
   `uvm_add_to_seq_lib(seq1, simple_seq_library)
   virtual task body();
      repeat(10) begin
         `uvm_do(req)
         `uvm_info("seq1", "this is seq1", UVM_MEDIUM)
      end
   endtask 
endclass

class seq2 extends uvm_sequence#(my_transaction);
   function  new(string name= "seq2");
      super.new(name);
   endfunction

   `uvm_object_utils(seq2)
   `uvm_add_to_seq_lib(seq2, simple_seq_library)
   virtual task body();
      repeat(10) begin
         `uvm_do(req)
         `uvm_info("seq2", "this is seq2", UVM_MEDIUM)
      end
   endtask 
endclass

class seq3 extends uvm_sequence#(my_transaction);
   function  new(string name= "seq3");
      super.new(name);
   endfunction

   `uvm_object_utils(seq3)
   `uvm_add_to_seq_lib(seq3, simple_seq_library)
   virtual task body();
      repeat(10) begin
         `uvm_do(req)
         `uvm_info("seq3", "this is seq3", UVM_MEDIUM)
      end
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
   simple_seq_library seq_lib;
   super.build_phase(phase);

   seq_lib = new("seq_lib");
   seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
   seq_lib.min_random_count = 10;
   seq_lib.max_random_count = 15; 
   uvm_config_db#(uvm_sequence_base)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           seq_lib);
endfunction

`endif
