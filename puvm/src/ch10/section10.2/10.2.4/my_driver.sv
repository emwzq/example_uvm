`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver#(my_transaction);

   virtual my_if vif;

   `uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_idle();
   extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::drive_idle();
   `uvm_info("my_driver", "item is null", UVM_MEDIUM)
endtask

task my_driver::main_phase(uvm_phase phase);
   vif.data <= 8'b0;
   vif.valid <= 1'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   while(1) begin
      @(posedge vif.clk);
      seq_item_port.try_next_item(req);
      if(req == null) begin
         drive_idle();
      end
      else begin   
         drive_one_pkt(req);
         seq_item_port.item_done();
      end
   end
endtask

task my_driver::drive_one_pkt(my_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   //`uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge vif.clk);
   for ( int i = 0; i < data_size; i++ ) begin
      vif.valid <= 1'b1;
      vif.data <= data_q[i]; 
      @(posedge vif.clk);
   end

   vif.valid <= 1'b0;
   //`uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask


`endif
