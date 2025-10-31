// Booth Encoder module:
// Takes mantissa as an input. Since Radix-8 is used, 4-bit selection bits are used.
// Firstly, add logic '0' at the beginning of matissa:  "110...100110" & '0'
// If mantissa+1 bit can be divided in 4 -> no problem
// else append zeros to mantissa to be dividable by 4

// In this case mantissa is 23-bit and by inserting zero at the beginning, it will be 24-bit. By padding one 0 at the MSbit,
// positive value will be guranteed.
// New Mantissa:
// 0 & (22 downto 0) & 0 = 25-bit

// Select Bits:
// 0-3 3-6 6-9 ... 21-24, 24-27
module BE_module #(
		parameter int unsigned NBIT_MANTISSA = 23,
		parameter int unsigned NBLOCK = 9
	)(
	input logic [NBIT_MANTISSA:0]    mantissa,					// 23-bit mantissa for 32-bit Floating Number and + 1 hidden bit = 24-bit
	output logic [NBLOCK-1:0] [3:0]  o_booth_encoder 			// 4-bit width, 8 array size - packed
);

	logic [27:0] extended_mantissa;	// 28-bit
	genvar i;

// mantissa modification
	assign extended_mantissa = {3'b000, mantissa, 1'b0};		// 1 hidden bit has already included in mantissa as an input
// 0-3 3-6 6-9 ...	24-27
	generate
		for(i = 0; i < NBLOCK; i++) begin
			booth_encoder BE (
								.select_bits(extended_mantissa[3*i+3:3*i]),
								.enc_out(o_booth_encoder[i])
							);
		end
	endgenerate	
endmodule

