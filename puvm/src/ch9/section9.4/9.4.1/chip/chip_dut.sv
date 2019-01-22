module chip_dut(clk,rst_n,rxd,rx_dv,txd,tx_en);
input          clk;
input          rst_n;
input  [7:0]   rxd;
input          rx_dv;
output [7:0]   txd;
output         tx_en;

wire   [7:0]   data0;
wire           dv0;
wire   [7:0]   data1;
wire           dv1;

dut  dut_A(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .rxd          (rxd),
           .rx_dv        (rx_dv),
           .txd          (data0),
           .tx_en        (dv0 ));
dut  dut_B(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .rxd          (data0),
           .rx_dv        (dv0),
           .txd          (data1),
           .tx_en        (dv1 ));
dut  dut_C(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .rxd          (data1),
           .rx_dv        (dv1),
           .txd          (txd),
           .tx_en        (tx_en));
endmodule
