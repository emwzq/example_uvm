`ifndef BUS_DRIVER__SV
`define BUS_DRIVER__SV
class bus_driver extends uvm_driver#(bus_transaction);

   virtual bus_if vif;

   `uvm_component_utils(bus_driver)
   function new(string name = "bus_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual bus_if)::get(this, "", "vif", vif))
         `uvm_fatal("bus_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern task run_phase(uvm_phase phase);
   extern task drive_one_pkt(bus_transaction tr);
endclass

task bus_driver::run_phase(uvm_phase phase);
   vif.bus_cmd_valid <= 1'b0;
   vif.bus_op <= 1'b0;
   vif.bus_addr <= 15'b0;
   vif.bus_wr_data <= 15'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   while(1) begin
      seq_item_port.get_next_item(req);
      drive_one_pkt(req);
      seq_item_port.item_done();
   end
endtask

task bus_driver::drive_one_pkt(bus_transaction tr);
   `uvm_info("bus_driver", "begin to drive one pkt", UVM_LOW);
   repeat(1) @(posedge vif.clk);
   
   vif.bus_cmd_valid <= 1'b1;
   vif.bus_op <= ((tr.bus_op == BUS_RD) ? 0 : 1);
   vif.bus_addr = tr.addr;
   vif.bus_wr_data <= ((tr.bus_op == BUS_RD) ? 0 : tr.wr_data);

   @(posedge vif.clk);
   vif.bus_cmd_valid <= 1'b0;
   vif.bus_op <= 1'b0;
   vif.bus_addr <= 15'b0;
   vif.bus_wr_data <= 15'b0;

   @(posedge vif.clk);
   if(tr.bus_op == BUS_RD) begin
      tr.rd_data = vif.bus_rd_data;   
      //$display("@%0t, rd_data is %0h", $time, tr.rd_data);
   end

   `uvm_info("bus_driver", "end drive one pkt", UVM_LOW);
endtask


`endif
