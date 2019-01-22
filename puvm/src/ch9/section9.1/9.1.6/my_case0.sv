`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class my_callback extends A;
   int pkt_num = 0;

   virtual function bit gen_tran();
      `uvm_info("my_callback", "gen_tran", UVM_MEDIUM)
      if(pkt_num < 10) begin
         tr = new("tr");
         assert(tr.randomize());
         pkt_num++; 
         return 1;
      end
      else 
         return 0;
   endfunction

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
endfunction

function void my_case0::connect_phase(uvm_phase phase);
   my_callback my_cb;
   super.connect_phase(phase);

   my_cb = my_callback::type_id::create("my_cb");
   A_pool::add(env.i_agt.drv, my_cb);
endfunction

`endif
