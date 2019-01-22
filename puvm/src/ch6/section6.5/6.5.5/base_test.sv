`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;

   my_env         env[4];
   my_vsqr        v_sqr;   
   
   function new(string name = "base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   `uvm_component_utils(base_test)
endclass


function void base_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   for(int i = 0; i < 4; i++)
      env[i]  =  my_env::type_id::create($sformatf("env%0d", i), this); 
   v_sqr =  my_vsqr::type_id::create("v_sqr", this); 
endfunction

function void base_test::connect_phase(uvm_phase phase);
   for(int i = 0; i < 4; i++)
      v_sqr.p_sqr[i] = env[i].i_agt.sqr;
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
