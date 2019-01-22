`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
typedef class your_transaction;
class my_driver extends uvm_driver#(uvm_sequence_item);

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
   extern task drive_my_transaction(my_transaction tr);
   extern task drive_your_transaction(your_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
   my_transaction m_tr;
   your_transaction y_tr;
   vif.data <= 8'b0;
   vif.valid <= 1'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   while(1) begin
      seq_item_port.get_next_item(req);
      if($cast(m_tr, req)) begin
          drive_my_transaction(m_tr);
         `uvm_info("driver", "receive a transaction whose type is my_transaction", UVM_MEDIUM)
      end
      else if($cast(y_tr, req)) begin
         drive_your_transaction(y_tr);
         `uvm_info("driver", "receive a transaction whose type is your_transaction", UVM_MEDIUM)
      end
      else begin
         `uvm_error("driver", "receive a transaction whose type is unknown")
      end
      seq_item_port.item_done();
   end
endtask

task my_driver::drive_your_transaction(your_transaction tr);
   #1000;
endtask

task my_driver::drive_my_transaction(my_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   //`uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge vif.clk);
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge vif.clk);
      vif.valid <= 1'b1;
      vif.data <= data_q[i]; 
   end

   @(posedge vif.clk);
   vif.valid <= 1'b0;
   //`uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask


`endif
