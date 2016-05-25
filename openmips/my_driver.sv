`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver;

   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction
   extern virtual task main_phase(uvm_phase phase);
endclass

task my_driver::main_phase(uvm_phase phase);
   `uvm_info("my_driver", "coming!!", UVM_LOW)
   top_tb.rom_data <= 8'b0; 
   while(top_tb.rst == 1'b1)
      @(posedge top_tb.clk);
   for(int i = 0; i < 50; i++)begin
      @(posedge top_tb.clk);
      if(top_tb.rom_ce == 1'b1) top_tb.rom_data <= 32'h34011100 + i;
      `uvm_info("my_driver", "data is drived", UVM_LOW)
   end
   @(posedge top_tb.clk);
   top_tb.rom_data <= 1'b0;
endtask
`endif
