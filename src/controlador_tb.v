`timescale 1ns/1ps

module controlador_tb;

reg low_in_umid, high_in_umid;
reg low_in_temp, high_in_temp;
reg buff_luz, buff_irrig;
reg clk;

wire aum_umid, dim_umid;
wire aum_temp, dim_temp;
wire out_luz, out_irrig;

//controlador umid_ctrl (low_in_umid, high_in_umid, dim_umid, aum_umid);
//controlador temp_ctrl (low_in_temp, high_in_temp, dim_temp, aum_temp);

controlador_timer luz_ctrl (clk, 5'b01010, 5'b00010, out_luz);
controlador_timer irrig_ctrl (clk, 5'b10000, 5'b00010, out_irrig);

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
