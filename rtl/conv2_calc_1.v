 module conv2_calc_1(
	input clk,
  input rst_n,
  input valid_out_buf,
	input signed [11:0] data_out1_0, data_out1_1, data_out1_2, data_out1_3, data_out1_4,
	  data_out1_5, data_out1_6, data_out1_7, data_out1_8, data_out1_9,
	  data_out1_10, data_out1_11, data_out1_12, data_out1_13, data_out1_14,
	  data_out1_15, data_out1_16, data_out1_17, data_out1_18, data_out1_19,
	  data_out1_20, data_out1_21, data_out1_22, data_out1_23, data_out1_24,
	
	  data_out2_0, data_out2_1, data_out2_2, data_out2_3, data_out2_4,
	  data_out2_5, data_out2_6, data_out2_7, data_out2_8, data_out2_9,
	  data_out2_10, data_out2_11, data_out2_12, data_out2_13, data_out2_14,
	  data_out2_15, data_out2_16, data_out2_17, data_out2_18, data_out2_19,
	  data_out2_20, data_out2_21, data_out2_22, data_out2_23, data_out2_24,
	
	  data_out3_0, data_out3_1, data_out3_2, data_out3_3, data_out3_4,
	  data_out3_5, data_out3_6, data_out3_7, data_out3_8, data_out3_9,
	  data_out3_10, data_out3_11, data_out3_12, data_out3_13, data_out3_14,
	  data_out3_15, data_out3_16, data_out3_17, data_out3_18, data_out3_19,
	  data_out3_20, data_out3_21, data_out3_22, data_out3_23, data_out3_24,

	  output [13:0] conv_out_calc,
  	output valid_out_calc
);

wire signed [19:0] calc_out, calc_out_1, calc_out_2, calc_out_3;

reg signed [7:0] weight_1 [0:24];
reg signed [7:0] weight_2 [0:24];
reg signed [7:0] weight_3 [0:24];

// Stage 0
reg signed [19:0] mul_out1_0, mul_out1_1, mul_out1_2, mul_out1_3, mul_out1_4, 
                  mul_out1_5, mul_out1_6, mul_out1_7, mul_out1_8, mul_out1_9,
                  mul_out1_10, mul_out1_11, mul_out1_12, mul_out1_13, mul_out1_14,
                  mul_out1_15, mul_out1_16, mul_out1_17, mul_out1_18, mul_out1_19,
                  mul_out1_20, mul_out1_21, mul_out1_22, mul_out1_23, mul_out1_24;

reg signed [19:0] mul_out2_0, mul_out2_1, mul_out2_2, mul_out2_3, mul_out2_4, 
                  mul_out2_5, mul_out2_6, mul_out2_7, mul_out2_8, mul_out2_9,
                  mul_out2_10, mul_out2_11, mul_out2_12, mul_out2_13, mul_out2_14,
                  mul_out2_15, mul_out2_16, mul_out2_17, mul_out2_18, mul_out2_19,
                  mul_out2_20, mul_out2_21, mul_out2_22, mul_out2_23, mul_out2_24;

reg signed [19:0] mul_out3_0, mul_out3_1, mul_out3_2, mul_out3_3, mul_out3_4, 
                  mul_out3_5, mul_out3_6, mul_out3_7, mul_out3_8, mul_out3_9,
                  mul_out3_10, mul_out3_11, mul_out3_12, mul_out3_13, mul_out3_14,
                  mul_out3_15, mul_out3_16, mul_out3_17, mul_out3_18, mul_out3_19,
                  mul_out3_20, mul_out3_21, mul_out3_22, mul_out3_23, mul_out3_24;

// Stage 1
reg signed [19:0] st1_add1_0, st1_add1_1, st1_add1_2, st1_add1_3, st1_add1_4, 
                  st1_add1_5, st1_add1_6, st1_add1_7, st1_add1_8, st1_add1_9,
                  st1_add1_10, st1_add1_11;
                  
reg signed [19:0] st1_add2_0, st1_add2_1, st1_add2_2, st1_add2_3, st1_add2_4, 
                  st1_add2_5, st1_add2_6, st1_add2_7, st1_add2_8, st1_add2_9,
                  st1_add2_10, st1_add2_11;

reg signed [19:0] st1_add3_0, st1_add3_1, st1_add3_2, st1_add3_3, st1_add3_4, 
                  st1_add3_5, st1_add3_6, st1_add3_7, st1_add3_8, st1_add3_9,
                  st1_add3_10, st1_add3_11;

