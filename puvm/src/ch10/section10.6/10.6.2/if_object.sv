`ifndef IF_OBJECT__SV
`define IF_OBJECT__SV
class if_object extends uvm_object;

   `uvm_object_utils(if_object)
   function new(string name = "if_object");
      super.new(name);
   endfunction

   static if_object me;

   static function if_object get();
      if(me == null) begin
         me = new("me");
      end
      return me;
   endfunction

   virtual my_if input_vif0;
   virtual my_if output_vif0;
   virtual my_if input_vif1;
   virtual my_if output_vif1;
endclass

`endif
