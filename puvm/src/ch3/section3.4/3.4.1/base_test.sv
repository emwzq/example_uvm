`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;

   my_env         env;
   
   function new(string name = "base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   `uvm_component_utils(base_test)

   virtual function void connect_phase(uvm_phase phase);
       env.i_agt.drv.set_report_verbosity_level(UVM_HIGH);
       //env.i_agt.drv.set_report_id_verbosity("my_driver", UVM_HIGH);
       //env.i_agt.set_report_verbosity_level_hier(UVM_HIGH);
       //env.i_agt.set_report_id_verbosity_hier("my_monitor", UVM_HIGH);
   endfunction
endclass


function void base_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env  =  my_env::type_id::create("env", this); 
endfunction


function void base_test::report_phase(uvm_phase phase);
   uvm_report_server server;
   int err_num;
   super.report_phase(phase);

   server = get_report_server();
   err_num = server.get_severity_count(UVM_ERROR);

   if (err_num != 0) begin
      $display("TEST CASE FAILED");
   end
   else begin
      $display("TEST CASE PASSED");
   end
endfunction

`endif
