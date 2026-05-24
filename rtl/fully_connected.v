module fully_connected
    #(
        parameter INPUT_NUM = 48,
                  OUTPUT_NUM = 10,
                  DATA_BITS = 8
    )
    (
        input  wire               clk,
        input  wire               rst_n,
        input  wire               valid_in,
        input  wire signed [11:0] data_in_1, data_in_2, data_in_3,
        output wire [11:0]        data_out,
        output wire               valid_out_fc
    );

    localparam INPUT_WIDTH = 16;
    localparam INPUT_NUM_DATA_BITS = 5;

    reg                   state;
    reg [INPUT_WIDTH-1:0] buf_idx;
    reg [3:0]             out_idx;

    reg signed [13:0]          buffer [0:INPUT_NUM-1];
    reg signed [DATA_BITS-1:0] weight [0:INPUT_NUM*OUTPUT_NUM-1];
    reg signed [DATA_BITS-1:0] bias   [0:OUTPUT_NUM-1];

    wire signed [19:0] st0_mul_0, st0_mul_1, st0_mul_2, st0_mul_3, st0_mul_4,
                      st0_mul_5, st0_mul_6, st0_mul_7, st0_mul_8, st0_mul_9,
                      st0_mul_10, st0_mul_11, st0_mul_12, st0_mul_13, st0_mul_14,
                      st0_mul_15, st0_mul_16, st0_mul_17, st0_mul_18, st0_mul_19,
                      st0_mul_20, st0_mul_21, st0_mul_22, st0_mul_23, st0_mul_24,
                      st0_mul_25, st0_mul_26, st0_mul_27, st0_mul_28, st0_mul_29,
                      st0_mul_30, st0_mul_31, st0_mul_32, st0_mul_33, st0_mul_34,
                      st0_mul_35, st0_mul_36, st0_mul_37, st0_mul_38, st0_mul_39,
                      st0_mul_40, st0_mul_41, st0_mul_42, st0_mul_43, st0_mul_44,
                      st0_mul_45, st0_mul_46, st0_mul_47, st0_mul_48;

    reg signed [19:0] st1_add_0, st1_add_1, st1_add_2, st1_add_3, st1_add_4,
                      st1_add_5, st1_add_6, st1_add_7, st1_add_8, st1_add_9,
                      st1_add_10, st1_add_11, st1_add_12, st1_add_13, st1_add_14,
                      st1_add_15, st1_add_16, st1_add_17, st1_add_18, st1_add_19,
                      st1_add_20, st1_add_21, st1_add_22, st1_add_23, st1_add_24;

    reg signed [19:0] st2_add_0, st2_add_1, st2_add_2, st2_add_3, st2_add_4,
                      st2_add_5, st2_add_6, st2_add_7, st2_add_8, st2_add_9,
                      st2_add_10, st2_add_11, st2_add_12;

    reg signed [19:0] st3_add_0, st3_add_1, st3_add_2, st3_add_3, st3_add_4,
                      st3_add_5, st3_add_6;

    reg signed [19:0] st4_add_0, st4_add_1, st4_add_2;

    reg signed [19:0] st5_add_0;

    wire signed [19:0] calc_out;
    wire signed [13:0] data1, data2, data3;

    reg valid_out_fc_tmp0, valid_out_fc_tmp1, valid_out_fc_tmp2, valid_out_fc_tmp3,
        valid_out_fc_tmp4, valid_out_fc_tmp5;

    initial
    begin
        $readmemh("fc_weight.mem", weight);
        $readmemh("fc_bias.mem", bias);
    end

    assign data1 = (data_in_1[11] == 1) ? {2'b11, data_in_1} : {2'b00, data_in_1};
    assign data2 = (data_in_2[11] == 1) ? {2'b11, data_in_2} : {2'b00, data_in_2};
    assign data3 = (data_in_3[11] == 1) ? {2'b11, data_in_3} : {2'b00, data_in_3};

    integer i;

    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            for (i=0; i <= INPUT_NUM-1; i=i+1)
            begin
                buffer[i] <= 0;
            end
            valid_out_fc_tmp0 <= 0;
            buf_idx <= 0;
            out_idx <= 0;
            state <= 0;
        end
        else
        begin
            if (valid_out_fc_tmp0 == 1)
            begin
                valid_out_fc_tmp0 <= 0;
            end

            if (valid_in == 1)
            begin
                // Wait until 48 input data filled in buffer
                if (!state)
                begin
                    buffer[buf_idx] <= data1;
                    buffer[INPUT_WIDTH + buf_idx] <= data2;
                    buffer[INPUT_WIDTH * 2 + buf_idx] <= data3;
                    buf_idx <= buf_idx + 1'b1;
                    if (buf_idx == INPUT_WIDTH-1)
                    begin
                        buf_idx <= 0;
                        state <= 1;
                        valid_out_fc_tmp0 <= 1;
                    end
                end
                else
                begin // valid state
                    out_idx <= out_idx + 1'b1;
                    if (out_idx == OUTPUT_NUM-1)
                    begin
                        out_idx <= 0;
                    end
                    valid_out_fc_tmp0 <= 1;
                end
            end
        end
    end

            assign st0_mul_0 = weight[out_idx * INPUT_NUM] * buffer[0]; 
            assign st0_mul_1 = weight[out_idx * INPUT_NUM + 1] * buffer[1];
            assign st0_mul_2 = weight[out_idx * INPUT_NUM + 2] * buffer[2]; 
            assign st0_mul_3 = weight[out_idx * INPUT_NUM + 3] * buffer[3];
            assign st0_mul_4 = weight[out_idx * INPUT_NUM + 4] * buffer[4]; 
            assign st0_mul_5 = weight[out_idx * INPUT_NUM + 5] * buffer[5];
            assign st0_mul_6 = weight[out_idx * INPUT_NUM + 6] * buffer[6]; 
            assign st0_mul_7 = weight[out_idx * INPUT_NUM + 7] * buffer[7];
            assign st0_mul_8 = weight[out_idx * INPUT_NUM + 8] * buffer[8]; 
            assign st0_mul_9 = weight[out_idx * INPUT_NUM + 9] * buffer[9];
            assign st0_mul_10 = weight[out_idx * INPUT_NUM + 10] * buffer[10]; 
            assign st0_mul_11 = weight[out_idx * INPUT_NUM + 11] * buffer[11];
            assign st0_mul_12 = weight[out_idx * INPUT_NUM + 12] * buffer[12]; 
            assign st0_mul_13 = weight[out_idx * INPUT_NUM + 13] * buffer[13];
            assign st0_mul_14 = weight[out_idx * INPUT_NUM + 14] * buffer[14]; 
            assign st0_mul_15 = weight[out_idx * INPUT_NUM + 15] * buffer[15];
            assign st0_mul_16 = weight[out_idx * INPUT_NUM + 16] * buffer[16]; 
            assign st0_mul_17 = weight[out_idx * INPUT_NUM + 17] * buffer[17];
            assign st0_mul_18 = weight[out_idx * INPUT_NUM + 18] * buffer[18]; 
            assign st0_mul_19 = weight[out_idx * INPUT_NUM + 19] * buffer[19];
            assign st0_mul_20 = weight[out_idx * INPUT_NUM + 20] * buffer[20]; 
            assign st0_mul_21 = weight[out_idx * INPUT_NUM + 21] * buffer[21];
            assign st0_mul_22 = weight[out_idx * INPUT_NUM + 22] * buffer[22]; 
            assign st0_mul_23 = weight[out_idx * INPUT_NUM + 23] * buffer[23];
            assign st0_mul_24 = weight[out_idx * INPUT_NUM + 24] * buffer[24]; 
            assign st0_mul_25 = weight[out_idx * INPUT_NUM + 25] * buffer[25];
            assign st0_mul_26 = weight[out_idx * INPUT_NUM + 26] * buffer[26]; 
            assign st0_mul_27 = weight[out_idx * INPUT_NUM + 27] * buffer[27];
            assign st0_mul_28 = weight[out_idx * INPUT_NUM + 28] * buffer[28]; 
            assign st0_mul_29 = weight[out_idx * INPUT_NUM + 29] * buffer[29];
            assign st0_mul_30 = weight[out_idx * INPUT_NUM + 30] * buffer[30]; 
            assign st0_mul_31 = weight[out_idx * INPUT_NUM + 31] * buffer[31];
            assign st0_mul_32 = weight[out_idx * INPUT_NUM + 32] * buffer[32]; 
            assign st0_mul_33 = weight[out_idx * INPUT_NUM + 33] * buffer[33];
            assign st0_mul_34 = weight[out_idx * INPUT_NUM + 34] * buffer[34]; 
            assign st0_mul_35 = weight[out_idx * INPUT_NUM + 35] * buffer[35];
            assign st0_mul_36 = weight[out_idx * INPUT_NUM + 36] * buffer[36]; 
            assign st0_mul_37 = weight[out_idx * INPUT_NUM + 37] * buffer[37];
            assign st0_mul_38 = weight[out_idx * INPUT_NUM + 38] * buffer[38]; 
            assign st0_mul_39 = weight[out_idx * INPUT_NUM + 39] * buffer[39];
            assign st0_mul_40 = weight[out_idx * INPUT_NUM + 40] * buffer[40]; 
            assign st0_mul_41 = weight[out_idx * INPUT_NUM + 41] * buffer[41];
            assign st0_mul_42 = weight[out_idx * INPUT_NUM + 42] * buffer[42]; 
            assign st0_mul_43 = weight[out_idx * INPUT_NUM + 43] * buffer[43];
            assign st0_mul_44 = weight[out_idx * INPUT_NUM + 44] * buffer[44]; 
            assign st0_mul_45 = weight[out_idx * INPUT_NUM + 45] * buffer[45];
            assign st0_mul_46 = weight[out_idx * INPUT_NUM + 46] * buffer[46]; 
            assign st0_mul_47 = weight[out_idx * INPUT_NUM + 47] * buffer[47];
            assign st0_mul_48 = bias[out_idx];

    always @(posedge clk) begin
        if (~rst_n) begin
            st1_add_0 <= 0;
            st1_add_1 <= 0;
            st1_add_2 <= 0;
            st1_add_3 <= 0;
            st1_add_4 <= 0;
            st1_add_5 <= 0;
            st1_add_6 <= 0;
            st1_add_7 <= 0;
            st1_add_8 <= 0;
            st1_add_9 <= 0;
            st1_add_10 <= 0;
            st1_add_11 <= 0;
            st1_add_12 <= 0;
            st1_add_13 <= 0;
            st1_add_14 <= 0;
            st1_add_15 <= 0;
            st1_add_16 <= 0;
            st1_add_17 <= 0; 
            st1_add_18 <= 0; 
            st1_add_19 <= 0;
            st1_add_20 <= 0; 
            st1_add_21 <= 0; 
            st1_add_22 <= 0; 
            st1_add_23 <= 0;
            st1_add_24 <= 0;
        end else begin
            st1_add_0 <= st0_mul_0 + st0_mul_1;
            st1_add_1 <= st0_mul_2 + st0_mul_3;
            st1_add_2 <= st0_mul_4 + st0_mul_5;
            st1_add_3 <= st0_mul_6 + st0_mul_7;
            st1_add_4 <= st0_mul_8 + st0_mul_9;
            st1_add_5 <= st0_mul_10 + st0_mul_11;
            st1_add_6 <= st0_mul_12 + st0_mul_13;
            st1_add_7 <= st0_mul_14 + st0_mul_15;
            st1_add_8 <= st0_mul_16 + st0_mul_17;
            st1_add_9 <= st0_mul_18 + st0_mul_19;
            st1_add_10 <= st0_mul_20 + st0_mul_21;
            st1_add_11 <= st0_mul_22 + st0_mul_23;
            st1_add_12 <= st0_mul_24 + st0_mul_25;
            st1_add_13 <= st0_mul_26 + st0_mul_27;
            st1_add_14 <= st0_mul_28 + st0_mul_29;
            st1_add_15 <= st0_mul_30 + st0_mul_31;
            st1_add_16 <= st0_mul_32 + st0_mul_33;
            st1_add_17 <= st0_mul_34 + st0_mul_35; 
            st1_add_18 <= st0_mul_36 + st0_mul_37; 
            st1_add_19 <= st0_mul_38 + st0_mul_39;
            st1_add_20 <= st0_mul_40 + st0_mul_41; 
            st1_add_21 <= st0_mul_42 + st0_mul_43; 
            st1_add_22 <= st0_mul_44 + st0_mul_45; 
            st1_add_23 <= st0_mul_46 + st0_mul_47;
            st1_add_24 <= st0_mul_48; 
        end
    end

    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            st2_add_0 <= 0;
            st2_add_1 <= 0;
            st2_add_2 <= 0;
            st2_add_3 <= 0;
            st2_add_4 <= 0;
            st2_add_5 <= 0;
            st2_add_6 <= 0;
            st2_add_7 <= 0;
            st2_add_8 <= 0;
            st2_add_9 <= 0;
            st2_add_10 <= 0;
            st2_add_11 <= 0;
            st2_add_12 <= 0;
        end
        else
        begin
            st2_add_0 <= st1_add_0 + st1_add_1;
            st2_add_1 <= st1_add_2 + st1_add_3;
            st2_add_2 <= st1_add_4 + st1_add_5;
            st2_add_3 <= st1_add_6 + st1_add_7;
            st2_add_4 <= st1_add_8 + st1_add_9;
            st2_add_5 <= st1_add_10 + st1_add_11;
            st2_add_6 <= st1_add_12 + st1_add_13;
            st2_add_7 <= st1_add_14 + st1_add_15;
            st2_add_8 <= st1_add_16 + st1_add_17;
            st2_add_9 <= st1_add_18 + st1_add_19;
            st2_add_10 <= st1_add_20 + st1_add_21;
            st2_add_11 <= st1_add_22 + st1_add_23;
            st2_add_12 <= st1_add_24;
        end
    end
    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            st3_add_0 <= 0;
            st3_add_1 <= 0;
            st3_add_2 <= 0;
            st3_add_3 <= 0;
            st3_add_4 <= 0;
            st3_add_5 <= 0;
            st3_add_6 <= 0;
        end
        else
        begin
            st3_add_0 <= st2_add_0 + st2_add_1;
            st3_add_1 <= st2_add_2 + st2_add_3;
            st3_add_2 <= st2_add_4 + st2_add_5;
            st3_add_3 <= st2_add_6 + st2_add_7;
            st3_add_4 <= st2_add_8 + st2_add_9;
            st3_add_5 <= st2_add_10 + st2_add_11;
            st3_add_6 <= st2_add_12;
        end
    end
    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            st4_add_0 <= 0;
            st4_add_1 <= 0;
            st4_add_2 <= 0;
        end
        else
        begin
            st4_add_0 <= st3_add_0 + st3_add_1;
            st4_add_1 <= st3_add_2 + st3_add_3;
            st4_add_2 <= st3_add_4 + st3_add_5 + st3_add_6;
        end
    end
    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            st5_add_0 <= 0;
        end
        else
        begin
            st5_add_0 <= st4_add_0 + st4_add_1 + st4_add_2;
        end
    end

    assign calc_out = st5_add_0;
    assign data_out = calc_out[18:7];

    always @(posedge clk)
    begin
        if (~rst_n)
        begin
            valid_out_fc_tmp1 <= 0;
            valid_out_fc_tmp2 <= 0;
            valid_out_fc_tmp3 <= 0;
            valid_out_fc_tmp4 <= 0;
            valid_out_fc_tmp5 <= 0;
        end
        else
        begin
            valid_out_fc_tmp1 <= valid_out_fc_tmp0;
            valid_out_fc_tmp2 <= valid_out_fc_tmp1;
            valid_out_fc_tmp3 <= valid_out_fc_tmp2;
            valid_out_fc_tmp4 <= valid_out_fc_tmp3;
            valid_out_fc_tmp5 <= valid_out_fc_tmp4;
        end
    end

    assign valid_out_fc = valid_out_fc_tmp5;

endmodule

