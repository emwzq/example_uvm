`ifndef CLK_MODEL_SV
`define CLK_MODEL_SV

class clk_model extends uvm_component;
    `uvm_component_utils(clk_model)

   virtual clk_if   vif;
   real  half_period = 100.0;
   
   function new(string name, uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual clk_if)::get(this, "", "vif", vif))
         `uvm_fatal("clk_model", "must set interface for vif")
      void'(uvm_config_db#(real)::get(this, "", "half_period", half_period));
      `uvm_info("clk_model", $sformatf("clk_half_period is %0f", half_period), UVM_MEDIUM)
   endfunction

   virtual task run_phase(uvm_phase phase);
      vif.clk = 0;
      forever begin
         #(half_period*1.0ns) vif.clk = ~vif.clk;
      end
   endtask
endclass

`endif  
