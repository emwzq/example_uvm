module chip_dut(clk,rst_n,bus_cmd_valid,bus_op,bus_addr,bus_wr_data,bus_rd_data,rxd,rx_dv,txd,tx_en);
input          clk;
input          rst_n;
input          bus_cmd_valid;
input          bus_op;
input  [15:0]  bus_addr;
input  [15:0]  bus_wr_data;
output [15:0]  bus_rd_data;
input  [7:0]   rxd;
input          rx_dv;
output [7:0]   txd;
output         tx_en;

wire           bus_cmd_valid_slv0;
wire           bus_op_slv0;
wire   [15:0]  bus_addr_slv0;
wire   [15:0]  bus_wr_data_slv0;
wire   [15:0]  bus_rd_data_slv0;
wire           bus_cmd_valid_slv1;
wire           bus_op_slv1;
wire   [15:0]  bus_addr_slv1;
wire   [15:0]  bus_wr_data_slv1;
wire   [15:0]  bus_rd_data_slv1;
wire           bus_cmd_valid_slv2;
wire           bus_op_slv2;
wire   [15:0]  bus_addr_slv2;
wire   [15:0]  bus_wr_data_slv2;
wire   [15:0]  bus_rd_data_slv2;

wire   [7:0]   data0;
wire           dv0;
wire   [7:0]   data1;
wire           dv1;

dut  dut_A(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .bus_cmd_valid(bus_cmd_valid_slv0), 
           .bus_op       (bus_op_slv0       ), 
           .bus_addr     (bus_addr_slv0     ), 
           .bus_wr_data  (bus_wr_data_slv0  ), 
           .bus_rd_data  (bus_rd_data_slv0  ), 
           .rxd          (rxd),
           .rx_dv        (rx_dv),
           .txd          (data0),
           .tx_en        (dv0 ));
dut  dut_B(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .bus_cmd_valid(bus_cmd_valid_slv1), 
           .bus_op       (bus_op_slv1       ), 
           .bus_addr     (bus_addr_slv1     ), 
           .bus_wr_data  (bus_wr_data_slv1  ), 
           .bus_rd_data  (bus_rd_data_slv1  ), 
           .rxd          (data0),
           .rx_dv        (dv0),
           .txd          (data1),
           .tx_en        (dv1 ));
dut  dut_C(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .bus_cmd_valid(bus_cmd_valid_slv2), 
           .bus_op       (bus_op_slv2       ), 
           .bus_addr     (bus_addr_slv2     ), 
           .bus_wr_data  (bus_wr_data_slv2  ), 
           .bus_rd_data  (bus_rd_data_slv2  ), 
           .rxd          (data1),
           .rx_dv        (dv1),
           .txd          (txd),
           .tx_en        (tx_en));
arbitor arbitor_inst(
           .clk          (clk               )         , 
           .rst_n        (rst_n             )         , 
           .bus_cmd_valid_mst  ( bus_cmd_valid) , 
           .bus_op_mst         ( bus_op) , 
           .bus_addr_mst       ( bus_addr) , 
           .bus_wr_data_mst    ( bus_wr_data) , 
           .bus_rd_data_mst    ( bus_rd_data) , 
           .bus_cmd_valid_slv0 ( bus_cmd_valid_slv0 ) , 
           .bus_op_slv0        ( bus_op_slv0        ) , 
           .bus_addr_slv0      ( bus_addr_slv0      ) , 
           .bus_wr_data_slv0   ( bus_wr_data_slv0   ) , 
           .bus_rd_data_slv0   ( bus_rd_data_slv0   ) , 
           .bus_cmd_valid_slv1 ( bus_cmd_valid_slv1 ) , 
           .bus_op_slv1        ( bus_op_slv1        ) , 
           .bus_addr_slv1      ( bus_addr_slv1      ) , 
           .bus_wr_data_slv1   ( bus_wr_data_slv1   ) , 
           .bus_rd_data_slv1   ( bus_rd_data_slv1   ) , 
           .bus_cmd_valid_slv2 ( bus_cmd_valid_slv2 ) , 
           .bus_op_slv2        ( bus_op_slv2        ) , 
           .bus_addr_slv2      ( bus_addr_slv2      ) , 
           .bus_wr_data_slv2   ( bus_wr_data_slv2   ) , 
           .bus_rd_data_slv2   ( bus_rd_data_slv2   )  
      );
endmodule