// Stage 2
reg signed [19:0] st2_add1_0, st2_add1_1, st2_add1_2, st2_add1_3, st2_add1_4, 
                  st2_add1_5;

reg signed [19:0] st2_add2_0, st2_add2_1, st2_add2_2, st2_add2_3, st2_add2_4, 
                  st2_add2_5;

reg signed [19:0] st2_add3_0, st2_add3_1, st2_add3_2, st2_add3_3, st2_add3_4, 
                  st2_add3_5;

// Stage 3
reg signed [19:0] st3_add1_0, st3_add1_1, st3_add1_2;
reg signed [19:0] st3_add2_0, st3_add2_1, st3_add2_2;
reg signed [19:0] st3_add3_0, st3_add3_1, st3_add3_2;

// Stage 4
reg signed [19:0] st4_add1_0;
reg signed [19:0] st4_add2_0;
reg signed [19:0] st4_add3_0;


reg st0_valid_out, st1_valid_out, st2_valid_out, st3_valid_out, st4_valid_out; 

initial begin
	$readmemh("conv2_weight_11.mem", weight_1);
	$readmemh("conv2_weight_12.mem", weight_2);
	$readmemh("conv2_weight_13.mem", weight_3);

end

always @(posedge clk) begin
    if (~rst_n) begin
        mul_out1_0 <= 0;
        mul_out1_1 <= 0;
        mul_out1_2 <= 0;
        mul_out1_3 <= 0;
        mul_out1_4 <= 0;
        mul_out1_5 <= 0;
        mul_out1_6 <= 0;
        mul_out1_7 <= 0;
        mul_out1_8 <= 0;
        mul_out1_9 <= 0;
        mul_out1_10 <= 0;
        mul_out1_11 <= 0;
        mul_out1_12 <= 0;
        mul_out1_13 <= 0;
        mul_out1_14 <= 0;
        mul_out1_15 <= 0;
        mul_out1_16 <= 0;
        mul_out1_17 <= 0;
        mul_out1_18 <= 0;
        mul_out1_19 <= 0;
        mul_out1_20 <= 0;
        mul_out1_21 <= 0;
        mul_out1_22 <= 0;
        mul_out1_23 <= 0;
        mul_out1_24 <= 0;
        
        mul_out2_0 <= 0;
        mul_out2_1 <= 0;
        mul_out2_2 <= 0;
        mul_out2_3 <= 0;
        mul_out2_4 <= 0;
        mul_out2_5 <= 0;
        mul_out2_6 <= 0;
        mul_out2_7 <= 0;
        mul_out2_8 <= 0;
        mul_out2_9 <= 0;
        mul_out2_10 <= 0;
        mul_out2_11 <= 0;
        mul_out2_12 <= 0;
        mul_out2_13 <= 0;
        mul_out2_14 <= 0;
        mul_out2_15 <= 0;
        mul_out2_16 <= 0;
        mul_out2_17 <= 0;
        mul_out2_18 <= 0;
        mul_out2_19 <= 0;
        mul_out2_20 <= 0;
        mul_out2_21 <= 0;
        mul_out2_22 <= 0;
        mul_out2_23 <= 0;
        mul_out2_24 <= 0;

        mul_out3_0 <= 0;
        mul_out3_1 <= 0;
        mul_out3_2 <= 0;
        mul_out3_3 <= 0;
        mul_out3_4 <= 0;
        mul_out3_5 <= 0;
        mul_out3_6 <= 0;
        mul_out3_7 <= 0;
        mul_out3_8 <= 0;
        mul_out3_9 <= 0;
        mul_out3_10 <= 0;
        mul_out3_11 <= 0;
        mul_out3_12 <= 0;
        mul_out3_13 <= 0;
        mul_out3_14 <= 0;
        mul_out3_15 <= 0;
        mul_out3_16 <= 0;
        mul_out3_17 <= 0;
        mul_out3_18 <= 0;
        mul_out3_19 <= 0;
        mul_out3_20 <= 0;
        mul_out3_21 <= 0;
        mul_out3_22 <= 0;
        mul_out3_23 <= 0;
        mul_out3_24 <= 0;
    end else begin
        mul_out1_0 <= data_out1_0*weight_1[0];
        mul_out1_1 <= data_out1_1*weight_1[1];
        mul_out1_2 <= data_out1_2*weight_1[2];
        mul_out1_3 <= data_out1_3*weight_1[3];
        mul_out1_4 <= data_out1_4*weight_1[4];
        mul_out1_5 <= data_out1_5*weight_1[5];
        mul_out1_6 <= data_out1_6*weight_1[6];
        mul_out1_7 <= data_out1_7*weight_1[7];
        mul_out1_8 <= data_out1_8*weight_1[8];
        mul_out1_9 <= data_out1_9*weight_1[9];
        mul_out1_10 <= data_out1_10*weight_1[10];
        mul_out1_11 <= data_out1_11*weight_1[11];
        mul_out1_12 <= data_out1_12*weight_1[12];
        mul_out1_13 <= data_out1_13*weight_1[13];
        mul_out1_14 <= data_out1_14*weight_1[14];
        mul_out1_15 <= data_out1_15*weight_1[15];
        mul_out1_16 <= data_out1_16*weight_1[16];
        mul_out1_17 <= data_out1_17*weight_1[17];
        mul_out1_18 <= data_out1_18*weight_1[18];
        mul_out1_19 <= data_out1_19*weight_1[19];
        mul_out1_20 <= data_out1_20*weight_1[20];
        mul_out1_21 <= data_out1_21*weight_1[21];
        mul_out1_22 <= data_out1_22*weight_1[22];
        mul_out1_23 <= data_out1_23*weight_1[23];
        mul_out1_24 <= data_out1_24*weight_1[24];

        mul_out2_0 <= data_out2_0*weight_2[0];
        mul_out2_1 <= data_out2_1*weight_2[1];
        mul_out2_2 <= data_out2_2*weight_2[2];
        mul_out2_3 <= data_out2_3*weight_2[3];
        mul_out2_4 <= data_out2_4*weight_2[4];
        mul_out2_5 <= data_out2_5*weight_2[5];
        mul_out2_6 <= data_out2_6*weight_2[6];
        mul_out2_7 <= data_out2_7*weight_2[7];
        mul_out2_8 <= data_out2_8*weight_2[8];
        mul_out2_9 <= data_out2_9*weight_2[9];
        mul_out2_10 <= data_out2_10*weight_2[10];
        mul_out2_11 <= data_out2_11*weight_2[11];
        mul_out2_12 <= data_out2_12*weight_2[12];
        mul_out2_13 <= data_out2_13*weight_2[13];
        mul_out2_14 <= data_out2_14*weight_2[14];
        mul_out2_15 <= data_out2_15*weight_2[15];
        mul_out2_16 <= data_out2_16*weight_2[16];
        mul_out2_17 <= data_out2_17*weight_2[17];
        mul_out2_18 <= data_out2_18*weight_2[18];
        mul_out2_19 <= data_out2_19*weight_2[19];
        mul_out2_20 <= data_out2_20*weight_2[20];
        mul_out2_21 <= data_out2_21*weight_2[21];
        mul_out2_22 <= data_out2_22*weight_2[22];
        mul_out2_23 <= data_out2_23*weight_2[23];
        mul_out2_24 <= data_out2_24*weight_2[24];
        
        mul_out3_0 <= data_out3_0*weight_3[0];
        mul_out3_1 <= data_out3_1*weight_3[1];
        mul_out3_2 <= data_out3_2*weight_3[2];
        mul_out3_3 <= data_out3_3*weight_3[3];
        mul_out3_4 <= data_out3_4*weight_3[4];
        mul_out3_5 <= data_out3_5*weight_3[5];
        mul_out3_6 <= data_out3_6*weight_3[6];
        mul_out3_7 <= data_out3_7*weight_3[7];
        mul_out3_8 <= data_out3_8*weight_3[8];
        mul_out3_9 <= data_out3_9*weight_3[9];
        mul_out3_10 <= data_out3_10*weight_3[10];
        mul_out3_11 <= data_out3_11*weight_3[11];
        mul_out3_12 <= data_out3_12*weight_3[12];
        mul_out3_13 <= data_out3_13*weight_3[13];
        mul_out3_14 <= data_out3_14*weight_3[14];
        mul_out3_15 <= data_out3_15*weight_3[15];
        mul_out3_16 <= data_out3_16*weight_3[16];
        mul_out3_17 <= data_out3_17*weight_3[17];
        mul_out3_18 <= data_out3_18*weight_3[18];
        mul_out3_19 <= data_out3_19*weight_3[19];
        mul_out3_20 <= data_out3_20*weight_3[20];
        mul_out3_21 <= data_out3_21*weight_3[21];
        mul_out3_22 <= data_out3_22*weight_3[22];
        mul_out3_23 <= data_out3_23*weight_3[23];
        mul_out3_24 <= data_out3_24*weight_3[24];
    end
