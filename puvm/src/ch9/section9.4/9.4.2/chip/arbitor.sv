module arbitor(clk,rst_n,
      bus_cmd_valid_mst,bus_op_mst,bus_addr_mst,bus_wr_data_mst,bus_rd_data_mst,
      bus_cmd_valid_slv0,bus_op_slv0,bus_addr_slv0,bus_wr_data_slv0,bus_rd_data_slv0,
      bus_cmd_valid_slv1,bus_op_slv1,bus_addr_slv1,bus_wr_data_slv1,bus_rd_data_slv1,
      bus_cmd_valid_slv2,bus_op_slv2,bus_addr_slv2,bus_wr_data_slv2,bus_rd_data_slv2);
input          clk;
input          rst_n;
input          bus_cmd_valid_mst;
input          bus_op_mst;
input  [15:0]  bus_addr_mst;
input  [15:0]  bus_wr_data_mst;
output [15:0]  bus_rd_data_mst;
output         bus_cmd_valid_slv0;
output         bus_op_slv0;
output [15:0]  bus_addr_slv0;
output [15:0]  bus_wr_data_slv0;
input  [15:0]  bus_rd_data_slv0;
output         bus_cmd_valid_slv1;
output         bus_op_slv1;
output [15:0]  bus_addr_slv1;
output [15:0]  bus_wr_data_slv1;
input  [15:0]  bus_rd_data_slv1;
output         bus_cmd_valid_slv2;
output         bus_op_slv2;
output [15:0]  bus_addr_slv2;
output [15:0]  bus_wr_data_slv2;
input  [15:0]  bus_rd_data_slv2;

assign bus_op_slv0 = bus_op_mst;
assign bus_op_slv1 = bus_op_mst;
assign bus_op_slv2 = bus_op_mst;
assign bus_addr_slv0 = {2'b0, bus_addr_mst[13:0]};
assign bus_addr_slv1 = {2'b0, bus_addr_mst[13:0]};
assign bus_addr_slv2 = {2'b0, bus_addr_mst[13:0]};
assign bus_wr_data_slv0 = bus_wr_data_mst;
assign bus_wr_data_slv1 = bus_wr_data_mst;
assign bus_wr_data_slv2 = bus_wr_data_mst;

assign bus_cmd_valid_slv0 = ((bus_addr_mst[15:14] == 2'b00) ? bus_cmd_valid_mst : 0);
assign bus_cmd_valid_slv1 = ((bus_addr_mst[15:14] == 2'b01) ? bus_cmd_valid_mst : 0);
assign bus_cmd_valid_slv2 = ((bus_addr_mst[15:14] == 2'b10) ? bus_cmd_valid_mst : 0);

assign bus_rd_data_mst = ((bus_addr_mst[15:14] == 2'b00) ? bus_rd_data_slv0 :
                         ((bus_addr_mst[15:14] == 2'b01) ? bus_rd_data_slv1 :
                           bus_rd_data_slv2));

endmodule
