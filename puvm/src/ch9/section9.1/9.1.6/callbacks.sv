`ifndef CALLBACKS__SV
`define CALLBACKS__SV

class A extends uvm_callback;
   my_transaction tr;
   
   virtual function bit gen_tran();
   endfunction

   virtual task run(my_driver drv, uvm_phase phase);
      phase.raise_objection(drv);
      
      drv.vif.data <= 8'b0;
      drv.vif.valid <= 1'b0;
      while(!drv.vif.rst_n)
         @(posedge drv.vif.clk);

      while(gen_tran()) begin
         drv.drive_one_pkt(tr);
      end 
      phase.drop_objection(drv);
   endtask
endclass

typedef uvm_callbacks#(my_driver, A) A_pool;


`endif
