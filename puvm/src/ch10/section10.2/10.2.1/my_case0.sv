`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);

   function  new(string name= "case0_sequence");
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
      my_transaction m_tr;
      ip_transaction ip_tr;
      byte unsigned     data_q[];
      int  data_size;
      repeat (10) begin
         ip_tr = new("ip_tr");
         assert(ip_tr.randomize() with {ip_tr.src_ip == 'h9999; ip_tr.dest_ip == 'h10000;})
         //ip_tr.print();
         data_size = ip_tr.pack_bytes(data_q) / 8; 
         m_tr = new("m_tr");
         assert(m_tr.randomize with{m_tr.pload.size() == data_size;});
         for(int i = 0; i < data_size; i++) begin
            m_tr.pload[i] = data_q[i];
         end
         `uvm_send(m_tr)
      end
      #100;
   endtask

   `uvm_object_utils(case0_sequence)
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
                                           case0_sequence::type_id::get());
endfunction

`endif
