`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

class my_transaction extends uvm_sequence_item;

   rand bit[47:0] dmac;
   rand bit[47:0] smac;
   rand bit[15:0] vlan_info1;
   rand bit[2:0]  vlan_info2;
   rand bit       vlan_info3;
   rand bit[11:0] vlan_info4;
   rand bit[15:0] ether_type;
   rand byte      pload[];
   rand bit[31:0] crc;

   rand bit       is_vlan;

   constraint pload_cons{
      pload.size >= 46;
      pload.size <= 1500;
   }

   function bit[31:0] calc_crc();
      return 32'h0;
   endfunction

   function void post_randomize();
      crc = calc_crc;
   endfunction

   `uvm_object_utils_begin(my_transaction)
      `uvm_field_int(dmac, UVM_ALL_ON)
      `uvm_field_int(smac, UVM_ALL_ON)
      if(is_vlan)begin
         `uvm_field_int(vlan_info1, UVM_ALL_ON)
         `uvm_field_int(vlan_info2, UVM_ALL_ON)
         `uvm_field_int(vlan_info3, UVM_ALL_ON)
         `uvm_field_int(vlan_info4, UVM_ALL_ON)
      end
      `uvm_field_int(ether_type, UVM_ALL_ON)
      `uvm_field_array_int(pload, UVM_ALL_ON)
      `uvm_field_int(crc, UVM_ALL_ON | UVM_NOPACK)
      `uvm_field_int(is_vlan, UVM_ALL_ON | UVM_NOPACK)
   `uvm_object_utils_end

   function new(string name = "my_transaction");
      super.new();
   endfunction

endclass
`endif
