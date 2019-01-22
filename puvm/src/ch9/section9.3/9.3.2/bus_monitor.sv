`ifndef BUS_MONITOR__SV
`define BUS_MONITOR__SV
class bus_monitor#(int ADDR_WIDTH=16, int DATA_WIDTH=16) extends uvm_monitor;

   virtual bus_if#(ADDR_WIDTH, DATA_WIDTH) vif;

   uvm_analysis_port #(bus_transaction#(ADDR_WIDTH, DATA_WIDTH))  ap;
   
   `uvm_component_utils(bus_monitor#(ADDR_WIDTH, DATA_WIDTH))
   function new(string name = "bus_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual bus_if#(ADDR_WIDTH, DATA_WIDTH))::get(this, "", "vif", vif))
         `uvm_fatal("bus_monitor", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

   task main_phase(uvm_phase phase);
      bus_transaction#(ADDR_WIDTH, DATA_WIDTH) tr;
      while(1) begin
         tr = new("tr");
         collect_one_pkt(tr);
         ap.write(tr);
      end
   endtask

   task collect_one_pkt(bus_transaction#(ADDR_WIDTH, DATA_WIDTH) tr);
      
      while(1) begin
         @(posedge vif.clk);
         if(vif.bus_cmd_valid) break;
      end
   
      tr.bus_op = ((vif.bus_op == 0) ? BUS_RD : BUS_WR);
      tr.addr = vif.bus_addr;
      tr.wr_data = vif.bus_wr_data;
      @(posedge vif.clk);
      tr.rd_data = vif.bus_rd_data;
      `uvm_info("bus_monitor", "end collect one pkt", UVM_LOW);
   endtask

endclass

`endif
