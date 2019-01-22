`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver#(my_transaction);

   my_config     cfg;

   `uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
   cfg.vif.data <= 8'b0;
   cfg.vif.valid <= 1'b0;
   while(!cfg.vif.rst_n)
      @(posedge cfg.vif.clk);
   while(1) begin
      seq_item_port.get_next_item(req);
      drive_one_pkt(req);
      seq_item_port.item_done();
   end
endtask

task my_driver::drive_one_pkt(my_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   //`uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge cfg.vif.clk);
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge cfg.vif.clk);
      cfg.vif.valid <= 1'b1;
      cfg.vif.data <= data_q[i]; 
   end

   @(posedge cfg.vif.clk);
   cfg.vif.valid <= 1'b0;
   //`uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask


`endif
