module controlador (low_in, high_in, dim_out, aum_out);

input wire low_in, high_in;
output wire dim_out, aum_out;

wire not_low_in, not_high_in;

not(not_low_in, low_in);
not(not_high_in, high_in);

and(dim_out, not_low_in, high_in);
and(aum_out, not_high_in, low_in);

endmodule



module controlador_timer (clk, intervalo_ligar, tempo_ligado, saida);

	input wire clk;
	input wire [4:0] intervalo_ligar;
	input wire [4:0] tempo_ligado;
	output reg saida;
	
	reg clk_div_1000, clk_div_1000_000, clk_em_s, clk_em_min, clk_em_horas;
	reg [9:0] contador1;
	reg [9:0] contador2;
	reg [9:0] contador3;
	reg [9:0] contador_seg;
	reg [9:0] contador_min;
	
	reg [4:0] contador;
	reg [4:0] tempo_contado;

	initial begin
		clk_div_1000 <= 0;
		clk_div_1000_000 <= 0;
		clk_em_s <= 0;
		
		contador1 <= 0;
		contador2 <= 0;
		contador3 <= 0;
		contador_seg <= 0;
		contador_min <= 0;
	
		saida <= 1'b0;
		contador <= contador + 1'b1;
	end
	
	always @(posedge clk) begin
		if(contador1 != 1000) begin
			contador1 <= contador1 + 1'b1;
		end else begin
			clk_div_1000 <= ~clk_div_1000;
			contador1 <= 0;
		end
	end
	
	always @(posedge clk_div_1000) begin
		if(contador2 != 1000) begin
			contador2 <= contador2 + 1'b1;
		end else begin
			clk_div_1000_000 <= ~clk_div_1000_000;
			contador2 <= 0;
		end
	end
	
	always @(posedge clk_div_1000_000) begin
		if(contador3 != 1000) begin
			contador3 <= contador3 + 1'b1;
		end else begin
			clk_em_s <= ~clk_em_s;
			contador3 <= 0;
		end
	end
	
	always @(posedge clk_em_s) begin
		if(contador_seg != 60) begin
			contador_seg <= contador_seg + 1'b1;
		end else begin
			clk_em_min <= ~clk_em_min;
			contador_seg <= 0;
		end
	end
	
	always @(posedge clk_em_min) begin
		if(contador_min != 60) begin
			contador_min <= contador_min + 1'b1;
		end else begin
			clk_em_horas <= ~clk_em_horas;
			contador_min <= 0;
		end
	end
		
	//USE
	//clk_em_s -> para contar segundos
	//clk_em_min -> para contar minutos
	//clk_em_horas -> para contar horas
	always @(posedge clk) begin
		
		if (contador != intervalo_ligar - 1'b1) begin
			contador <= contador + 1'b1;
			saida <= 1'b0;
		end else if (tempo_contado != tempo_ligado) begin
			tempo_contado <= tempo_contado + 1'b1;
			saida <= 1'b1;
		end else begin
			tempo_contado <= 4'b0;
			contador <= 4'b0;
			saida <= 1'b0;
		end
	end
endmodule
