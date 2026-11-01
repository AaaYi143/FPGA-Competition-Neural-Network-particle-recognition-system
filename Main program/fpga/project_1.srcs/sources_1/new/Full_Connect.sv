`timescale 1ns / 1ps
/*
module Full_connect #(
    parameter BIT_WIDTH    = 8,
    parameter IN_FEATURES  = 784,
    parameter OUT_FEATURES = 64
)(
    input  wire clk,
    input  wire rst_n,
    input  wire en,                  // 鍚姩鑴夊啿

    // 涓茶杈撳叆锛氭瘡鎷?1涓壒寰?
    input  wire signed [BIT_WIDTH-1:0] din,

    // 鎵?鏈夌缁忓厓骞惰杈撳嚭
    output reg signed [2*BIT_WIDTH + $clog2(IN_FEATURES) + 1 - 1 : 0]  dout [0:OUT_FEATURES-1] ,
    output reg  done,
    output wire overflow
);

localparam PROD_WIDTH = 2 * BIT_WIDTH;
localparam SUM_EXTRA1   = $clog2(IN_FEATURES) + 1;
localparam SUM_WIDTH  = PROD_WIDTH + SUM_EXTRA1;   // 瓒冲瀹斤紝闃叉孩鍑?

// 鏉冮噸 & 鍋忕疆锛堢洿鎺nclude锛?

`include "weights.vh"


/////////////////////////////////////////////////
wire signed [BIT_WIDTH-1:0] weight [0:OUT_FEATURES-1][0:IN_FEATURES-1];
wire signed [PROD_WIDTH-1:0] bias   [0:OUT_FEATURES-1];

generate
    if (IN_FEATURES == 784 && OUT_FEATURES == 50) begin
        assign weight = weight_784_50;
        assign bias   = bias_784_50;
    end else if (IN_FEATURES == 50 && OUT_FEATURES == 30) begin
        assign weight = weight_50_30;
        assign bias   = bias_50_30;
    end else if (IN_FEATURES == 30 && OUT_FEATURES == 10) begin
        assign weight = weight_30_10;
        assign bias   = bias_30_10;
    end
endgenerate


wire en_delay;
Delay_n #(.DELAY_CNT(2)) u_delay_en (.clk(clk), .rst_n(rst_n), .din(en), .dout(en_delay));
(* dont_touch = "true", register_duplication = "off" *)reg [$clog2(IN_FEATURES)-1:0] d_cnt [0:OUT_FEATURES-1];


reg en_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) en_reg <= 1'b0;
    else en_reg <= en_delay;
end
wire en_pulse = en_delay && !en_reg;

reg run_en[0:OUT_FEATURES-1];
(* use_dsp48="yes" *) reg signed [PROD_WIDTH-1:0] prod [0:OUT_FEATURES-1];


genvar n;
generate
for (n = 0; n < OUT_FEATURES; n = n + 1) begin : neuron_loop
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            d_cnt[n] <= '0;
        else if (d_cnt[n] == IN_FEATURES - 1)
            d_cnt[n] <= '0;
        else if (run_en[n])
            d_cnt[n] <= d_cnt[n] + 1;
    end
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            run_en[n] <= 1'b0;
        else if (en_pulse)
            run_en[n] <= 1'b1;
        else if (d_cnt[n] == IN_FEATURES - 1)
            run_en[n] <= 1'b0;
    end

    reg  signed [SUM_WIDTH-1:0] sum;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prod[n] <= '0;
        end else if (run_en[n]) begin
            prod[n] <= din * weight[n][d_cnt[n]];
        end else
            prod[n] <= '0;
    end
  

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum <= 0;
        end else if (en_pulse) begin
            sum <= bias[n];
        end else if (run_en[n]) begin
            sum <= sum + prod[n];
        end
    end

    // 杈撳嚭
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            dout[n] <= 0;
        else
            dout[n] <= sum;
    end

end
endgenerate

// ==============================================
// 瀹屾垚淇″彿
// ==============================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        done <= 1'b0;
    else
        done <= (d_cnt[0] == IN_FEATURES - 1);
end

endmodule
*/

