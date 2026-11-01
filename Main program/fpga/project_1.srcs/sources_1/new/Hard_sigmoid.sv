module Hard_sigmoid #(
    parameter W_IN        = 16,
    parameter W_OUT       = 8,
    parameter N           = 32,
    parameter int THRESH  = 4,
    parameter SHIFT_W     = 1,
    parameter real SCALE  = 127
)(
    input  wire clk,
    input  wire rst_n,
    input  wire en,
    
    // ###########################
    // SV 二维 packed 数组（完全合法）
    // ###########################
    input  wire signed [W_IN-1:0] din [0:N-1],
    output logic done,
    output logic signed [W_OUT-1:0] dout [0:N-1]
);

localparam SHIFT_BITS    = $clog2(THRESH) + 1 + SHIFT_W;
localparam THRESH_SCALED = int'(THRESH * SCALE);  // SV 标准写法
localparam MAX_OUT       = (2**(W_OUT-1)) - 1;

// 使能脉冲
logic en_delay;
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        en_delay <= 1'b0;
    else
        en_delay <= en;
end
wire en_pulse = en && !en_delay;

logic run_en;
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        run_en <= 1'b0;
    else
        run_en <= en_pulse;
end

// ###########################
// SV 中：packed 二维数组 + generate 完美支持
// ###########################
genvar i;
generate
    for (i = 0; i < N; i++) begin : sig_proc
        always_ff @(posedge clk or negedge rst_n) begin
            if (!rst_n)
                dout[i] <= '0;
            else if (run_en) begin
                if      (din[i] <= -THRESH_SCALED) dout[i] <= '0;
                else if (din[i] >=  THRESH_SCALED) dout[i] <= MAX_OUT;
                else     dout[i] <= (din[i] + THRESH_SCALED) >>> SHIFT_BITS;
            end
        end
    end
endgenerate

// done 信号
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        done <= 1'b0;
    else
        done <= run_en;
end

endmodule