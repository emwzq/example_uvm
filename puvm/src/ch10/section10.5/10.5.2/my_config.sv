`ifndef MY_CONFIG__SV
`define MY_CONFIG__SV
class my_config extends uvm_object;
   `uvm_object_utils(my_config)
   virtual my_if vif;

   function new(string name = "my_config");
      super.new(name);
      $display("%s", get_full_name());
      if(!uvm_config_db#(virtual my_if)::get(null, get_full_name(), "vif", vif))
         `uvm_fatal("my_config", "please set interface")

   endfunction

endclass
`endif
