// Partial Product Sign Reduction module:
// This modele takes 24-bit partial products with their signs. 1's complement of negative values were taken in BSU module.
// If a sign is 1, then 1 will be added to take 2's complement of the number.
// The block produce 8 partial product with different bit length
// At each line number of bits are given below
//  0: 30-bit	
//  1: 29-bit + sign
//  2: 29-bit + sign
//  3: 29-bit + sign
//  4: 29-bit + sign
//  5: 29-bit + sign
//  6: 29-bit + sign
//  7: 27-bit + sign
//  8: 24-bit + sign

module PPRU_module #(
		parameter int unsigned NBLOCK = 9
	)(
	input booth_pkg::t_bs_comp_out [NBLOCK-1:0] PP,
	output booth_pkg::t_o_ppru     [NBLOCK-1:0] PP_Signed_Stages	// output 8 PP at once, the last PP appended with 3 zeros 
);
	genvar i;
	
	generate
		for(i = 0; i < NBLOCK; i++) begin
			assign PP_Signed_Stages[i].pp_extended = PP[i].partial_product;	// 26-bit assignment
			
			if( i == 0 )					// stage 0
			begin
				assign PP_Signed_Stages[0].upper_signs = { ~(PP[0].sign), PP[0].sign, PP[0].sign, PP[0].sign };   // ~S, S, S, S
				assign PP_Signed_Stages[0].lower_sign  = 1'b0;							// no sign here, just put zero
			end
			else if( i < 7 )				// stage 1-6
			begin
				assign PP_Signed_Stages[i].upper_signs = { 3'b011, ~(PP[i].sign) };		// MSbit = 0 that will never be used: 1, 1, ~S
			    assign PP_Signed_Stages[i].lower_sign  = PP[i-1].sign;					// Previous sign will be added
			end
			else if(i == 7 )				// stage 7
			begin
				assign PP_Signed_Stages[7].upper_signs = { 3'b000, ~(PP[i].sign) };		// just ~S
				assign PP_Signed_Stages[7].lower_sign  = PP[i-1].sign;					// Previous sign will be added	
			end
			else
			begin
				assign PP_Signed_Stages[8].upper_signs = 4'b0000;						// No sign
				assign PP_Signed_Stages[8].lower_sign  = PP[i-1].sign;					// Previous sign will be added	
			end
		end
	endgenerate

endmodule