end

// Stage 1
always @(posedge clk) begin
    if (~rst_n) begin
        st1_add1_0 <= 0;
        st1_add1_1 <= 0;
        st1_add1_2 <= 0;
        st1_add1_3 <= 0;
        st1_add1_4 <= 0;
        st1_add1_5 <= 0;
        st1_add1_6 <= 0;
        st1_add1_7 <= 0;
        st1_add1_8 <= 0;
        st1_add1_9 <= 0;
        st1_add1_10 <= 0;
        st1_add1_11 <= 0;
        
        st1_add2_0 <= 0;
        st1_add2_1 <= 0;
        st1_add2_2 <= 0;
        st1_add2_3 <= 0;
        st1_add2_4 <= 0;
        st1_add2_5 <= 0;
        st1_add2_6 <= 0;
        st1_add2_7 <= 0;
        st1_add2_8 <= 0;
        st1_add2_9 <= 0;
        st1_add2_10 <= 0;
        st1_add2_11 <= 0;

        st1_add3_0 <= 0;
        st1_add3_1 <= 0;
        st1_add3_2 <= 0;
        st1_add3_3 <= 0;
        st1_add3_4 <= 0;
        st1_add3_5 <= 0;
        st1_add3_6 <= 0;
        st1_add3_7 <= 0;
        st1_add3_8 <= 0;
        st1_add3_9 <= 0;
        st1_add3_10 <= 0;
        st1_add3_11 <= 0;
    end else begin 
        st1_add1_0 <= mul_out1_0 + mul_out1_1;
        st1_add1_1 <= mul_out1_2 + mul_out1_3;
        st1_add1_2 <= mul_out1_4 + mul_out1_5;
        st1_add1_3 <= mul_out1_6 + mul_out1_7;
        st1_add1_4 <= mul_out1_8 + mul_out1_9;
        st1_add1_5 <= mul_out1_10 + mul_out1_11;
        st1_add1_6 <= mul_out1_12 + mul_out1_13;
        st1_add1_7 <= mul_out1_14 + mul_out1_15;
        st1_add1_8 <= mul_out1_16 + mul_out1_17;
        st1_add1_9 <= mul_out1_18 + mul_out1_19;
        st1_add1_10 <= mul_out1_20 + mul_out1_21;
        st1_add1_11 <= mul_out1_22 + mul_out1_23 + mul_out1_24;
        
        st1_add2_0 <= mul_out2_0 + mul_out2_1;
        st1_add2_1 <= mul_out2_2 + mul_out2_3;
        st1_add2_2 <= mul_out2_4 + mul_out2_5;
        st1_add2_3 <= mul_out2_6 + mul_out2_7;
        st1_add2_4 <= mul_out2_8 + mul_out2_9;
        st1_add2_5 <= mul_out2_10 + mul_out2_11;
        st1_add2_6 <= mul_out2_12 + mul_out2_13;
        st1_add2_7 <= mul_out2_14 + mul_out2_15;
        st1_add2_8 <= mul_out2_16 + mul_out2_17;
        st1_add2_9 <= mul_out2_18 + mul_out2_19;
        st1_add2_10 <= mul_out2_20 + mul_out2_21;
        st1_add2_11 <= mul_out2_22 + mul_out2_23 + mul_out2_24;

        st1_add3_0 <= mul_out3_0 + mul_out3_1;
        st1_add3_1 <= mul_out3_2 + mul_out3_3;
        st1_add3_2 <= mul_out3_4 + mul_out3_5;
        st1_add3_3 <= mul_out3_6 + mul_out3_7;
        st1_add3_4 <= mul_out3_8 + mul_out3_9;
        st1_add3_5 <= mul_out3_10 + mul_out3_11;
        st1_add3_6 <= mul_out3_12 + mul_out3_13;
        st1_add3_7 <= mul_out3_14 + mul_out3_15;
        st1_add3_8 <= mul_out3_16 + mul_out3_17;
        st1_add3_9 <= mul_out3_18 + mul_out3_19;
        st1_add3_10 <= mul_out3_20 + mul_out3_21;
        st1_add3_11 <= mul_out3_22 + mul_out3_23 + mul_out3_24;
    end
