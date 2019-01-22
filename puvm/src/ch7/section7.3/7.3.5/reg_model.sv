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

class reg_counter_low extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 16, 0, "W1C", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_counter_low)

    function new(input string name="reg_counter_low");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_counter_high extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 16, 0, "W1C", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_counter_high)

    function new(input string name="reg_counter_high");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_model extends uvm_reg_block;
   rand reg_invert invert;
   rand reg_counter_high counter_high;
   rand reg_counter_low counter_low;

   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

      invert = reg_invert::type_id::create("invert", , get_full_name());
      invert.configure(this, null, "invert");
      invert.build();
      default_map.add_reg(invert, 'h9, "RW");
      counter_high = reg_counter_high::type_id::create("counter_high", , get_full_name());
      counter_high.configure(this, null, "counter[31:16]");
      counter_high.build();
      default_map.add_reg(counter_high, 'h5, "RW");
      counter_low = reg_counter_low::type_id::create("counter_low", , get_full_name());
      counter_low.configure(this, null, "counter[15:0]");
      counter_low.build();
      default_map.add_reg(counter_low, 'h6, "RW");
   endfunction

   `uvm_object_utils(reg_model)

    function new(input string name="reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 

endclass
`endif
