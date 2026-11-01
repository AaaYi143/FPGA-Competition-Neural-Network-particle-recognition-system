`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/10 09:45:01
// Design Name: 
// Module Name: Argmax
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/*
module Argmax #(
    parameter N     = 10,
    parameter WIDTH = 8
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    input  wire signed [WIDTH-1:0]  in [0:N-1] ,

    output reg done,
    output reg [$clog2(N)-1:0] index
);

// 娴佹按绾垮瘎瀛樺櫒锛氭瘡涓?鎷嶅瓨"褰撳墠鏈?澶у?? + 褰撳墠涓嬫爣"
reg signed [WIDTH-1:0] max_val;
reg [$clog2(N)-1:0] max_idx;
reg [$clog2(N)-1:0] i_cnt;
reg busy;

// 鍒濆鍖?
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        max_val <= 2'sd0;
        max_idx <= 2'd0;
        i_cnt   <= 1'b0;
        busy    <= 1'b0;
        done    <= 1'b0;
        index   <= '0;
    end else begin
        if(start && !busy) begin
            // 绗?0鎷嶏細鍒濆鍊? = in[0]
            max_val <= in[0];
            max_idx <= 2'd0;
            i_cnt   <= 1'd1;
            busy    <= 1'b1;
            done    <= 1'b0;
        end else if(busy) begin
            // ==============================
            // 姣忎竴鎷嶅彧姣旇緝 1 娆★紒锛侊紒
            // ==============================
            if(in[i_cnt] > max_val) begin
                max_val <= in[i_cnt];
                max_idx <= i_cnt;
            end

            i_cnt <= i_cnt + 1;

            // 姣旇緝瀹屾渶鍚庝竴涓紝杈撳嚭缁撴灉
            if(i_cnt == N-1) begin
                done  <= 1'b1;
                busy  <= 1'b0;
            end
        end else begin
            done <= 1'b0;
        end
        
        if (done == 1'b1) index <= max_idx;
    end
end

endmodule
*/

module Argmax #(
    parameter N     = 10,
    parameter WIDTH = 8
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    input  wire signed [WIDTH-1:0]  in [0:N-1],

    output reg done,
    output reg [$clog2(N)-1:0] index
);

localparam IDX_W = $clog2(N);

// ==============================
// 当前状态（时序寄存器）
// ==============================
reg signed [WIDTH-1:0] max_val;
reg [IDX_W-1:0] max_idx;
reg [IDX_W-1:0] cnt;
reg             busy;

// ==============================
// 下一状态（组合逻辑输出）
// ==============================
reg signed [WIDTH-1:0] max_val_n;
reg [IDX_W-1:0] max_idx_n;
reg [IDX_W-1:0] cnt_n;
reg             busy_n;
reg             done_n;
reg [IDX_W-1:0] index_n;

// ==============================
// 时序逻辑：只打拍，绝不运算
// ==============================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        max_val <= '0;
        max_idx <= '0;
        cnt     <= '0;
        busy    <= '0;
        done    <= '0;
        index   <= '0;
    end else begin
        max_val <= max_val_n;
        max_idx <= max_idx_n;
        cnt     <= cnt_n;
        busy    <= busy_n;
        done    <= done_n;
        index   <= index_n;
    end
end

// ==============================================
// 组合1：计数器
// ==============================================
always @(*) begin
    if (start) begin
        cnt_n = 1'd0;
    end
    else if (busy && cnt == N-1) begin
        cnt_n = cnt;
    end
    else if (busy) begin
        cnt_n = cnt + 1'd1;
    end
    else begin
        cnt_n = cnt;
    end
end

// ==============================================
// 组合2：busy 控制
// ==============================================
always @(*) begin
    if (start) begin
        busy_n = 1'b1;
    end
    else if (busy && cnt == N-1) begin
        busy_n = 1'b0;
    end
    else begin
        busy_n = busy;
    end
end

// ==============================================
// 组合3：最大值比较
// ==============================================
always @(*) begin
    if (start) begin
        max_val_n = in[0];
        max_idx_n = 'd0;
    end
    else if (busy && (in[cnt] > max_val)) begin
        max_val_n = in[cnt];
        max_idx_n = cnt;
    end
    else begin
        max_val_n = max_val;
        max_idx_n = max_idx;
    end
end

// ==============================================
// 组合4：done + index 同步输出（最完美）
// ==============================================
always @(*) begin
    if (busy && cnt == N-1) begin
        done_n  = 1'b1;
        index_n = max_idx_n;  // ✅ 同步输出最新值
    end else begin
        done_n  = 1'b0;
        index_n = index;      // 保持
    end
end

endmodule