end

// Stage 2
always @(posedge clk) begin
    if (~rst_n) begin
        st2_add1_0 <= 0;
        st2_add1_1 <= 0;
        st2_add1_2 <= 0;
        st2_add1_3 <= 0;
        st2_add1_4 <= 0;
        st2_add1_5 <= 0;

        st2_add2_0 <= 0;
        st2_add2_1 <= 0;
        st2_add2_2 <= 0;
        st2_add2_3 <= 0;
        st2_add2_4 <= 0;
        st2_add2_5 <= 0;

        st2_add3_0 <= 0;
        st2_add3_1 <= 0;
        st2_add3_2 <= 0;
        st2_add3_3 <= 0;
        st2_add3_4 <= 0;
        st2_add3_5 <= 0;
    end else begin
        st2_add1_0 <= st1_add1_0 + st1_add1_1;
        st2_add1_1 <= st1_add1_2 + st1_add1_3;
        st2_add1_2 <= st1_add1_4 + st1_add1_5;
        st2_add1_3 <= st1_add1_6 + st1_add1_7;
        st2_add1_4 <= st1_add1_8 + st1_add1_9;
        st2_add1_5 <= st1_add1_10 + st1_add1_11;
        
        st2_add2_0 <= st1_add2_0 + st1_add2_1;
        st2_add2_1 <= st1_add2_2 + st1_add2_3;
        st2_add2_2 <= st1_add2_4 + st1_add2_5;
        st2_add2_3 <= st1_add2_6 + st1_add2_7;
        st2_add2_4 <= st1_add2_8 + st1_add2_9;
        st2_add2_5 <= st1_add2_10 + st1_add2_11;

        st2_add3_0 <= st1_add3_0 + st1_add3_1;
        st2_add3_1 <= st1_add3_2 + st1_add3_3;
        st2_add3_2 <= st1_add3_4 + st1_add3_5;
        st2_add3_3 <= st1_add3_6 + st1_add3_7;
        st2_add3_4 <= st1_add3_8 + st1_add3_9;
        st2_add3_5 <= st1_add3_10 + st1_add3_11;
    end