module Full_connect #(
    parameter BIT_WIDTH    = 8,
    parameter IN_FEATURES  = 784,
    parameter OUT_FEATURES = 64
)(
    input  wire clk,
    input  wire rst_n,
    input  wire en,                  // 鍚姩鑴夊啿

    // 涓茶杈撳叆锛氭瘡鎷?1涓壒寰?
    input  wire signed [BIT_WIDTH-1:0] din,

    // 鎵?鏈夌缁忓厓骞惰杈撳嚭
    output reg signed [2*BIT_WIDTH + $clog2(IN_FEATURES) + 1 - 1 : 0]  dout [0:OUT_FEATURES-1] ,
    output reg  done,
    output wire overflow
);

localparam PROD_WIDTH = 2 * BIT_WIDTH;
localparam SUM_EXTRA1   = $clog2(IN_FEATURES) + 1;
localparam SUM_WIDTH  = PROD_WIDTH + SUM_EXTRA1;   // 瓒冲瀹斤紝闃叉孩鍑?

// 鏉冮噸 & 鍋忕疆锛堢洿鎺nclude锛?

`include "weights.vh"


/////////////////////////////////////////////////
wire signed [BIT_WIDTH-1:0] weight [0:OUT_FEATURES-1][0:IN_FEATURES-1];
wire signed [PROD_WIDTH-1:0] bias   [0:OUT_FEATURES-1];

generate
    if (IN_FEATURES == 784 && OUT_FEATURES == 50) begin
        assign weight = weight_784_50;
        assign bias   = bias_784_50;
    end else if (IN_FEATURES == 50 && OUT_FEATURES == 30) begin
        assign weight = weight_50_30;
        assign bias   = bias_50_30;
    end else if (IN_FEATURES == 30 && OUT_FEATURES == 10) begin
        assign weight = weight_30_10;
        assign bias   = bias_30_10;
    end
endgenerate


wire en_delay;
Delay_n #(.DELAY_CNT(2)) u_delay_en (.clk(clk), .rst_n(rst_n), .din(en), .dout(en_delay));
(* dont_touch = "true", register_duplication = "off" *)reg [$clog2(IN_FEATURES)-1:0] d_cnt [0:OUT_FEATURES-1];


reg en_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) en_reg <= 1'b0;
    else en_reg <= en_delay;
end
wire en_pulse = en_delay && !en_reg;

reg run_en[0:OUT_FEATURES-1];
(* use_dsp48="yes" *) reg signed [PROD_WIDTH-1:0] prod [0:OUT_FEATURES-1];
reg  signed [SUM_WIDTH-1:0] sum[0:OUT_FEATURES-1];
reg run_en_delay[0:OUT_FEATURES-1];
reg run_en_delay_n[0:OUT_FEATURES-1];
    
genvar n;
generate
for (n = 0; n < OUT_FEATURES; n = n + 1) begin : neuron_loop
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            d_cnt[n] <= '0;
        else if (d_cnt[n] == IN_FEATURES - 1)
            d_cnt[n] <= '0;
        else if (run_en[n])
            d_cnt[n] <= d_cnt[n] + 1;
    end
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            run_en[n] <= 1'b0;
        else if (en_pulse)
            run_en[n] <= 1'b1;
        else if (d_cnt[n] == IN_FEATURES - 1)
            run_en[n] <= 1'b0;
    end

    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prod[n] <= '0;
        end else if (run_en[n]) begin
            prod[n] <= din * weight[n][d_cnt[n]];
        end else
            prod[n] <= '0;
    end
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            run_en_delay[n] <= 1'b0;
        else
            run_en_delay[n] <= run_en_delay_n[n];
    end
    
    always @(*) begin
            run_en_delay_n[n] = run_en[n];
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[n] <= 0;
        end else if (en_pulse) begin
            sum[n] <= bias[n];
        end else if (run_en_delay[n]) begin
            sum[n] <= sum[n] + prod[n];
        end
    end

    // 杈撳嚭
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            dout[n] <= 0;
        else
            dout[n] <= sum[n];
    end

end
endgenerate

// ==============================================
// 瀹屾垚淇″彿
// ==============================================
reg     done_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_reg <= 1'b0;
        done <= 1'b0;
    end else begin
        done_reg <= (run_en_delay_n[0] == 1'b0 && run_en_delay[0] == 1'b1);
        done <= done_reg;
    end
end

endmodule