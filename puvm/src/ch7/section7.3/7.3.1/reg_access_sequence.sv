`ifndef REG_ACCESS_SEQUENCE__SV
`define REG_ACCESS_SEQUENCE__SV

class reg_access_sequence extends uvm_sequence#(bus_transaction);
   string tID = get_type_name();

   bit[15:0] addr;
   bit[15:0] rdata;
   bit[15:0] wdata;
   bit       is_wr;

   `uvm_object_utils(reg_access_sequence)
   function new(string name = "reg_access_sequence");
      super.new(name);
   endfunction

   virtual task body();
      bus_transaction tr;
      tr = new("tr");
      tr.addr = this.addr;
      tr.wr_data = this.wdata;
      tr.bus_op = (is_wr ? BUS_WR : BUS_RD);
      `uvm_info(tID, $sformatf("begin to access register: is_wr = %0d, addr = %0h", is_wr, addr), UVM_MEDIUM)
      `uvm_send(tr)
      `uvm_info(tID, "successfull access register", UVM_MEDIUM)
      this.rdata = tr.rd_data;
   endtask
endclass
`endif
