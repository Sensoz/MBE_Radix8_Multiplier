module dadda_24bit(
	input logic [8:0] [30:0] PP_S,
	output logic [47:0]      Product
);

	logic [33:0] layer_1_cout, layer_1_sum;
	logic [16:0] layer_1_t;

	logic [34:0] layer_2_cout, layer_2_sum;
	logic [28:0] layer_2_t;
	
	logic [40:0] layer_3_cout, layer_3_sum;
	
	logic [44:0] layer_4_cout, layer_4_sum;

	logic [47:0] layer_5_cout;
	genvar i;
// ******************************************* LAYER-1 *******************************************
	half_adder        L1_HA1  ( .a(PP_S[0][16]), .b(PP_S[1][13]),                                                                 .sum(layer_1_sum[0]),  .cout(layer_1_cout[0]) );
	half_adder        L1_HA2  ( .a(PP_S[0][17]), .b(PP_S[1][14]),                                                                 .sum(layer_1_sum[1]),  .cout(layer_1_cout[1]) );
	half_adder        L1_HA3  ( .a(PP_S[0][18]), .b(PP_S[1][15]),                                                                 .sum(layer_1_sum[2]),  .cout(layer_1_cout[2]) );

	compressor_4_to_2 L1_CP1  ( .X1(PP_S[0][19]),     .X2(PP_S[1][16]),    .X3(PP_S[2][13]),  .X4(PP_S[3][10]), .Tin(1'b0),         .S(layer_1_sum[3]),     .C(layer_1_cout[3]),  .Tout(layer_1_t[0])  );
	compressor_4_to_2 L1_CP2  ( .X1(PP_S[0][20]),     .X2(PP_S[1][17]),    .X3(PP_S[2][14]),  .X4(PP_S[3][11]), .Tin(layer_1_t[0]), .S(layer_1_sum[4]),     .C(layer_1_cout[4]),  .Tout(layer_1_t[1])  );
	compressor_4_to_2 L1_CP3  ( .X1(PP_S[0][21]),     .X2(PP_S[1][18]),    .X3(PP_S[2][15]),  .X4(PP_S[3][12]), .Tin(layer_1_t[1]), .S(layer_1_sum[5]),     .C(layer_1_cout[5]),  .Tout(layer_1_t[2])  );
	
	compressor_4_to_2 L1_CP4  ( .X1(PP_S[0][22]),     .X2(PP_S[1][19]),    .X3(PP_S[2][16]),  .X4(PP_S[3][13]), .Tin(layer_1_t[2]), .S(layer_1_sum[6]),     .C(layer_1_cout[6]),  .Tout(layer_1_t[3])  );
	half_adder 		  L1_HA4  ( .a(PP_S[4][10]), .b(PP_S[5][7]), 								                                  .sum(layer_1_sum[7]),  .cout(layer_1_cout[7]) );
	compressor_4_to_2 L1_CP5  ( .X1(PP_S[0][23]),     .X2(PP_S[1][20]),    .X3(PP_S[2][17]),  .X4(PP_S[3][14]), .Tin(layer_1_t[3]), .S(layer_1_sum[8]),     .C(layer_1_cout[8]),  .Tout(layer_1_t[4])  );
	half_adder 		  L1_HA5  ( .a(PP_S[4][11]), .b(PP_S[5][8]), 																  .sum(layer_1_sum[9]),  .cout(layer_1_cout[9]) );
	compressor_4_to_2 L1_CP6  ( .X1(PP_S[0][24]),     .X2(PP_S[1][21]),    .X3(PP_S[2][18]),  .X4(PP_S[3][15]), .Tin(layer_1_t[4]), .S(layer_1_sum[10]),    .C(layer_1_cout[10]), .Tout(layer_1_t[5])  );
	half_adder 		  L1_HA6  ( .a(PP_S[4][12]), .b(PP_S[5][9]), 																  .sum(layer_1_sum[11]), .cout(layer_1_cout[11]) );

	compressor_4_to_2 L1_CP7  ( .X1(PP_S[0][25]),     .X2(PP_S[1][22]),    .X3(PP_S[2][19]),  .X4(PP_S[3][16]), .Tin(layer_1_t[5]), .S(layer_1_sum[12]),    .C(layer_1_cout[12]), .Tout(layer_1_t[6])  );
	full_adder 		  L1_FA1  ( .a(PP_S[4][13]), .b(PP_S[5][10]), .cin(PP_S[6][7]), 									          .sum(layer_1_sum[13]), .cout(layer_1_cout[13]) );
	compressor_4_to_2 L1_CP8  ( .X1(PP_S[0][26]),     .X2(PP_S[1][23]),    .X3(PP_S[2][20]),  .X4(PP_S[3][17]), .Tin(layer_1_t[6]), .S(layer_1_sum[14]),    .C(layer_1_cout[14]), .Tout(layer_1_t[7])  );
	full_adder 		  L1_FA2  ( .a(PP_S[4][14]), .b(PP_S[5][11]), .cin(PP_S[6][8]), 											  .sum(layer_1_sum[15]), .cout(layer_1_cout[15]) );	
	compressor_4_to_2 L1_CP9  ( .X1(PP_S[0][27]),     .X2(PP_S[1][24]),    .X3(PP_S[2][21]),  .X4(PP_S[3][18]), .Tin(layer_1_t[7]), .S(layer_1_sum[16]),    .C(layer_1_cout[16]), .Tout(layer_1_t[8])  );
	full_adder        L1_FA3  ( .a(PP_S[4][14]), .b(PP_S[5][12]), .cin(PP_S[6][9]), 											  .sum(layer_1_sum[17]), .cout(layer_1_cout[17]) );
	compressor_4_to_2 L1_CP10 ( .X1(PP_S[0][28]),     .X2(PP_S[1][25]),    .X3(PP_S[2][22]),  .X4(PP_S[3][19]), .Tin(layer_1_t[8]), .S(layer_1_sum[18]),    .C(layer_1_cout[18]), .Tout(layer_1_t[9])  );
	full_adder        L1_FA4  ( .a(PP_S[4][15]), .b(PP_S[5][13]), .cin(PP_S[6][10]), 											  .sum(layer_1_sum[19]), .cout(layer_1_cout[19]) );
	compressor_4_to_2 L1_CP11 ( .X1(PP_S[0][29]),     .X2(PP_S[1][26]),    .X3(PP_S[2][23]),  .X4(PP_S[3][20]), .Tin(layer_1_t[9]), .S(layer_1_sum[20]),    .C(layer_1_cout[20]), .Tout(layer_1_t[10]) );
	full_adder        L1_FA5  ( .a(PP_S[4][16]), .b(PP_S[5][14]), .cin(PP_S[6][11]),                                              .sum(layer_1_sum[21]), .cout(layer_1_cout[21]) );
	compressor_4_to_2 L1_CP12 ( .X1(PP_S[0][30]),     .X2(PP_S[1][27]),    .X3(PP_S[2][24]),  .X4(PP_S[3][21]), .Tin(layer_1_t[10]),.S(layer_1_sum[22]),    .C(layer_1_cout[22]), .Tout(layer_1_t[11])  );
	full_adder        L1_FA6  ( .a(PP_S[4][17]), .b(PP_S[5][15]), .cin(PP_S[6][12]), 		   								      .sum(layer_1_sum[23]), .cout(layer_1_cout[23]) );

	compressor_4_to_2 L1_CP13 ( .X1(PP_S[1][28]),     .X2(PP_S[2][25]),    .X3(PP_S[3][22]),  .X4(PP_S[4][19]), .Tin(layer_1_t[11]),.S(layer_1_sum[24]),    .C(layer_1_cout[24]), .Tout(layer_1_t[12])  );
	half_adder        L1_HA7  ( .a(PP_S[5][16]), .b(PP_S[6][13]),                                                                 .sum(layer_1_sum[25]), .cout(layer_1_cout[25]) );
	compressor_4_to_2 L1_CP14 ( .X1(PP_S[1][29]),     .X2(PP_S[2][26]),    .X3(PP_S[3][23]),  .X4(PP_S[4][20]), .Tin(layer_1_t[12]),.S(layer_1_sum[26]),    .C(layer_1_cout[26]), .Tout(layer_1_t[13])  );
	half_adder        L1_HA8  ( .a(PP_S[5][17]), .b(PP_S[6][14]), 																  .sum(layer_1_sum[27]), .cout(layer_1_cout[27]) );

	compressor_4_to_2 L1_CP15 ( .X1(PP_S[2][27]),     .X2(PP_S[3][24]),    .X3(PP_S[4][21]),  .X4(PP_S[5][18]), .Tin(layer_1_t[13]),.S(layer_1_sum[28]),    .C(layer_1_cout[28]), .Tout(layer_1_t[14])  );
	compressor_4_to_2 L1_CP16 ( .X1(PP_S[2][28]),     .X2(PP_S[3][25]),    .X3(PP_S[4][22]),  .X4(PP_S[5][19]), .Tin(layer_1_t[14]),.S(layer_1_sum[29]),    .C(layer_1_cout[29]), .Tout(layer_1_t[15])  );
	compressor_4_to_2 L1_CP17 ( .X1(PP_S[2][29]),     .X2(PP_S[3][26]),    .X3(PP_S[4][23]),  .X4(PP_S[5][20]), .Tin(layer_1_t[15]),.S(layer_1_sum[30]),    .C(layer_1_cout[30]), .Tout(layer_1_t[16])  );

	full_adder        L1_FA7  ( .a(layer_1_t[16]), .b(PP_S[3][27]), .cin(PP_S[4][24]), 		   								      .sum(layer_1_sum[31]), .cout(layer_1_cout[31]) );

	half_adder        L1_HA9  ( .a(PP_S[3][28]), .b(PP_S[4][25]), 																  .sum(layer_1_sum[32]), .cout(layer_1_cout[32]) );
	half_adder        L1_HA10 ( .a(PP_S[3][29]), .b(PP_S[4][26]), 																  .sum(layer_1_sum[33]), .cout(layer_1_cout[33]) );

// ******************************************* LAYER-2 *******************************************

	half_adder        L2_HA1  ( .a(PP_S[0][10]), .b(PP_S[1][7]), 																  .sum(layer_2_sum[0]),  .cout(layer_2_cout[0]) );
	half_adder        L2_HA2  ( .a(PP_S[0][11]), .b(PP_S[1][8]), 																  .sum(layer_2_sum[1]),  .cout(layer_2_cout[1]) );
	half_adder        L2_HA3  ( .a(PP_S[0][12]), .b(PP_S[1][9]), 																  .sum(layer_2_sum[2]),  .cout(layer_2_cout[2]) );

	compressor_4_to_2 L2_CP1  ( .X1(PP_S[0][13]),     .X2(PP_S[1][10]),    .X3(PP_S[2][7]),    .X4(PP_S[3][4]), .Tin(1'b0),           .S(layer_2_sum[3]),     .C(layer_2_cout[3]), .Tout(layer_2_t[0])  );
	compressor_4_to_2 L2_CP2  ( .X1(PP_S[0][14]),     .X2(PP_S[1][11]),    .X3(PP_S[2][8]),    .X4(PP_S[3][5]), .Tin(layer_2_t[0]),   .S(layer_2_sum[4]),     .C(layer_2_cout[4]), .Tout(layer_2_t[1])  );
	compressor_4_to_2 L2_CP3  ( .X1(PP_S[0][15]),     .X2(PP_S[1][12]),    .X3(PP_S[2][9]),    .X4(PP_S[3][6]), .Tin(layer_2_t[1]),   .S(layer_2_sum[5]),     .C(layer_2_cout[5]), .Tout(layer_2_t[2])  );
																							   
	compressor_4_to_2 L2_CP4  ( .X1(layer_1_sum[0]),  .X2(PP_S[2][10]),    .X3(PP_S[3][7]),    .X4(PP_S[4][4]), .Tin(layer_2_t[2]),   .S(layer_2_sum[6]),     .C(layer_2_cout[6]), .Tout(layer_2_t[3])  );
	compressor_4_to_2 L2_CP5  ( .X1(layer_1_cout[0]), .X2(layer_1_sum[1]), .X3(PP_S[2][11]),   .X4(PP_S[3][8]), .Tin(layer_2_t[3]),   .S(layer_2_sum[7]),     .C(layer_2_cout[7]), .Tout(layer_2_t[4])  );
	compressor_4_to_2 L2_CP6  ( .X1(layer_1_cout[1]), .X2(layer_1_sum[2]), .X3(PP_S[2][12]),   .X4(PP_S[3][9]), .Tin(layer_2_t[4]),   .S(layer_2_sum[8]),     .C(layer_2_cout[8]), .Tout(layer_2_t[5])  );
																							   
	compressor_4_to_2 L2_CP7  ( .X1(layer_1_cout[2]), .X2(layer_1_sum[3]), .X3(PP_S[4][7]),    .X4(PP_S[5][4]), .Tin(layer_2_t[5]),   .S(layer_2_sum[9]),     .C(layer_2_cout[9]), .Tout(layer_2_t[6])  );
	compressor_4_to_2 L2_CP8  ( .X1(layer_1_cout[3]), .X2(layer_1_sum[4]), .X3(PP_S[4][8]),    .X4(PP_S[5][5]), .Tin(layer_2_t[6]),   .S(layer_2_sum[10]),    .C(layer_2_cout[10]),.Tout(layer_2_t[7])  );
	compressor_4_to_2 L2_CP9  ( .X1(layer_1_cout[4]), .X2(layer_1_sum[5]), .X3(PP_S[4][9]),    .X4(PP_S[5][6]), .Tin(layer_2_t[7]),   .S(layer_2_sum[11]),    .C(layer_2_cout[11]),.Tout(layer_2_t[8])  );
	compressor_4_to_2 L2_CP10 ( .X1(layer_1_cout[5]), .X2(layer_1_sum[6]), .X3(layer_1_sum[7]),.X4(PP_S[6][4]), .Tin(layer_2_t[8]),   .S(layer_2_sum[12]),    .C(layer_2_cout[12]),.Tout(layer_2_t[9])  );

	compressor_4_to_2 L2_CP11 ( .X1(layer_1_cout[6]), .X2(layer_1_cout[7]), .X3(layer_1_sum[8]), .X4(layer_1_sum[9]),  .Tin(layer_2_t[9]),   .S(layer_2_sum[13]), .C(layer_2_cout[13]), .Tout(layer_2_t[10])  );
	compressor_4_to_2 L2_CP12 ( .X1(layer_1_cout[8]), .X2(layer_1_cout[9]), .X3(layer_1_sum[10]),.X4(layer_1_sum[11]), .Tin(layer_2_t[10]),  .S(layer_2_sum[14]), .C(layer_2_cout[14]), .Tout(layer_2_t[11])  );
	compressor_4_to_2 L2_CP13 ( .X1(layer_1_cout[10]),.X2(layer_1_cout[11]),.X3(layer_1_sum[12]),.X4(layer_1_sum[13]), .Tin(layer_2_t[11]),  .S(layer_2_sum[15]), .C(layer_2_cout[15]), .Tout(layer_2_t[12])  );
	compressor_4_to_2 L2_CP14 ( .X1(layer_1_cout[12]),.X2(layer_1_cout[13]),.X3(layer_1_sum[14]),.X4(layer_1_sum[15]), .Tin(layer_2_t[12]),  .S(layer_2_sum[16]), .C(layer_2_cout[16]), .Tout(layer_2_t[13])  );
	compressor_4_to_2 L2_CP15 ( .X1(layer_1_cout[14]),.X2(layer_1_cout[15]),.X3(layer_1_sum[16]),.X4(layer_1_sum[17]), .Tin(layer_2_t[13]),  .S(layer_2_sum[17]), .C(layer_2_cout[17]), .Tout(layer_2_t[14])  );
	compressor_4_to_2 L2_CP16 ( .X1(layer_1_cout[16]),.X2(layer_1_cout[17]),.X3(layer_1_sum[18]),.X4(layer_1_sum[19]), .Tin(layer_2_t[14]),  .S(layer_2_sum[18]), .C(layer_2_cout[18]), .Tout(layer_2_t[15])  );
	compressor_4_to_2 L2_CP17 ( .X1(layer_1_cout[18]),.X2(layer_1_cout[19]),.X3(layer_1_sum[20]),.X4(layer_1_sum[21]), .Tin(layer_2_t[15]),  .S(layer_2_sum[19]), .C(layer_2_cout[19]), .Tout(layer_2_t[16])  );
	compressor_4_to_2 L2_CP18 ( .X1(layer_1_cout[20]),.X2(layer_1_cout[21]),.X3(layer_1_sum[22]),.X4(layer_1_sum[23]), .Tin(layer_2_t[16]),  .S(layer_2_sum[20]), .C(layer_2_cout[20]), .Tout(layer_2_t[17])  );
	compressor_4_to_2 L2_CP19 ( .X1(layer_1_cout[22]),.X2(layer_1_cout[23]),.X3(layer_1_sum[24]),.X4(layer_1_sum[25]), .Tin(layer_2_t[17]),  .S(layer_2_sum[21]), .C(layer_2_cout[21]), .Tout(layer_2_t[18])  );
	compressor_4_to_2 L2_CP20 ( .X1(layer_1_cout[24]),.X2(layer_1_cout[25]),.X3(layer_1_sum[26]),.X4(layer_1_sum[27]), .Tin(layer_2_t[18]),  .S(layer_2_sum[22]), .C(layer_2_cout[22]), .Tout(layer_2_t[19])  );
	compressor_4_to_2 L2_CP21 ( .X1(layer_1_cout[26]),.X2(layer_1_cout[27]),.X3(layer_1_sum[28]),.X4(PP_S[6][15]),     .Tin(layer_2_t[19]),  .S(layer_2_sum[23]), .C(layer_2_cout[23]), .Tout(layer_2_t[20])  );

	compressor_4_to_2 L2_CP22 ( .X1(layer_1_cout[28]),.X2(layer_1_cout[29]),.X3(PP_S[6][16]),    .X4(PP_S[7][13]),     .Tin(layer_2_t[20]),  .S(layer_2_sum[24]), .C(layer_2_cout[24]), .Tout(layer_2_t[21])  );
	compressor_4_to_2 L2_CP23 ( .X1(layer_1_cout[29]),.X2(layer_1_cout[30]),.X3(PP_S[6][17]),    .X4(PP_S[7][14]),     .Tin(layer_2_t[21]),  .S(layer_2_sum[25]), .C(layer_2_cout[25]), .Tout(layer_2_t[22])  );

	compressor_4_to_2 L2_CP24 ( .X1(layer_1_cout[30]),.X2(layer_1_cout[31]),.X3(PP_S[5][21]),    .X4(PP_S[6][18]),     .Tin(layer_2_t[22]),  .S(layer_2_sum[26]), .C(layer_2_cout[26]), .Tout(layer_2_t[23])  );
	compressor_4_to_2 L2_CP25 ( .X1(layer_1_cout[31]),.X2(layer_1_cout[32]),.X3(PP_S[5][22]),    .X4(PP_S[6][19]),     .Tin(layer_2_t[23]),  .S(layer_2_sum[27]), .C(layer_2_cout[27]), .Tout(layer_2_t[24])  );
	compressor_4_to_2 L2_CP26 ( .X1(layer_1_cout[32]),.X2(layer_1_cout[33]),.X3(PP_S[5][23]),    .X4(PP_S[6][20]),     .Tin(layer_2_t[24]),  .S(layer_2_sum[28]), .C(layer_2_cout[28]), .Tout(layer_2_t[25])  );
	compressor_4_to_2 L2_CP27 ( .X1(layer_1_cout[33]),.X2(PP_S[4][27]),     .X3(PP_S[5][24]),    .X4(PP_S[6][21]),     .Tin(layer_2_t[25]),  .S(layer_2_sum[29]), .C(layer_2_cout[29]), .Tout(layer_2_t[26])  );

	compressor_4_to_2 L2_CP28 ( .X1(PP_S[4][28]),     .X2(PP_S[5][25]),     .X3(PP_S[6][22]),    .X4(PP_S[7][19]),     .Tin(layer_2_t[26]),  .S(layer_2_sum[30]), .C(layer_2_cout[30]), .Tout(layer_2_t[27])  );
	compressor_4_to_2 L2_CP29 ( .X1(PP_S[4][29]),     .X2(PP_S[5][26]),     .X3(PP_S[6][23]),    .X4(PP_S[7][20]),     .Tin(layer_2_t[27]),  .S(layer_2_sum[31]), .C(layer_2_cout[31]), .Tout(layer_2_t[28])  );

	full_adder        L2_FA1  ( .a(layer_2_t[28]), .b(PP_S[5][27]), .cin(PP_S[6][24]), 		   								      		   .sum(layer_2_sum[32]), .cout(layer_2_cout[32]) );
	half_adder        L2_HA4  ( .a(PP_S[5][28]), .b(PP_S[6][25]), 																           .sum(layer_2_sum[33]), .cout(layer_2_cout[33]) );
	half_adder        L2_HA5  ( .a(PP_S[5][29]), .b(PP_S[6][26]), 																           .sum(layer_2_sum[34]), .cout(layer_2_cout[34]) );

// ******************************************* LAYER-3 *******************************************

	half_adder        L3_HA1  ( .a(PP_S[0][7]), .b(PP_S[1][4]), 							.sum(layer_3_sum[0]), .cout(layer_3_cout[0]) );
	half_adder        L3_HA2  ( .a(PP_S[0][8]), .b(PP_S[1][5]), 							.sum(layer_3_sum[1]), .cout(layer_3_cout[1]) );
	half_adder        L3_HA3  ( .a(PP_S[0][9]), .b(PP_S[1][6]), 							.sum(layer_3_sum[2]), .cout(layer_3_cout[2]) );

	full_adder        L3_FA1  ( .a(layer_2_sum[0]),  .b(PP_S[2][24]),    .cin(PP_S[3][1]), 	.sum(layer_3_sum[3]), .cout(layer_3_cout[3]) );
	full_adder        L3_FA2  ( .a(layer_2_cout[0]), .b(layer_2_sum[1]), .cin(PP_S[2][5]), 	.sum(layer_3_sum[4]), .cout(layer_3_cout[4]) );
	full_adder        L3_FA3  ( .a(layer_2_cout[1]), .b(layer_2_sum[2]), .cin(PP_S[2][6]), 	.sum(layer_3_sum[5]), .cout(layer_3_cout[5]) );
	full_adder        L3_FA4  ( .a(layer_2_cout[2]), .b(layer_2_sum[3]), .cin(PP_S[4][1]), 	.sum(layer_3_sum[6]), .cout(layer_3_cout[6]) );

	half_adder        L3_HA4  ( .a(layer_2_cout[3]), .b(layer_2_sum[4]), 					.sum(layer_3_sum[7]), .cout(layer_3_cout[7]) );
	half_adder        L3_HA5  ( .a(layer_2_cout[4]), .b(layer_2_sum[5]), 					.sum(layer_3_sum[8]), .cout(layer_3_cout[8]) );

	full_adder        L3_FA5  ( .a(layer_2_cout[5]), .b(layer_2_sum[6]), .cin(PP_S[5][1]), 	.sum(layer_3_sum[9]), .cout(layer_3_cout[9]) );
	full_adder        L3_FA6  ( .a(layer_2_cout[6]), .b(layer_2_sum[7]), .cin(PP_S[4][5]), 	.sum(layer_3_sum[10]),.cout(layer_3_cout[10]) );
	full_adder        L3_FA7  ( .a(layer_2_cout[7]), .b(layer_2_sum[8]), .cin(PP_S[4][6]), 	.sum(layer_3_sum[11]),.cout(layer_3_cout[11]) );
	full_adder        L3_FA8  ( .a(layer_2_cout[8]), .b(layer_2_sum[9]), .cin(PP_S[6][1]), 	.sum(layer_3_sum[12]),.cout(layer_3_cout[12]) );

	half_adder        L3_HA6  ( .a(layer_2_cout[9]), .b(layer_2_sum[10]),					.sum(layer_3_sum[13]),.cout(layer_3_cout[13]) );
	half_adder        L3_HA7  ( .a(layer_2_cout[10]),.b(layer_2_sum[11]),					.sum(layer_3_sum[14]),.cout(layer_3_cout[14]) );

	full_adder        L3_FA9  ( .a(layer_2_cout[11]), .b(layer_2_sum[12]), .cin(PP_S[7][1]), 	.sum(layer_3_sum[15]),.cout(layer_3_cout[15]) );
	full_adder        L3_FA10 ( .a(layer_2_cout[12]), .b(layer_2_sum[13]), .cin(PP_S[6][5]), 	.sum(layer_3_sum[16]),.cout(layer_3_cout[16]) );
	full_adder        L3_FA11 ( .a(layer_2_cout[13]), .b(layer_2_sum[14]), .cin(PP_S[6][6]), 	.sum(layer_3_sum[17]),.cout(layer_3_cout[17]) );
	full_adder        L3_FA12 ( .a(layer_2_cout[14]), .b(layer_2_sum[15]), .cin(PP_S[7][4]), 	.sum(layer_3_sum[18]),.cout(layer_3_cout[18]) );
	full_adder        L3_FA13 ( .a(layer_2_cout[15]), .b(layer_2_sum[16]), .cin(PP_S[7][5]), 	.sum(layer_3_sum[19]),.cout(layer_3_cout[19]) );
	full_adder        L3_FA14 ( .a(layer_2_cout[16]), .b(layer_2_sum[17]), .cin(PP_S[7][6]), 	.sum(layer_3_sum[20]),.cout(layer_3_cout[20]) );
	full_adder        L3_FA15 ( .a(layer_2_cout[17]), .b(layer_2_sum[18]), .cin(PP_S[7][7]), 	.sum(layer_3_sum[21]),.cout(layer_3_cout[21]) );
	full_adder        L3_FA16 ( .a(layer_2_cout[18]), .b(layer_2_sum[19]), .cin(PP_S[7][8]), 	.sum(layer_3_sum[22]),.cout(layer_3_cout[22]) );
	full_adder        L3_FA17 ( .a(layer_2_cout[19]), .b(layer_2_sum[20]), .cin(PP_S[7][9]), 	.sum(layer_3_sum[23]),.cout(layer_3_cout[23]) );
	full_adder        L3_FA18 ( .a(layer_2_cout[20]), .b(layer_2_sum[21]), .cin(PP_S[7][10]), 	.sum(layer_3_sum[24]),.cout(layer_3_cout[24]) );
	full_adder        L3_FA19 ( .a(layer_2_cout[21]), .b(layer_2_sum[22]), .cin(PP_S[7][11]), 	.sum(layer_3_sum[25]),.cout(layer_3_cout[25]) );
	full_adder        L3_FA20 ( .a(layer_2_cout[22]), .b(layer_2_sum[23]), .cin(PP_S[7][11]), 	.sum(layer_3_sum[26]),.cout(layer_3_cout[26]) );

	half_adder        L3_HA8  ( .a(layer_2_cout[23]),.b(layer_2_sum[24]),					    .sum(layer_3_sum[27]),.cout(layer_3_cout[27]) );
	half_adder        L3_HA9  ( .a(layer_2_cout[24]),.b(layer_2_sum[25]),					    .sum(layer_3_sum[28]),.cout(layer_3_cout[28]) );

	full_adder        L3_FA21 ( .a(layer_2_cout[25]), .b(layer_2_sum[26]), .cin(PP_S[7][15]), 	.sum(layer_3_sum[29]),.cout(layer_3_cout[29]) );
	full_adder        L3_FA22 ( .a(layer_2_cout[26]), .b(layer_2_sum[27]), .cin(PP_S[7][16]), 	.sum(layer_3_sum[30]),.cout(layer_3_cout[30]) );
	full_adder        L3_FA23 ( .a(layer_2_cout[27]), .b(layer_2_sum[28]), .cin(PP_S[7][17]), 	.sum(layer_3_sum[31]),.cout(layer_3_cout[31]) );
	full_adder        L3_FA24 ( .a(layer_2_cout[28]), .b(layer_2_sum[29]), .cin(PP_S[7][18]), 	.sum(layer_3_sum[32]),.cout(layer_3_cout[32]) );

	half_adder        L3_HA10 ( .a(layer_2_cout[29]),.b(layer_2_sum[30]),					    .sum(layer_3_sum[33]),.cout(layer_3_cout[33]) );
	half_adder        L3_HA11  ( .a(layer_2_cout[30]),.b(layer_2_sum[31]),					    .sum(layer_3_sum[34]),.cout(layer_3_cout[34]) );

	full_adder        L3_FA25 ( .a(layer_2_cout[31]), .b(layer_2_sum[32]), .cin(PP_S[7][21]), 	.sum(layer_3_sum[35]),.cout(layer_3_cout[35]) );
	full_adder        L3_FA26 ( .a(layer_2_cout[32]), .b(layer_2_sum[33]), .cin(PP_S[7][22]), 	.sum(layer_3_sum[36]),.cout(layer_3_cout[36]) );
	full_adder        L3_FA27 ( .a(layer_2_cout[33]), .b(layer_2_sum[34]), .cin(PP_S[7][23]), 	.sum(layer_3_sum[37]),.cout(layer_3_cout[37]) );
	full_adder        L3_FA28 ( .a(layer_2_cout[34]), .b(PP_S[6][27]),     .cin(PP_S[7][24]), 	.sum(layer_3_sum[38]),.cout(layer_3_cout[38]) );

	half_adder        L3_HA12 ( .a(PP_S[6][28]),.b(PP_S[7][25]),	       					    .sum(layer_3_sum[39]),.cout(layer_3_cout[39]) );
	half_adder        L3_HA13 ( .a(PP_S[6][29]),.b(PP_S[7][26]),	       					    .sum(layer_3_sum[40]),.cout(layer_3_cout[40]) );


// ******************************************* LAYER-4 *******************************************

	half_adder    L4_HA1  ( .a(PP_S[0][4]),.b(PP_S[1][1]),	       					    .sum(layer_4_sum[0]), .cout(layer_4_cout[0]) );
	half_adder    L4_HA2  ( .a(PP_S[0][5]),.b(PP_S[1][2]),	       					    .sum(layer_4_sum[1]), .cout(layer_4_cout[1]) );
	half_adder    L4_HA3  ( .a(PP_S[0][6]),.b(PP_S[1][3]),	       					    .sum(layer_4_sum[2]), .cout(layer_4_cout[2]) );
																								  
	full_adder    L4_FA1  ( .a(layer_3_sum[0]),  .b(PP_S[2][1]),     .cin(PP_S[2][0]), 	.sum(layer_4_sum[3]), .cout(layer_4_cout[3]) );
	full_adder    L4_FA2  ( .a(layer_3_cout[0]), .b(layer_3_sum[1]), .cin(PP_S[2][2]), 	.sum(layer_4_sum[4]), .cout(layer_4_cout[4]) );
	full_adder    L4_FA3  ( .a(layer_3_cout[1]), .b(layer_3_sum[2]), .cin(PP_S[2][3]), 	.sum(layer_4_sum[5]), .cout(layer_4_cout[5]) );
																											  
	full_adder    L4_FA4  ( .a(layer_3_cout[2]), .b(layer_3_sum[3]), .cin(PP_S[3][0]), 	.sum(layer_4_sum[6]), .cout(layer_4_cout[6]) );
	full_adder    L4_FA5  ( .a(layer_3_cout[3]), .b(layer_3_sum[4]), .cin(PP_S[3][2]), 	.sum(layer_4_sum[7]), .cout(layer_4_cout[7]) );
	full_adder    L4_FA6  ( .a(layer_3_cout[4]), .b(layer_3_sum[5]), .cin(PP_S[3][3]), 	.sum(layer_4_sum[8]), .cout(layer_4_cout[8]) );
																											  
	full_adder    L4_FA7  ( .a(layer_3_cout[5]), .b(layer_3_sum[6]), .cin(PP_S[4][0]), 	.sum(layer_4_sum[9]), .cout(layer_4_cout[9]) );
	full_adder    L4_FA8  ( .a(layer_3_cout[6]), .b(layer_3_sum[7]), .cin(PP_S[4][2]), 	.sum(layer_4_sum[10]),.cout(layer_4_cout[10]) );
	full_adder    L4_FA9  ( .a(layer_3_cout[7]), .b(layer_3_sum[8]), .cin(PP_S[4][3]), 	.sum(layer_4_sum[11]),.cout(layer_4_cout[11]) );
																											  
	full_adder    L4_FA10 ( .a(layer_3_cout[8]), .b(layer_3_sum[9]), .cin(PP_S[5][0]), 	.sum(layer_4_sum[12]),.cout(layer_4_cout[12]) );
	full_adder    L4_FA11 ( .a(layer_3_cout[9]), .b(layer_3_sum[10]),.cin(PP_S[5][2]), 	.sum(layer_4_sum[13]),.cout(layer_4_cout[13]) );
	full_adder    L4_FA12 ( .a(layer_3_cout[10]),.b(layer_3_sum[11]),.cin(PP_S[5][3]), 	.sum(layer_4_sum[14]),.cout(layer_4_cout[14]) );
																											  
	full_adder    L4_FA13 ( .a(layer_3_cout[11]),.b(layer_3_sum[12]),.cin(PP_S[6][0]), 	.sum(layer_4_sum[15]),.cout(layer_4_cout[15]) );
	full_adder    L4_FA14 ( .a(layer_3_cout[12]),.b(layer_3_sum[13]),.cin(PP_S[6][2]), 	.sum(layer_4_sum[16]),.cout(layer_4_cout[16]) );
	full_adder    L4_FA15 ( .a(layer_3_cout[13]),.b(layer_3_sum[14]),.cin(PP_S[6][3]), 	.sum(layer_4_sum[17]),.cout(layer_4_cout[17]) );

	full_adder    L4_FA16 ( .a(layer_3_cout[14]),.b(layer_3_sum[15]),.cin(PP_S[7][0]), 	.sum(layer_4_sum[18]),.cout(layer_4_cout[18]) );
	full_adder    L4_FA17 ( .a(layer_3_cout[15]),.b(layer_3_sum[16]),.cin(PP_S[7][2]), 	.sum(layer_4_sum[19]),.cout(layer_4_cout[19]) );
	full_adder    L4_FA18 ( .a(layer_3_cout[16]),.b(layer_3_sum[17]),.cin(PP_S[7][3]), 	.sum(layer_4_sum[20]),.cout(layer_4_cout[20]) );
	generate
		for(i = 17; i < 40; i++) begin
			full_adder L4_FAx ( .a(layer_3_cout[i]), .b(layer_3_sum[i+1]), .cin(PP_S[8][i-16]), .sum(layer_4_sum[i+4]), .cout(layer_4_cout[i+4]) );
		end
	endgenerate
	full_adder    L4_FA19 ( .a(layer_3_cout[40]), .b(PP_S[7][27]), .cin(PP_S[8][24]), .sum(layer_4_sum[44]), .cout(layer_4_cout[44]) );

// ******************************************* LAYER-5 *******************************************
	half_adder    L5_HA1  ( .a(PP_S[0][1]),.b(PP_S[0][0]),        .sum(Product[0]), .cout(layer_5_cout[0]) );
	half_adder    L5_HA2  ( .a(PP_S[0][2]),.b(layer_5_cout[0]),   .sum(Product[1]), .cout(layer_5_cout[1]) );
	half_adder    L5_HA3  ( .a(PP_S[0][3]),.b(layer_5_cout[1]),   .sum(Product[2]), .cout(layer_5_cout[2]) );

	full_adder    L5_FA1  ( .a(layer_4_sum[0]),  .b(PP_S[1][0]),  .cin(layer_5_cout[2]), 	.sum(Product[3]), .cout(layer_5_cout[3]) );

	generate
		for( i = 0; i < 44; i++ ) begin
			full_adder    L4_FA1  ( .a(layer_4_cout[i]),  .b(layer_4_sum[i+1]),  .cin(layer_5_cout[i+3]), 	.sum(Product[i+4]), .cout(layer_5_cout[i+4]) );	
		end
	endgenerate

endmodule