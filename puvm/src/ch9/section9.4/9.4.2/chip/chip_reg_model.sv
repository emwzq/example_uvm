`ifndef CHIP_REG_MODEL__SV
`define CHIP_REG_MODEL__SV

class chip_reg_model extends uvm_reg_block;
   rand reg_model A_rm;
   rand reg_model B_rm;
   rand reg_model C_rm;

   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);
      A_rm = reg_model::type_id::create("A_rm");
      A_rm.configure(this, "");
      A_rm.build();
      A_rm.lock_model();
      default_map.add_submap(A_rm.default_map, 16'h0);
   
      B_rm = reg_model::type_id::create("B_rm");
      B_rm.configure(this, "");
      B_rm.build();
      B_rm.lock_model();
      default_map.add_submap(B_rm.default_map, 16'h4000);
   
      C_rm = reg_model::type_id::create("C_rm");
      C_rm.configure(this, "");
      C_rm.build();
      C_rm.lock_model();
      default_map.add_submap(C_rm.default_map, 16'h8000);
   endfunction

   `uvm_object_utils(chip_reg_model)
endclass

`endif
