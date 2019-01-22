`ifndef C__SV
`define C__SV
class C extends uvm_component;
   `uvm_component_utils(C)

   uvm_blocking_put_port#(my_transaction) C_port;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
endclass

function void C::build_phase(uvm_phase phase);
   super.build_phase(phase);
   C_port = new("C_port", this);
endfunction

task C::main_phase(uvm_phase phase);
   my_transaction tr;
   repeat(10) begin
      #10;
      tr = new("tr");
      assert(tr.randomize());
      C_port.put(tr);
   end
endtask

`endif
