`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV

`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_model)
class my_scoreboard extends uvm_scoreboard;
   my_transaction  expect_queue[$];
   
   uvm_analysis_imp_monitor#(my_transaction, my_scoreboard) monitor_imp;
   uvm_analysis_imp_model#(my_transaction, my_scoreboard) model_imp;
   `uvm_component_utils(my_scoreboard)

   extern function new(string name, uvm_component parent = null);
   extern virtual function void build_phase(uvm_phase phase);
   extern function void write_monitor(my_transaction tr);
   extern function void write_model(my_transaction tr);
   extern virtual task main_phase(uvm_phase phase);
endclass 

function my_scoreboard::new(string name, uvm_component parent = null);
   super.new(name, parent);
endfunction 

function void my_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   monitor_imp = new("monitor_imp", this);
   model_imp = new("model_imp", this);
endfunction 

function void my_scoreboard::write_model(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_monitor(my_transaction tr);
   my_transaction  tmp_tran;
   bit result;
   if(expect_queue.size() > 0) begin
      tmp_tran = expect_queue.pop_front();
      result = tr.compare(tmp_tran);
      if(result) begin 
         `uvm_info("my_scoreboard", "Compare SUCCESSFULLY", UVM_LOW);
      end
      else begin
         `uvm_error("my_scoreboard", "Compare FAILED");
         $display("the expect pkt is");
         tmp_tran.print();
         $display("the actual pkt is");
         tr.print();
      end
   end
   else begin
      `uvm_error("my_scoreboard", "Received from DUT, while Expect Queue is empty");
      $display("the unexpected pkt is");
      tr.print();
   end 

endfunction

task my_scoreboard::main_phase(uvm_phase phase);
endtask
`endif
