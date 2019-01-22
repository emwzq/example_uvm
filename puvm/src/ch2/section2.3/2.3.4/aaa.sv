class my_env extends uvm_env;
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_active_passive_enum)::set(this, "i_agt", "is_active", UVM_ACTIVE);
      uvm_config_db#(uvm_active_passive_enum)::set(this, "o_agt", "is_active", UVM_PASSIVE);
      i_agt = my_agent::type_id::create("i_agt", this);
      o_agt = my_agent::type_id::create("o_agt", this);
   endfunction
endclass

class my_agent extends uvm_agent ;
   function new(string name, uvm_component parent);
      super.new(name, parent);
      uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
      if (is_active == UVM_ACTIVE) begin
          drv = my_driver::type_id::create("drv", this);
      end
      mon = my_monitor::type_id::create("mon", this);
   endfunction 
endclass 

