`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV

`uvm_analysis_imp_decl(_model0)
`uvm_analysis_imp_decl(_model1)
`uvm_analysis_imp_decl(_model2)
`uvm_analysis_imp_decl(_model3)
`uvm_analysis_imp_decl(_model4)
`uvm_analysis_imp_decl(_model5)
`uvm_analysis_imp_decl(_model6)
`uvm_analysis_imp_decl(_model7)
`uvm_analysis_imp_decl(_model8)
`uvm_analysis_imp_decl(_model9)
`uvm_analysis_imp_decl(_modela)
`uvm_analysis_imp_decl(_modelb)
`uvm_analysis_imp_decl(_modelc)
`uvm_analysis_imp_decl(_modeld)
`uvm_analysis_imp_decl(_modele)
`uvm_analysis_imp_decl(_modelf)
`uvm_analysis_imp_decl(_monitor)
class my_scoreboard extends uvm_scoreboard;
   my_transaction  expect_queue[$];
   uvm_analysis_imp_monitor#(my_transaction, my_scoreboard) monitor_imp;
   uvm_analysis_imp_model0#(my_transaction, my_scoreboard) model0_imp;
   uvm_analysis_imp_model1#(my_transaction, my_scoreboard) model1_imp;
   uvm_analysis_imp_model2#(my_transaction, my_scoreboard) model2_imp;
   uvm_analysis_imp_model3#(my_transaction, my_scoreboard) model3_imp;
   uvm_analysis_imp_model4#(my_transaction, my_scoreboard) model4_imp;
   uvm_analysis_imp_model5#(my_transaction, my_scoreboard) model5_imp;
   uvm_analysis_imp_model6#(my_transaction, my_scoreboard) model6_imp;
   uvm_analysis_imp_model7#(my_transaction, my_scoreboard) model7_imp;
   uvm_analysis_imp_model8#(my_transaction, my_scoreboard) model8_imp;
   uvm_analysis_imp_model9#(my_transaction, my_scoreboard) model9_imp;
   uvm_analysis_imp_modela#(my_transaction, my_scoreboard) modela_imp;
   uvm_analysis_imp_modelb#(my_transaction, my_scoreboard) modelb_imp;
   uvm_analysis_imp_modelc#(my_transaction, my_scoreboard) modelc_imp;
   uvm_analysis_imp_modeld#(my_transaction, my_scoreboard) modeld_imp;
   uvm_analysis_imp_modele#(my_transaction, my_scoreboard) modele_imp;
   uvm_analysis_imp_modelf#(my_transaction, my_scoreboard) modelf_imp;
   `uvm_component_utils(my_scoreboard)

   extern function new(string name, uvm_component parent = null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual task main_phase(uvm_phase phase);
   extern function void write_monitor(my_transaction tr);
   extern function void write_model0(my_transaction tr);
   extern function void write_model1(my_transaction tr);
   extern function void write_model2(my_transaction tr);
   extern function void write_model3(my_transaction tr);
   extern function void write_model4(my_transaction tr);
   extern function void write_model5(my_transaction tr);
   extern function void write_model6(my_transaction tr);
   extern function void write_model7(my_transaction tr);
   extern function void write_model8(my_transaction tr);
   extern function void write_model9(my_transaction tr);
   extern function void write_modela(my_transaction tr);
   extern function void write_modelb(my_transaction tr);
   extern function void write_modelc(my_transaction tr);
   extern function void write_modeld(my_transaction tr);
   extern function void write_modele(my_transaction tr);
   extern function void write_modelf(my_transaction tr);
endclass 

function my_scoreboard::new(string name, uvm_component parent = null);
   super.new(name, parent);
endfunction 

function void my_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   monitor_imp = new("monitor_imp", this);
   model0_imp = new("model0_imp", this);
   model1_imp = new("model1_imp", this);
   model2_imp = new("model2_imp", this);
   model3_imp = new("model3_imp", this);
   model4_imp = new("model4_imp", this);
   model5_imp = new("model5_imp", this);
   model6_imp = new("model6_imp", this);
   model7_imp = new("model7_imp", this);
   model8_imp = new("model8_imp", this);
   model9_imp = new("model9_imp", this);
   modela_imp = new("modela_imp", this);
   modelb_imp = new("modelb_imp", this);
   modelc_imp = new("modelc_imp", this);
   modeld_imp = new("modeld_imp", this);
   modele_imp = new("modele_imp", this);
   modelf_imp = new("modelf_imp", this);
endfunction 

function void my_scoreboard::write_model0(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model1(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model2(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model3(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model4(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model5(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model6(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model7(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model8(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_model9(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modela(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modelb(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modelc(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modeld(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modele(my_transaction tr);
   expect_queue.push_back(tr);
endfunction

function void my_scoreboard::write_modelf(my_transaction tr);
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
