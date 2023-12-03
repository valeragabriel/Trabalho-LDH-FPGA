module controlador (low_in, high_in, dim_out, aum_out);

input wire low_in, high_in;
output wire dim_out, aum_out;

wire not_low_in, not_high_in;

not(not_low_in, low_in);
not(not_high_in, high_in);

and(dim_out, not_low_in, high_in);
and(aum_out, not_high_in, low_in);

endmodule

