`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver;

   virtual my_if vif;

   `uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
      `uvm_info("my_driver", "new is called", UVM_LOW);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("my_driver", "build_phase is called", UVM_LOW);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern virtual task main_phase(uvm_phase phase);
endclass

task my_driver::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("my_driver", "main_phase is called", UVM_LOW);
   vif.data <= 8'b0; 
   vif.valid <= 1'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   for(int i = 0; i < 256; i++)begin
      @(posedge vif.clk);
      vif.data <= $urandom_range(0, 255);
      vif.valid <= 1'b1;
      `uvm_info("my_driver", "data is drived", UVM_LOW);
   end
   @(posedge vif.clk);
   vif.valid <= 1'b0;
   phase.drop_objection(this);
endtask
`endif
