// 4:2 Exact Compressor

module compressor_4_to_2(
	input logic X1,
	input logic X2,
	input logic X3,
	input logic X4,
	input logic Tin,
	output logic S,
	output logic C,
	output logic Tout
);
	
	logic to_adder2;
	
	full_adder FA0 (
					.a(X4),
					.b(X3),
					.cin(X2),
					.sum(to_adder2),
					.cout(Tout)
				);
	full_adder FA1 (
					.a(to_adder2),
					.b(X1),
					.cin(Tin),
					.sum(S),
					.cout(C)
				);
endmodule