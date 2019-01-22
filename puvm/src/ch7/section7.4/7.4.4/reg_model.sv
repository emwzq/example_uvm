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

class reg_counter extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 32, 0, "W1C", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_counter)

    function new(input string name="reg_counter");
        //parameter: name, size, has_coverage
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_model extends uvm_reg_block;
   rand reg_invert invert;
   rand reg_counter counter;

   virtual function void build();
      default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

      invert = reg_invert::type_id::create("invert", , get_full_name());
      invert.configure(this, null, "invert");
      invert.build();
      default_map.add_reg(invert, 'h9, "RW");
      
      counter= reg_counter::type_id::create("counter", , get_full_name());
      counter.configure(this, null, "counter");
      counter.build();
      default_map.add_reg(counter, 'h5, "RW");
   endfunction

   `uvm_object_utils(reg_model)

    function new(input string name="reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 

endclass
`endif
