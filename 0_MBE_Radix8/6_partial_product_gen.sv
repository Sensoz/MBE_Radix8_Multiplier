// Partial Product Generation Module
// Takes input X and generates X, 2X, 3X and 4X
// Input is 24-bits
// Output is 26-bits. Maximum shift-2-left


module PPG #(
		parameter N = 23	// input mantissa - 23 bits
	)(
	input  logic [N:0] X,	  		  	// mantissa 23 bit + 1 hidden bit = 24 bit
	output logic [(N+2):0] X_default,	// 26-bits
	output logic [(N+2):0] X_2x,		// 26-bits
	output logic [(N+2):0] X_3x,		// 26-bits
	output logic [(N+2):0] X_4x			// 26-bits
);
	Ripple_Carry_Adder #(.N(N+3)) RCA(		// 26-bit adder
										.A(X_default),
										.B(X_2x),
										.Cin(1'b0),
										.Sum(X_3x)		// 3X
									);
	always_comb begin : products
		X_default  = {2'b00, X};
		X_2x 	   = (X_default << 1);	// 2X
		X_4x 	   = (X_default << 2);  // 4X
	end
endmodule