// Module to generate 3X

// Takes input X and 2X then generate 3X
// X = 23-bit, 2X = 24-bit
// Sum (3X) = 25-bit

// Output should be 25-bit
// 23-bit mantissa is multiplied by 4 which means left-shift by 2.
// It creates maximum length of 25-bit. The result of 3X is adjusted according to 25-bit

module Ripple_Carry_Adder #(
		parameter N = 25	  // 25-bit ADDER
	)(
	input logic [N-1:0] A, 	
	input logic [N-1:0] B,		  
	input logic Cin,
	output logic [N-1:0] Sum		// 25-bit including carry out bit
);

    wire [N:0] w_carry;
	genvar i;

	assign w_carry[0] = Cin;
	generate
		for (i = 0; i < N; i++) begin
			full_adder FA ( .a(A[i]),
						    .b(B[i]),
							.cin(w_carry[i]),
							.sum(Sum[i]),
							.cout(w_carry[i+1])
							);
		end
	endgenerate
endmodule