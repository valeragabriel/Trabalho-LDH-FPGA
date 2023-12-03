`timescale 1ns/1ps

module controlador_tb;

reg low_in_umid, high_in_umid;
reg low_in_temp, high_in_temp;

reg [0:4] buff_luz_int, buff_luz_lig;
reg [0:4] buff_irrig_int, buff_irrig_lig;

reg clk;

wire aum_umid, dim_umid;
wire aum_temp, dim_temp;
wire out_luz, out_irrig;

controlador_timer luz_ctrl (clk, buff_luz_int, buff_luz_lig, out_luz);
controlador_timer irrig_ctrl (clk, buff_irrig_int, buff_irrig_lig, out_irrig);

controlador umid_ctrl (low_in_umid, high_in_umid, dim_umid, aum_umid);
controlador temp_ctrl (low_in_temp, high_in_temp, dim_temp, aum_temp);

initial begin 
	buff_luz_int = 5'b01010;
	buff_luz_lig = 5'b00010;
	buff_irrig_int = 5'b10000;
	buff_irrig_lig = 5'b00010;
end

initial begin
	clk = 0;	
	low_in_umid = 0; high_in_umid = 0; #10;
   low_in_umid = 0; high_in_umid = 1; #10;
   low_in_umid = 1; high_in_umid = 0; #10;
   low_in_umid = 1; high_in_umid = 1; #10;
end

always #0.5 clk = ~clk;

initial begin
   low_in_temp = 0; high_in_temp = 0; #10;
   low_in_temp = 0; high_in_temp = 1; #10;
   low_in_temp = 1; high_in_temp = 0; #10;
   low_in_temp = 1; high_in_temp = 1; #10;
end

endmodule
