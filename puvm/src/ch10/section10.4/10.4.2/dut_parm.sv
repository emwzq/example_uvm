`ifndef DUT_PARM__SV
`define DUT_PARM__SV

class dut_parm extends uvm_object;
   reg_model p_rm;
  
   `uvm_object_utils(dut_parm) 
   function new(string name = "dut_parm");
      super.new(name);
   endfunction

   rand bit[15:0] a_field0;
   rand bit[15:0] b_field0;

   constraint ab_field_cons{
      a_field0 + b_field0 >= 100;
   }

   task update_reg();
      //p_rm.rega.write(status, a_field0, UVM_FROTDOOR);
      //p_rm.regb.write(status, b_field0, UVM_FROTDOOR);
   endtask
endclass

`endif
