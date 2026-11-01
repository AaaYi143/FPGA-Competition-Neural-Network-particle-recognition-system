`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/19 23:35:31
// Design Name: 
// Module Name: nn_preprocess
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

`timescale 1ns / 1ps
module nn_preprocess #(
    parameter WIDTH       = 24,
    parameter FEATURE_CNT = 89,
    parameter ROM_ADDR_W  = 8
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire signed [WIDTH-1:0]  x_raw,
    input  wire                     data_valid,
    output reg  [7:0]               norm_8bit,
    output reg                      valid_out
);

//============================
//【当前时刻 寄存器变量定义】
//============================
reg [WIDTH-1:0]                 frame_max;
reg [WIDTH-1:0]                 frame_max_n;
reg [WIDTH-1:0]                 frame_min;
reg [WIDTH-1:0]                 frame_min_n;
reg [$clog2(FEATURE_CNT)-1:0]   sample_cnt;
reg [$clog2(FEATURE_CNT)-1:0]   sample_cnt_n;
reg                             frame_calc_en; //持续电平：1=归一化输出阶段
reg                             frame_calc_en_n;

reg [WIDTH-1:0]                 B;
reg [WIDTH-1:0]                 B_n;
reg [WIDTH-1:0]                 min_save; //原来min_reg，当前值
reg [WIDTH-1:0]                 min_save_n;
reg [7:0]                       scale;
reg [7:0]                       scale_n;

reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt;
reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt_n;
reg                             ram_wr_en;
reg                             ram_wr_en_n;

reg [7:0]                       norm_tmp;
reg [7:0]                       norm_tmp_n;
reg                             valid_tmp;
reg                             valid_tmp_n;
reg                             b_zero;
reg                             b_zero_n;

//缓存RAM
reg [WIDTH-1:0] buf_ram [0:FEATURE_CNT-1];


//中间组合信号
wire [WIDTH-1:0] x_u;
reg [$clog2(WIDTH)-1:0] k;
reg [WIDTH-1:0]         M;
wire [ROM_ADDR_W-1:0]   rom_addr;
reg [15:0]              rom_q88;
wire [7:0]              scale_q8;

wire [WIDTH-1:0]        x_buf;
wire [WIDTH:0]          x_sub;
wire [WIDTH+8:0]        mul_full;
wire [7:0]              norm_tmp_comb;

//============================
//【组合逻辑区：每个变量独立 always@(*)】
//============================

//1. frame_max_n
always @(*) begin
    if(!frame_calc_en) begin
        if (data_valid) begin
            if(x_u > frame_max) begin
                frame_max_n = x_u;
            end else begin
                frame_max_n = frame_max;
            end
        end begin
            frame_max_n = frame_max;
        end
     end else begin
        frame_max_n = 0;
     end
    
    
    end && data_valid) begin
        
    end else begin
        frame_max_n = frame_max;
    end
end

//2. frame_min_n
always @(*) begin
    if(!frame_calc_en && data_valid) begin
        if(x_u < frame_min) begin
            frame_min_n = x_u;
        end begin
            frame_min_n = frame_min;
        end
    end else begin
        frame_min_n = frame_min;
    end
end

//3. sample_cnt_n
always @(*) begin
    if(!frame_calc_en && data_valid) begin
        sample_cnt_n = sample_cnt + 1'd1;
    end else begin
        sample_cnt_n = sample_cnt;
    end 
end

//4. frame_calc_en_n
always @(*) begin
    if(!frame_calc_en && data_valid && (sample_cnt == FEATURE_CNT - 1)) begin
        frame_calc_en_n = 1'b1;
    end else if(frame_calc_en && (rd_cnt == FEATURE_CNT - 1)) begin
        frame_calc_en_n = 1'b0;
    end else begin
        frame_calc_en_n = frame_calc_en;
    end
end

//5. B_n
always @(*) begin 
    if(sample_cnt == FEATURE_CNT - 1'd1 && sample_cnt_n == 1'd0) begin
        B_n = frame_max - frame_min;
    end else begin
        B_n = B;
    end
