
task my_driver::drive_one_pkt(my_transaction tr);
   byte unsigned     data_q[];
   bit[9:0]  data10b_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   data10b_q = new[data_size];
   for(int i = 0; i < data_size; i++)
      data10b_q[i] = encode_8b10b(data_q[i]); 
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge vif.p_clk);
      for(int j = 0; j < 10; j++) begin
         @(posedge vif.s_clk);
         vif.sdata <= data10b_q[i][j];
      end
   end
endtask

interface my_if(input p_clk, input s_clk, input rst_n);

   logic      sdata;
   logic[7:0] data_8b;
   logic[9:0] data_10b;

   always@(posedge p_clk) begin
      data_10b <= encode_8b10b(data_8b); 
   end

   always@(posedge p_clk) begin
      for(int i = 0; i < 10; i++) begin
         @(posedge s_clk);
         sdata <= data_10b[i];
      end
   end
endinterface

task my_driver::drive_one_pkt(my_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge vif.p_clk);
      vif.data_8b <= data_q[i];
   end
endtask

interface my_if(input p_clk, input s_clk, input rst_n);
   assign data_10b = (err_8b10b ? data_10b_wrong : data_10b_right);
endinterface

interface if_8b10b();
   function bit[9:0] encode(bit[7:0] data_8b);
      ...
   endfunction
   function bit[7:0] encode(bit[9:0] data_10b);
      ...
   endfunction
endinterface

interface my_if(input p_clk, input s_clk, input rst_n);

   logic      sdata;
   logic[7:0] data_8b;
   logic[9:0] data_10b;

   if_8b10b encode_if();

   always@(posedge p_clk) begin
      data_10b <= encode_if.encode(data_8b); 
   end

   always@(posedge p_clk) begin
      for(int i = 0; i < 10; i++) begin
         @(posedge s_clk);
         sdata <= data_10b[i];
      end
   end
endinterface

