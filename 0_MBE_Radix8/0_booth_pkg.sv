package booth_pkg;
	localparam int unsigned NBIT_MANTISSA = 23;
	
// booth encoder single block
	localparam int unsigned NBLOCK_BE = 9;
	typedef struct packed{
		logic [2:0] code;
		logic sign;					// LSB
	}t_enc_out;
	
// booth select single block 
	typedef struct packed{							// Total 27-bit
		logic [NBIT_MANTISSA+2:0] partial_product;	// 26-bit
		logic sign;									// LSB
	}t_bs_comp_out;

// PPRU block output
	typedef struct packed{
		logic [3:0] upper_signs;
		logic [NBIT_MANTISSA+2:0] pp_extended;
		logic lower_sign;
	}t_o_ppru;
	
endpackage