end

//6. min_save_n
always @(*) begin
    min_save_n = min_save;
    if(!frame_calc_en && data_valid && (sample_cnt == FEATURE_CNT - 1)) begin
        min_save_n = frame_min;
    end
end

//7. rd_cnt_n
always @(*) begin
    rd_cnt_n = rd_cnt;
    if(frame_calc_en) begin
        if(rd_cnt < FEATURE_CNT - 1) begin
            rd_cnt_n = rd_cnt + 1'd1;
        end
        else begin
            rd_cnt_n = 'd0;
        end
    end
end

//8. ram_wr_en_n
always @(*) begin
    ram_wr_en_n = 1'b0;
    if(!frame_calc_en && data_valid) begin
        ram_wr_en_n = 1'b1;
    end
end

//9. LZC k
always @(*) begin
    k = 'd0;
    for(int i=WIDTH-1; i>=0; i=i-1) begin
        if(B[i] == 1'b1) begin
            k = (WIDTH - 1) - i;
            break;
        end
    end
end

//10. barrel shift M
always @(*) begin
    M = B << k;
end

//11. rom_addr
assign rom_addr = M[WIDTH-2 : WIDTH-1 - ROM_ADDR_W];

//12. ROM查表
always @(*) begin
    case(rom_addr)
        8'h00 : rom_q88 = 16'hFF00;
        8'h01 : rom_q88 = 16'h7F80;
        default: rom_q88 = 16'h0000;
    endcase
end
assign scale_q8 = rom_q88[15:8];

//13. scale_n
always @(*) begin
    scale_n = scale;
    if(!frame_calc_en && data_valid && (sample_cnt == FEATURE_CNT - 1)) begin
        scale_n = scale_q8;
    end
end

//14. RAM读数据
assign x_buf = buf_ram[rd_cnt];

//15. x_sub
assign x_sub = x_buf - min_save;

//16. 乘法
assign mul_full = x_sub * scale;

//17. 截取结果
assign norm_tmp_comb = mul_full[WIDTH + 8 -1 : WIDTH];

//18. norm_tmp_n
always @(*) begin
    norm_tmp_n = norm_tmp_comb;
end

//19. valid_tmp_n
always @(*) begin
    valid_tmp_n = frame_calc_en;
end

//20. b_zero_n
always @(*) begin
    b_zero_n = (B == 'd0);
end

//21. 输入钳位
assign x_u = x_raw[WIDTH-1] ? 'd0 : x_raw;

//============================
//【时序逻辑：只做 当前 <= 下一时刻，无运算】
//============================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        frame_max    <= 'd0;
        frame_min    <= {WIDTH{1'b1}};
        sample_cnt   <= 'd0;
        frame_calc_en<= 1'b0;

        B            <= 'd0;
        min_save     <= 'd0;
        scale        <= 'd0;

        rd_cnt       <= 'd0;
        ram_wr_en    <= 1'b0;

        norm_tmp     <= 8'd0;
        valid_tmp    <= 1'b0;
        b_zero       <= 1'b0;
    end else begin
        frame_max    <= frame_max_n;
        frame_min    <= frame_min_n;
        sample_cnt   <= sample_cnt_n;
        frame_calc_en<= frame_calc_en_n;

        B            <= B_n;
        min_save     <= min_save_n;
        scale        <= scale_n;

        rd_cnt       <= rd_cnt_n;
        ram_wr_en    <= ram_wr_en_n;

        norm_tmp     <= norm_tmp_n;
        valid_tmp    <= valid_tmp_n;
        b_zero       <= b_zero_n;

        //RAM写端口
        if(ram_wr_en) begin
            buf_ram[sample_cnt] <= x_u;
        end
    end
end

//============================
//【输出组合逻辑】
//============================
always @(*) begin
    norm_8bit = 8'd0;
    valid_out = 1'b0;
    if(valid_tmp) begin
        valid_out = 1'b1;
        if(b_zero) begin
            norm_8bit = 8'd128;
        end else begin
            norm_8bit = norm_tmp;
        end
    end
end

endmodule


