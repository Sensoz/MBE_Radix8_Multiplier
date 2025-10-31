module half_adder( 
	input logic a,
	input logic b,
	output logic sum,
	output logic cout
	);
	
	always_comb begin : ha
		sum = a ^ b;	// xor
		cout = a & b;   // and
	end
endmodule