end

// Stage 3
always @(posedge clk) begin
    if (~rst_n) begin
        st3_add1_0 <= 0;
        st3_add1_1 <= 0;
        st3_add1_2 <= 0;
        
        st3_add2_0 <= 0;
        st3_add2_1 <= 0;
        st3_add2_2 <= 0;

        st3_add3_0 <= 0;
        st3_add3_1 <= 0;
        st3_add3_2 <= 0;
    end else begin
        st3_add1_0 <= st2_add1_0 + st2_add1_1;
        st3_add1_1 <= st2_add1_2 + st2_add1_3;
        st3_add1_2 <= st2_add1_4 + st2_add1_5;

        st3_add2_0 <= st2_add2_0 + st2_add2_1;
        st3_add2_1 <= st2_add2_2 + st2_add2_3;
        st3_add2_2 <= st2_add2_4 + st2_add2_5;

        st3_add3_0 <= st2_add3_0 + st2_add3_1;
        st3_add3_1 <= st2_add3_2 + st2_add3_3;
        st3_add3_2 <= st2_add3_4 + st2_add3_5;
    end
end

// Stage 4
always @(posedge clk) begin
    if (~rst_n) begin
        st4_add1_0 <= 0;
        st4_add2_0 <= 0;
        st4_add3_0 <= 0;
    end else begin
        st4_add1_0 <= st3_add1_0 + st3_add1_1 + st3_add1_2;
        st4_add2_0 <= st3_add2_0 + st3_add2_1 + st3_add2_2;
        st4_add3_0 <= st3_add3_0 + st3_add3_1 + st3_add3_2;
    end
end

assign calc_out_1 = st4_add1_0;
assign calc_out_2 = st4_add2_0;
assign calc_out_3 = st4_add3_0;

assign calc_out = calc_out_1 + calc_out_2 + calc_out_3;

assign conv_out_calc = calc_out[19:6]; // 14bit

always @ (posedge clk) begin
	if(~rst_n) begin
		st0_valid_out <= 0;
	end
	else begin
		// Toggling Valid Output Signal
		if(valid_out_buf == 1) begin
			if(st0_valid_out == 1)
				st0_valid_out <= 0;
			else
				st0_valid_out <= 1;
		end
	end
end

always @(posedge clk) begin
    if (~rst_n)
    begin 
        st1_valid_out <= 0;
        st2_valid_out <= 0;
        st3_valid_out <= 0;
        st4_valid_out <= 0;
    end else begin
        st1_valid_out <= st0_valid_out;
        st2_valid_out <= st1_valid_out;
        st3_valid_out <= st2_valid_out;
        st4_valid_out <= st3_valid_out;
    end    
end
    assign valid_out_calc = st4_valid_out; 

    
endmodule
