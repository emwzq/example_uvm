`ifndef REG_MODEL__SV
`define REG_MODEL__SV

class reg_invert extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 1, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_invert)

    function new(input string name="reg_invert");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_depth extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 16, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_depth)

    function new(input string name="reg_depth");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_vlan extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 10, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_vlan)

    function new(input string name="reg_vlan");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class global_blk extends uvm_reg_block;
   rand reg_invert invert;
   
   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

      invert = reg_invert::type_id::create("invert", , get_full_name());
      invert.configure(this, null, "invert");
      invert.build();
      default_map.add_reg(invert, 'h9, "RW");
   endfunction

    `uvm_object_utils(global_blk)

    function new(input string name="global_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class buf_blk extends uvm_reg_block;
   rand reg_depth depth;
   
   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

      depth = reg_depth::type_id::create("depth", , get_full_name());
      depth.configure(this, null, "depth");
      depth.build();
      default_map.add_reg(depth, 'h3, "RW");
   endfunction

    `uvm_object_utils(buf_blk)

    function new(input string name="buf_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class three_field_reg extends uvm_reg;
    rand uvm_reg_field fieldA;
    rand uvm_reg_field fieldB;
    rand uvm_reg_field fieldC;

    virtual function void build();
        fieldA = uvm_reg_field::type_id::create("fieldA");
        fieldB = uvm_reg_field::type_id::create("fieldB");
        fieldC = uvm_reg_field::type_id::create("fieldC");
    endfunction
    
   `uvm_object_utils(three_field_reg)

    function new(input string name="three_field_reg");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class mac_blk extends uvm_reg_block;

   rand reg_vlan vlan;
   rand three_field_reg tf_reg;
   
   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

      vlan = reg_vlan::type_id::create("vlan", , get_full_name());
      vlan.configure(this, null, "vlan");
      vlan.build();
      default_map.add_reg(vlan, 'h40, "RW");
      
      tf_reg = three_field_reg::type_id::create("tf_reg", , get_full_name());
      tf_reg.configure(this, null, "");
      tf_reg.build();
      tf_reg.fieldA.configure(tf_reg, 2, 0, "RW", 1, 0, 1, 1, 1);
      tf_reg.add_hdl_path_slice("fieldA", 0, 2);
      tf_reg.fieldB.configure(tf_reg, 3, 2, "RW", 1, 0, 1, 1, 1);
      tf_reg.add_hdl_path_slice("fieldA", 2, 3);
      tf_reg.fieldC.configure(tf_reg, 4, 5, "RW", 1, 0, 1, 1, 1);
      tf_reg.add_hdl_path_slice("fieldA", 5, 4);
      default_map.add_reg(tf_reg, 'h41, "RW");
   endfunction

    `uvm_object_utils(mac_blk)

    function new(input string name="mac_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class reg_model extends uvm_reg_block;

   rand global_blk gb_ins;
   rand buf_blk    bb_ins;
   rand mac_blk    mb_ins;

   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);
      gb_ins = global_blk::type_id::create("gb_ins");
      gb_ins.configure(this, "global_reg");
      gb_ins.build();
      gb_ins.lock_model();
      default_map.add_submap(gb_ins.default_map, 16'h0);

      bb_ins = buf_blk::type_id::create("bb_ins");
      bb_ins.configure(this, "buf_reg");
      bb_ins.build();
      bb_ins.lock_model();
      default_map.add_submap(bb_ins.default_map, 16'h1000);

      mb_ins = mac_blk::type_id::create("mb_ins");
      mb_ins.configure(this, "mac_reg");
      mb_ins.build();
      mb_ins.lock_model();
      default_map.add_submap(mb_ins.default_map, 16'h2000);

   endfunction

   `uvm_object_utils(reg_model)

    function new(input string name="reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 

endclass
`endif
