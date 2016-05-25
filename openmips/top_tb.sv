`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_driver.sv"
//`include "/home/liujin/workspace/uvm/uvm-1.1d/examples/simple/openmips/dut/defines.v"

module top_tb;

reg clk;
reg rst;

reg[31:0] rom_data;
wire[31:0] rom_addr;
wire rom_ce;
/*wire wb_wreg_i;
wire[`RegAddrBus] wb_wd_i;
wire[`RegBus] wb_wdata_i;
wire reg1_read;
wire reg2_read;
wire[`RegBus] reg1_data;
wire[`RegBus] reg2_data;
wire[`RegAddrBus] reg1_addr;
wire[`RegAddrBus] reg2_addr; 
*/
openmips my_dut(.clk(clk),
           .rst(rst),
           .rom_data_i(rom_data),
           .rom_addr_o(rom_addr),
           .rom_ce_o(rom_ce),
	.wb_wreg_i(wb_wreg_i),
	.wb_wd_i(wb_wd_i),
	.wb_wdata_i(wb_wdata_i),
	.reg1_read(reg1_read),
	.reg1_addr(reg1_addr),
	.reg1_data(reg1_data),
	.reg2_read(reg2_read),
	.reg2_addr(reg2_addr),
	.reg2_data(reg2_data)
);

initial begin
   my_driver drv;
   drv = new("drv", null);
   drv.main_phase(null);
   $finish();
end

initial begin
   clk = 0;
   forever begin
      #10 clk = ~clk;
   end
end

initial begin
   rst = 1'b1;
   #195 rst = 1'b0;
end

initial begin
   $vcdplusfile("wave.vcd");
   $vcdpluson(0,my_dut);
end
   
endmodule
