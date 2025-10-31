// MBE RADIX 8 top module

module top_MBE_R8 #(
	parameter int unsigned NBIT_MANTISSA = 23,
	parameter int unsigned NBLOCK        = 9
)(
	input logic [NBIT_MANTISSA:0]   X,	// multiplicand
	input logic [NBIT_MANTISSA:0]   Y,  // multiplier
	output logic [47:0] P	// product  
);

// BE signals
	logic [NBLOCK-1:0] [3:0]  				o_BE;
// Partial Product Generator signals
	logic [NBIT_MANTISSA+2:0]   			o_X, o_X_2x, o_X_3x, o_X_4x;
// BS signals
	booth_pkg::t_bs_comp_out [NBLOCK-1:0]   o_BS;
// PPRU signals
	booth_pkg::t_o_ppru [NBLOCK-1:0]		o_PPRU;

	
// Booth Encoder Module
	BE_module #(.NBIT_MANTISSA(NBIT_MANTISSA),
				.NBLOCK(NBLOCK)
	) C_BOOTH_ENCODER(
		.mantissa(Y),
		.o_booth_encoder(o_BE)
	);
// Partial Product Generator
	PPG #(.N(NBIT_MANTISSA)
	) C_PPG (
		.X(X),	  	
		.X_default(o_X),
		.X_2x(o_X_2x),	
		.X_3x(o_X_3x),	
	    .X_4x(o_X_4x)		
	);	
// Booth Select Module
	BS_module #(.NBIT(NBIT_MANTISSA),
				.NBLOCK(NBLOCK)
	) C_BOOTH_SELECT(
		.X(o_X),
		.X_2x(o_X_2x),
		.X_3x(o_X_3x),
		.X_4x(o_X_4x),
		.sel(o_BE),
		.partial_products(o_BS)
	);
// Partial Product Sign Reduction module
	PPRU_module #(.NBLOCK(NBLOCK)
	) C_PPRU (
		.PP(o_BS),
		.PP_Signed_Stages(o_PPRU)
	);

// ADDER	
	dadda_24bit ADDER(
		.PP_S(o_PPRU),
		.Product(P)
	);
endmodule