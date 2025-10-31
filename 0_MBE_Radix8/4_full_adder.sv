// Adder to create 3X
//`include "half_adder.sv"

module full_adder(a,b,cin,sum, cout);
	input logic a,b,cin;
	output logic sum, cout;
	wire x,y,z;
	
	half_adder h1(.a(a), .b(b), .sum(x), .cout(y));
	half_adder h2(.a(x), .b(cin), .sum(sum), .cout(z));
	assign cout = z | y;	// or
endmodule
