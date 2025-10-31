// Booth Encoder:
// For Radix-8 implementation, it takes 4-bits {log2(8) + 1} input from mantissa
// and generate control bits for Booth Selector

import booth_pkg::*;

module booth_encoder(
	input logic [3:0] 	         select_bits,
	output booth_pkg::t_enc_out  enc_out 
);
	always_comb begin: dec
		case ( select_bits[3:0] )
/*  0 */	4'b0000 : begin enc_out.code = 3'b000; enc_out.sign = 1'b0; end  //   0		0
/*  1 */	4'b0001 : begin enc_out.code = 3'b001; enc_out.sign = 1'b0; end  //   X		2
/*  2 */	4'b0010 : begin enc_out.code = 3'b001; enc_out.sign = 1'b0; end  //   X 	2
/*  3 */	4'b0011 : begin enc_out.code = 3'b010; enc_out.sign = 1'b0; end  //  2X 	4
/*  4 */	4'b0100 : begin enc_out.code = 3'b010; enc_out.sign = 1'b0; end  //  2X 	4
/*  5 */	4'b0101 : begin enc_out.code = 3'b011; enc_out.sign = 1'b0; end  //  3X 	6
/*  6 */	4'b0110 : begin enc_out.code = 3'b011; enc_out.sign = 1'b0; end  //  3X 	6
/*  7 */	4'b0111 : begin enc_out.code = 3'b100; enc_out.sign = 1'b0; end  //  4X 	8
/*  8 */	4'b1000 : begin enc_out.code = 3'b100; enc_out.sign = 1'b1; end  // -4X		9
/*  9 */	4'b1001 : begin enc_out.code = 3'b011; enc_out.sign = 1'b1; end  // -3X		7
/* 10 */	4'b1010 : begin enc_out.code = 3'b011; enc_out.sign = 1'b1; end  // -3X		7
/* 11 */	4'b1011 : begin enc_out.code = 3'b010; enc_out.sign = 1'b1; end  // -2X		5
/* 12 */	4'b1100 : begin enc_out.code = 3'b010; enc_out.sign = 1'b1; end  // -2X		5
/* 13 */	4'b1101 : begin enc_out.code = 3'b001; enc_out.sign = 1'b1; end  //  -X		3
/* 14 */	4'b1110 : begin enc_out.code = 3'b001; enc_out.sign = 1'b1; end  //  -X		3
/* 15 */	4'b1111 : begin enc_out.code = 3'b000; enc_out.sign = 1'b0; end  //   0		0
			default : begin enc_out.code = 3'b000; enc_out.sign = 1'b0; end  //   0 	0
		endcase
	end
endmodule