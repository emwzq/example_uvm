`ifndef YOUR_TRANSACTION__SV
`define YOUR_TRANSACTION__SV

class your_transaction extends uvm_sequence_item;

   string information;
   `uvm_object_utils(your_transaction)

   function new(string name = "your_transaction");
      super.new();
   endfunction

endclass
`endif
