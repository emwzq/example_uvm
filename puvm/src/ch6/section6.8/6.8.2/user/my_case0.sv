`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class simple_seq_library extends uvm_sequence_library#(my_transaction);
   function  new(string name= "simple_seq_library");
      super.new(name);
      init_sequence_library();
   endfunction

   `uvm_object_utils(simple_seq_library)
   `uvm_sequence_library_utils(simple_seq_library);

   virtual function int unsigned select_sequence(int unsigned max);
      static int unsigned index[$];
      static bit inited;
      int value;
      if(!inited) begin
         for(int i = 0; i <= max; i++) begin
            if((sequences[i].get_type_name() == "seq0") ||
               (sequences[i].get_type_name() == "seq1") ||
               (sequences[i].get_type_name() == "seq3"))
               index.push_back(i);
         end
         inited = 1;
      end
      value = $urandom_range(0, index.size() - 1);
      return index[value];
   endfunction
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
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           simple_seq_library::type_id::get());
   uvm_config_db#(uvm_sequence_lib_mode)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence.selection_mode", 
                                           UVM_SEQ_LIB_USER);
endfunction

`endif
