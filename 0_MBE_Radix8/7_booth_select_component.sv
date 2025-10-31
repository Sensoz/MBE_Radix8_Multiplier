// Booth Select component:
// Takes inputs coming from partial product generator and select one of them with signal
// coming from Booth Encoder module.

// Selection done among following inputs: 0,X,2X,3X,4X,-X,-2X,-3X,-4X
// If negative value is selected, 1's complement is calculated in this module but 2's complement is taken
// in partial product accumulation stage.

module booth_select #(
		parameter int unsigned N = 23	// mantissa width
	)(
	input logic [N+2:0] 			i_X,		// 26-bit = 23-bit mantissa + 1 hidden bit + 2 shift bits
	input logic [N+2:0] 			i_X_2x,     // 26-bit
	input logic [N+2:0] 			i_X_3x,     // 26-bit
	input logic [N+2:0] 			i_X_4x,     // 26-bit
	input booth_pkg::t_enc_out 		sel,
	output booth_pkg::t_bs_comp_out partial_product	// 26-bit
);

	logic [N+2:0] temp, not_temp;
	genvar i;

 	generate
		for(i = 0; i < N+3; i++) begin
			assign not_temp[i] = ~temp[i];
		end
	endgenerate 
	
	always_comb begin : bs	
		// Select X
		case ( sel.code )
/* 0 */		3'b000  : temp = 26'd0;	   //  0
/* 1 */		3'b001  : temp = i_X;	   //  X					
/* 2 */		3'b010  : temp = i_X_2x;   // 2X					
/* 3 */		3'b011  : temp = i_X_3x;   // 3X					
/* 4 */		3'b100  : temp = i_X_4x;   // 4X											
			default : temp = 26'd0;	   //  0
		endcase
	
		case (sel.sign)				//    pp       sign
			1'b0    : partial_product = {temp,     1'b0}; 	// it is positive number		
			1'b1    : partial_product = {not_temp, 1'b1}; 	// 1's complement
			default : partial_product = 25'd0; 				// default
		endcase
	end
endmodule