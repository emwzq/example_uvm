
task my_driver::main_phase(uvm_phase phase);
   fork
      while(1) begin
         #delay;
         drive_heartbeat_pkt();
      end
      while(1) begin
         seq_item_port.get_next_item(req);
         drive_one_pkt(req);
         seq_item_port.item_done();
      end
   join
endtask
