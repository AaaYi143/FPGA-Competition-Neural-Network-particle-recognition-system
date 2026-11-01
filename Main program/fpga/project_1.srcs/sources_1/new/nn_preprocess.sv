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


module nn_preprocess #(
    parameter WIDTH       = 24,
    parameter FEATURE_CNT = 89,
    parameter ROM_ADDR_W  = 8
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire  signed      [WIDTH-1:0]  x_raw,
    input  wire                     data_valid,
    output reg  [7:0]               norm_8bit,
    output wire                     valid_out
);

//============================
//【当前时刻 寄存器变量定义】
//============================
reg signed  [WIDTH-1:0]                 frame_max;
reg signed  [WIDTH-1:0]                 frame_max_n;
reg signed  [WIDTH-1:0]                 frame_min;
reg signed  [WIDTH-1:0]                 frame_min_n;
reg [$clog2(FEATURE_CNT)-1:0]   sample_cnt;
reg [$clog2(FEATURE_CNT)-1:0]   sample_cnt_n;
reg                             frame_calc_en; //持续电平：1=归一化输出阶段
reg                             frame_calc_en_n;
reg                             frame_calc_en_delay1; //持续电平：1=归一化输出阶段
reg                             frame_calc_en_delay2; //持续电平：1=归一化输出阶段

reg [WIDTH-1:0]                 B;
reg [WIDTH-1:0]                 B_n;
reg [WIDTH-1:0]                 min_save; //原来min_reg，当前值
reg [WIDTH-1:0]                 min_save_n;
reg [7:0]                       scale;
reg [7:0]                       scale_n;
reg                             ram_wr_en;
reg                             ram_wr_en_n;

reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt;
reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt_n;
wire                            rd_pulse;
reg                             rd_pulse_delay1;
reg                             rd_pulse_delay2;

reg [7:0]                       norm_tmp;
reg [7:0]                       norm_tmp_n;



//缓存RAM
reg   signed  [WIDTH-1:0]         buf_ram [0:FEATURE_CNT-1];

//中间组合信号
wire    signed    [WIDTH-1:0]         x_u;
reg     [$clog2(WIDTH)-1:0] k;
reg     [$clog2(WIDTH)-1:0] k_n;
reg     [WIDTH-1:0]         M;
reg     [WIDTH-1:0]         M_n;
wire    [ROM_ADDR_W-1:0]    rom_addr;
reg     [15:0]              rom_q88;
wire    [7:0]               scale_q8;
wire    [WIDTH+16-1:0]      mul_shifted;
wire    [WIDTH-1:0]         x_buf;
reg     [WIDTH:0]           x_sub;
wire    [WIDTH:0]           x_sub_n;
reg     [WIDTH+16:0]        mul_full;
(* use_dsp48="yes" *) reg [WIDTH+16:0]       mul_full_n;
wire    [7:0]               norm_tmp_comb;
reg     [7:0]               norm_8bit_n;



//============================
//【时序逻辑：只做 当前 <= 下一时刻，无运算】
//============================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        frame_max               <= {1'b1,{(WIDTH-1){1'b0}}}; //有符号最小值 -2^{WIDTH-1}frame_max               <= 'd0;
        frame_min               <= {1'b0,{(WIDTH-1){1'b1}}}; //有符号最大值 +(2^{WIDTH-1}-1)
        sample_cnt              <= FEATURE_CNT - 1;
        frame_calc_en           <= 1'b0;
        B                       <= 'd0;
        min_save                <= 'd0;
        scale                   <= 'd0;
        rd_cnt                  <= 'd0;
        ram_wr_en               <= 1'b0;     
        k                       <= 'd0;     
        norm_tmp                <= 'd0;
        mul_full                <= 'd0;
        norm_8bit               <= 'd0;
        x_sub                   <= 'd0;
    end else begin
        frame_max               <= frame_max_n;
        frame_min               <= frame_min_n;
        sample_cnt              <= sample_cnt_n;       
        frame_calc_en           <= frame_calc_en_n;     
        frame_calc_en_delay1    <= frame_calc_en;
        frame_calc_en_delay2    <= frame_calc_en_delay1;       
        B                       <= B_n;
        min_save                <= min_save_n;
        scale                   <= scale_n;
        rd_cnt                  <= rd_cnt_n;
        ram_wr_en               <= ram_wr_en_n;       
        k                       <= k_n;       
        rd_pulse_delay1         <= rd_pulse;
        rd_pulse_delay2         <= rd_pulse_delay1;               
        mul_full                <= mul_full_n;
        //RAM写端口
        if(!frame_calc_en && data_valid) begin
            buf_ram[sample_cnt_n] <= x_u;
        end       
        norm_8bit               <= norm_8bit_n;
        x_sub                   <= x_sub_n;
    end
end



//============================
//【组合逻辑区：每个变量独立 always@(*)】
//============================
//输入钳位
//assign x_u = x_raw[WIDTH-1] ? 'd0 : x_raw;
assign x_u = x_raw;

//1. frame_max_n
always @(*) begin
    if(frame_calc_en == 1'b0) begin
        if (x_u > frame_max && data_valid == 1'b1) begin
            frame_max_n = x_u;
        end else begin
            frame_max_n = frame_max;
        end
    end else begin
        frame_max_n = {1'b1,{(WIDTH-1){1'b0}}};
    end
end

//2. frame_min_n
always @(*) begin
    if(frame_calc_en == 1'b0) begin
        if (x_u < frame_min && data_valid == 1'b1) begin
            frame_min_n = x_u;
        end else begin
            frame_min_n = frame_min;
        end
    end else begin
        frame_min_n = {1'b0,{(WIDTH-1){1'b1}}};
    end
end

//3. sample_cnt_n
always @(*) begin
    if (sample_cnt == FEATURE_CNT-1 && data_valid == 1'b1) begin
        sample_cnt_n = 'd0;
    end else if (data_valid == 1'b1) begin
        sample_cnt_n = sample_cnt + 1'd1;
    end else begin
        sample_cnt_n = sample_cnt;
    end
end

//4. frame_calc_en_n
always @(*) begin
    if(sample_cnt == FEATURE_CNT - 2'd2 && sample_cnt_n == FEATURE_CNT - 1'd1) begin
        frame_calc_en_n = 1'b1;
    end else if(rd_cnt == FEATURE_CNT - 2'd2 && rd_cnt_n == FEATURE_CNT - 1'd1) begin
        frame_calc_en_n = 1'b0;
    end else begin
        frame_calc_en_n = frame_calc_en;
    end
end

//5. B_n
always @(*) begin 
    if(frame_calc_en == 1'b1 && frame_calc_en_delay1 == 1'b0) begin
        //B_n = frame_max;
        B_n = {frame_max[WIDTH-1],frame_max} - {frame_min[WIDTH-1],frame_min};
    end else begin
        B_n = B;
    end
end

//6. min_save_n
always @(*) begin
    if(frame_calc_en == 1'b1 && frame_calc_en_delay1 == 1'b0) begin
        min_save_n = frame_min;
    end else begin
        min_save_n = min_save;
    end
end

//8. ram_wr_en_n
always @(*) begin
    if(!frame_calc_en && data_valid) begin
        ram_wr_en_n = 1'b1;
    end else begin
        ram_wr_en_n = 1'b0;
    end
end

//9. LZC k
always @(*) begin
    if(frame_calc_en_delay1) begin
        k_n = 'd0;
        for(int i=WIDTH-1; i>=0; i=i-1) begin
            if(B[i] == 1'b1) begin
                k_n = (WIDTH - 1) - i;
                break;
            end
        end
     end else begin
        k_n = k; 
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
        8'd0 : rom_q88 = 16'hFF00;
        8'd1 : rom_q88 = 16'hFE02;
        8'd2 : rom_q88 = 16'hFD06;
        8'd3 : rom_q88 = 16'hFC0C;
        8'd4 : rom_q88 = 16'hFB14;
        8'd5 : rom_q88 = 16'hFA1D;
        8'd6 : rom_q88 = 16'hF929;
        8'd7 : rom_q88 = 16'hF837;
        8'd8 : rom_q88 = 16'hF746;
        8'd9 : rom_q88 = 16'hF657;
        8'd10 : rom_q88 = 16'hF56A;
        8'd11 : rom_q88 = 16'hF47F;
        8'd12 : rom_q88 = 16'hF395;
        8'd13 : rom_q88 = 16'hF2AD;
        8'd14 : rom_q88 = 16'hF1C7;
        8'd15 : rom_q88 = 16'hF0E3;
        8'd16 : rom_q88 = 16'hF000;
        8'd17 : rom_q88 = 16'hEF1F;
        8'd18 : rom_q88 = 16'hEE40;
        8'd19 : rom_q88 = 16'hED62;
        8'd20 : rom_q88 = 16'hEC86;
        8'd21 : rom_q88 = 16'hEBAB;
        8'd22 : rom_q88 = 16'hEAD2;
        8'd23 : rom_q88 = 16'hE9FA;
        8'd24 : rom_q88 = 16'hE925;
        8'd25 : rom_q88 = 16'hE850;
        8'd26 : rom_q88 = 16'hE77D;
        8'd27 : rom_q88 = 16'hE6AC;
        8'd28 : rom_q88 = 16'hE5DC;
        8'd29 : rom_q88 = 16'hE50D;
        8'd30 : rom_q88 = 16'hE440;
        8'd31 : rom_q88 = 16'hE375;
        8'd32 : rom_q88 = 16'hE2AB;
        8'd33 : rom_q88 = 16'hE1E2;
        8'd34 : rom_q88 = 16'hE11A;
        8'd35 : rom_q88 = 16'hE054;
        8'd36 : rom_q88 = 16'hDF90;
        8'd37 : rom_q88 = 16'hDECC;
        8'd38 : rom_q88 = 16'hDE0A;
        8'd39 : rom_q88 = 16'hDD4A;
        8'd40 : rom_q88 = 16'hDC8A;
        8'd41 : rom_q88 = 16'hDBCC;
        8'd42 : rom_q88 = 16'hDB0F;
        8'd43 : rom_q88 = 16'hDA54;
        8'd44 : rom_q88 = 16'hD99A;
        8'd45 : rom_q88 = 16'hD8E1;
        8'd46 : rom_q88 = 16'hD829;
        8'd47 : rom_q88 = 16'hD772;
        8'd48 : rom_q88 = 16'hD6BD;
        8'd49 : rom_q88 = 16'hD608;
        8'd50 : rom_q88 = 16'hD555;
        8'd51 : rom_q88 = 16'hD4A3;
        8'd52 : rom_q88 = 16'hD3F3;
        8'd53 : rom_q88 = 16'hD343;
        8'd54 : rom_q88 = 16'hD295;
        8'd55 : rom_q88 = 16'hD1E7;
        8'd56 : rom_q88 = 16'hD13B;
        8'd57 : rom_q88 = 16'hD090;
        8'd58 : rom_q88 = 16'hCFE6;
        8'd59 : rom_q88 = 16'hCF3D;
        8'd60 : rom_q88 = 16'hCE95;
        8'd61 : rom_q88 = 16'hCDEE;
        8'd62 : rom_q88 = 16'hCD48;
        8'd63 : rom_q88 = 16'hCCA4;
        8'd64 : rom_q88 = 16'hCC00;
        8'd65 : rom_q88 = 16'hCB5D;
        8'd66 : rom_q88 = 16'hCABC;
        8'd67 : rom_q88 = 16'hCA1B;
        8'd68 : rom_q88 = 16'hC97B;
        8'd69 : rom_q88 = 16'hC8DD;
        8'd70 : rom_q88 = 16'hC83F;
        8'd71 : rom_q88 = 16'hC7A2;
        8'd72 : rom_q88 = 16'hC706;
        8'd73 : rom_q88 = 16'hC66B;
        8'd74 : rom_q88 = 16'hC5D1;
        8'd75 : rom_q88 = 16'hC538;
        8'd76 : rom_q88 = 16'hC4A0;
        8'd77 : rom_q88 = 16'hC409;
        8'd78 : rom_q88 = 16'hC373;
        8'd79 : rom_q88 = 16'hC2DE;
        8'd80 : rom_q88 = 16'hC249;
        8'd81 : rom_q88 = 16'hC1B6;
        8'd82 : rom_q88 = 16'hC123;
        8'd83 : rom_q88 = 16'hC091;
        8'd84 : rom_q88 = 16'hC000;
        8'd85 : rom_q88 = 16'hBF70;
        8'd86 : rom_q88 = 16'hBEE1;
        8'd87 : rom_q88 = 16'hBE52;
        8'd88 : rom_q88 = 16'hBDC4;
        8'd89 : rom_q88 = 16'hBD38;
        8'd90 : rom_q88 = 16'hBCAC;
        8'd91 : rom_q88 = 16'hBC20;
        8'd92 : rom_q88 = 16'hBB96;
        8'd93 : rom_q88 = 16'hBB0C;
        8'd94 : rom_q88 = 16'hBA84;
        8'd95 : rom_q88 = 16'hB9FC;
        8'd96 : rom_q88 = 16'hB974;
        8'd97 : rom_q88 = 16'hB8EE;
        8'd98 : rom_q88 = 16'hB868;
        8'd99 : rom_q88 = 16'hB7E3;
        8'd100 : rom_q88 = 16'hB75F;
        8'd101 : rom_q88 = 16'hB6DB;
        8'd102 : rom_q88 = 16'hB659;
        8'd103 : rom_q88 = 16'hB5D7;
        8'd104 : rom_q88 = 16'hB555;
        8'd105 : rom_q88 = 16'hB4D5;
        8'd106 : rom_q88 = 16'hB455;
        8'd107 : rom_q88 = 16'hB3D6;
        8'd108 : rom_q88 = 16'hB357;
        8'd109 : rom_q88 = 16'hB2D9;
        8'd110 : rom_q88 = 16'hB25C;
        8'd111 : rom_q88 = 16'hB1E0;
        8'd112 : rom_q88 = 16'hB164;
        8'd113 : rom_q88 = 16'hB0E9;
        8'd114 : rom_q88 = 16'hB06F;
        8'd115 : rom_q88 = 16'hAFF5;
        8'd116 : rom_q88 = 16'hAF7C;
        8'd117 : rom_q88 = 16'hAF03;
        8'd118 : rom_q88 = 16'hAE8C;
        8'd119 : rom_q88 = 16'hAE14;
        8'd120 : rom_q88 = 16'hAD9E;
        8'd121 : rom_q88 = 16'hAD28;
        8'd122 : rom_q88 = 16'hACB3;
        8'd123 : rom_q88 = 16'hAC3E;
        8'd124 : rom_q88 = 16'hABCA;
        8'd125 : rom_q88 = 16'hAB57;
        8'd126 : rom_q88 = 16'hAAE4;
        8'd127 : rom_q88 = 16'hAA72;
        8'd128 : rom_q88 = 16'hAA00;
        8'd129 : rom_q88 = 16'hA98F;
        8'd130 : rom_q88 = 16'hA91F;
        8'd131 : rom_q88 = 16'hA8AF;
        8'd132 : rom_q88 = 16'hA83F;
        8'd133 : rom_q88 = 16'hA7D1;
        8'd134 : rom_q88 = 16'hA762;
        8'd135 : rom_q88 = 16'hA6F5;
        8'd136 : rom_q88 = 16'hA688;
        8'd137 : rom_q88 = 16'hA61B;
        8'd138 : rom_q88 = 16'hA5AF;
        8'd139 : rom_q88 = 16'hA544;
        8'd140 : rom_q88 = 16'hA4D9;
        8'd141 : rom_q88 = 16'hA46F;
        8'd142 : rom_q88 = 16'hA405;
        8'd143 : rom_q88 = 16'hA39C;
        8'd144 : rom_q88 = 16'hA333;
        8'd145 : rom_q88 = 16'hA2CB;
        8'd146 : rom_q88 = 16'hA263;
        8'd147 : rom_q88 = 16'hA1FC;
        8'd148 : rom_q88 = 16'hA196;
        8'd149 : rom_q88 = 16'hA12F;
        8'd150 : rom_q88 = 16'hA0CA;
        8'd151 : rom_q88 = 16'hA065;
        8'd152 : rom_q88 = 16'hA000;
        8'd153 : rom_q88 = 16'h9F9C;
        8'd154 : rom_q88 = 16'h9F38;
        8'd155 : rom_q88 = 16'h9ED5;
        8'd156 : rom_q88 = 16'h9E72;
        8'd157 : rom_q88 = 16'h9E10;
        8'd158 : rom_q88 = 16'h9DAE;
        8'd159 : rom_q88 = 16'h9D4D;
        8'd160 : rom_q88 = 16'h9CEC;
        8'd161 : rom_q88 = 16'h9C8C;
        8'd162 : rom_q88 = 16'h9C2C;
        8'd163 : rom_q88 = 16'h9BCD;
        8'd164 : rom_q88 = 16'h9B6E;
        8'd165 : rom_q88 = 16'h9B0F;
        8'd166 : rom_q88 = 16'h9AB1;
        8'd167 : rom_q88 = 16'h9A54;
        8'd168 : rom_q88 = 16'h99F6;
        8'd169 : rom_q88 = 16'h999A;
        8'd170 : rom_q88 = 16'h993D;
        8'd171 : rom_q88 = 16'h98E1;
        8'd172 : rom_q88 = 16'h9886;
        8'd173 : rom_q88 = 16'h982B;
        8'd174 : rom_q88 = 16'h97D0;
        8'd175 : rom_q88 = 16'h9776;
        8'd176 : rom_q88 = 16'h971C;
        8'd177 : rom_q88 = 16'h96C3;
        8'd178 : rom_q88 = 16'h966A;
        8'd179 : rom_q88 = 16'h9612;
        8'd180 : rom_q88 = 16'h95BA;
        8'd181 : rom_q88 = 16'h9562;
        8'd182 : rom_q88 = 16'h950B;
        8'd183 : rom_q88 = 16'h94B4;
        8'd184 : rom_q88 = 16'h945D;
        8'd185 : rom_q88 = 16'h9407;
        8'd186 : rom_q88 = 16'h93B1;
        8'd187 : rom_q88 = 16'h935C;
        8'd188 : rom_q88 = 16'h9307;
        8'd189 : rom_q88 = 16'h92B2;
        8'd190 : rom_q88 = 16'h925E;
        8'd191 : rom_q88 = 16'h920A;
        8'd192 : rom_q88 = 16'h91B7;
        8'd193 : rom_q88 = 16'h9164;
        8'd194 : rom_q88 = 16'h9111;
        8'd195 : rom_q88 = 16'h90BF;
        8'd196 : rom_q88 = 16'h906D;
        8'd197 : rom_q88 = 16'h901B;
        8'd198 : rom_q88 = 16'h8FCA;
        8'd199 : rom_q88 = 16'h8F79;
        8'd200 : rom_q88 = 16'h8F28;
        8'd201 : rom_q88 = 16'h8ED8;
        8'd202 : rom_q88 = 16'h8E88;
        8'd203 : rom_q88 = 16'h8E39;
        8'd204 : rom_q88 = 16'h8DEA;
        8'd205 : rom_q88 = 16'h8D9B;
        8'd206 : rom_q88 = 16'h8D4C;
        8'd207 : rom_q88 = 16'h8CFE;
        8'd208 : rom_q88 = 16'h8CB1;
        8'd209 : rom_q88 = 16'h8C63;
        8'd210 : rom_q88 = 16'h8C16;
        8'd211 : rom_q88 = 16'h8BC9;
        8'd212 : rom_q88 = 16'h8B7D;
        8'd213 : rom_q88 = 16'h8B31;
        8'd214 : rom_q88 = 16'h8AE5;
        8'd215 : rom_q88 = 16'h8A99;
        8'd216 : rom_q88 = 16'h8A4E;
        8'd217 : rom_q88 = 16'h8A03;
        8'd218 : rom_q88 = 16'h89B9;
        8'd219 : rom_q88 = 16'h896E;
        8'd220 : rom_q88 = 16'h8925;
        8'd221 : rom_q88 = 16'h88DB;
        8'd222 : rom_q88 = 16'h8892;
        8'd223 : rom_q88 = 16'h8849;
        8'd224 : rom_q88 = 16'h8800;
        8'd225 : rom_q88 = 16'h87B8;
        8'd226 : rom_q88 = 16'h8770;
        8'd227 : rom_q88 = 16'h8728;
        8'd228 : rom_q88 = 16'h86E0;
        8'd229 : rom_q88 = 16'h8699;
        8'd230 : rom_q88 = 16'h8652;
        8'd231 : rom_q88 = 16'h860C;
        8'd232 : rom_q88 = 16'h85C5;
        8'd233 : rom_q88 = 16'h857F;
        8'd234 : rom_q88 = 16'h8539;
        8'd235 : rom_q88 = 16'h84F4;
        8'd236 : rom_q88 = 16'h84AF;
        8'd237 : rom_q88 = 16'h846A;
        8'd238 : rom_q88 = 16'h8425;
        8'd239 : rom_q88 = 16'h83E1;
        8'd240 : rom_q88 = 16'h839D;
        8'd241 : rom_q88 = 16'h8359;
        8'd242 : rom_q88 = 16'h8316;
        8'd243 : rom_q88 = 16'h82D2;
        8'd244 : rom_q88 = 16'h828F;
        8'd245 : rom_q88 = 16'h824D;
        8'd246 : rom_q88 = 16'h820A;
        8'd247 : rom_q88 = 16'h81C8;
        8'd248 : rom_q88 = 16'h8186;
        8'd249 : rom_q88 = 16'h8144;
        8'd250 : rom_q88 = 16'h8103;
        8'd251 : rom_q88 = 16'h80C2;
        8'd252 : rom_q88 = 16'h8081;
        8'd253 : rom_q88 = 16'h8040;
        8'd254 : rom_q88 = 16'h8000;
        8'd255 : rom_q88 = 16'h7FC0;
        default : rom_q88 = 16'h0000;
    endcase
end

//rd_cnt_n
always @(*) begin
    if(frame_calc_en_delay2 && frame_calc_en_delay1) begin
        if(rd_cnt == FEATURE_CNT - 1) begin
            rd_cnt_n = 'd0;
        end else if(rd_cnt < FEATURE_CNT - 1) begin
            rd_cnt_n = rd_cnt + 1'd1; 
        end else begin
            rd_cnt_n = rd_cnt;
        end
    end else begin
        rd_cnt_n = rd_cnt;
    end
end

assign  rd_pulse = (rd_cnt != rd_cnt_n);

//15. x_sub
assign x_sub_n = {buf_ram[rd_cnt_n][WIDTH-1],buf_ram[rd_cnt_n]} - {min_save[WIDTH-1], min_save};

//16. 乘法
always @(*) begin
    mul_full_n = x_sub * rom_q88;
end

assign mul_shifted = mul_full >> (5'd31 - k);

//norm_8bit_n
always @(*) begin
    norm_8bit_n = mul_shifted[7:0];
end



assign  valid_out = rd_pulse_delay2;

endmodule




/*
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
    output wire                     valid_out
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
reg                             frame_calc_en_delay1; //持续电平：1=归一化输出阶段
reg                             frame_calc_en_delay2; //持续电平：1=归一化输出阶段

reg [WIDTH-1:0]                 B;
reg [WIDTH-1:0]                 B_n;
reg [WIDTH-1:0]                 min_save; //原来min_reg，当前值
reg [WIDTH-1:0]                 min_save_n;
reg [7:0]                       scale;
reg [7:0]                       scale_n;
reg                             ram_wr_en;
reg                             ram_wr_en_n;

reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt;
reg [$clog2(FEATURE_CNT)-1:0]   rd_cnt_n;
wire                            rd_pulse;
reg                             rd_pulse_delay1;
reg                             rd_pulse_delay2;

reg [7:0]                       norm_tmp;
reg [7:0]                       norm_tmp_n;



//缓存RAM
reg     [WIDTH-1:0]         buf_ram [0:FEATURE_CNT-1];

//中间组合信号
wire    [WIDTH-1:0]         x_u;
reg     [$clog2(WIDTH)-1:0] k;
reg     [$clog2(WIDTH)-1:0] k_n;
reg     [WIDTH-1:0]         M;
reg     [WIDTH-1:0]         M_n;
wire    [ROM_ADDR_W-1:0]    rom_addr;
reg     [15:0]              rom_q88;
wire    [7:0]               scale_q8;
wire    [WIDTH+16-1:0]      mul_shifted;
wire    [WIDTH-1:0]         x_buf;
wire    [WIDTH:0]           x_sub;
reg     [WIDTH+16:0]        mul_full;
(* use_dsp48="yes" *) reg [WIDTH+16:0]       mul_full_n;
wire    [7:0]               norm_tmp_comb;
reg     [7:0]               norm_8bit_n;



//============================
//【时序逻辑：只做 当前 <= 下一时刻，无运算】
//============================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        frame_max               <= 'd0;
        frame_min               <= {WIDTH{1'b1}};
        sample_cnt              <= FEATURE_CNT - 1;
        frame_calc_en           <= 1'b0;
        B                       <= 'd0;
        min_save                <= 'd0;
        scale                   <= 'd0;
        rd_cnt                  <= 'd0;
        ram_wr_en               <= 1'b0;     
        k                       <= 'd0;     
        norm_tmp                <= 'd0;
        mul_full                <= 'd0;
        norm_8bit               <= 'd0;
    end else begin
        frame_max               <= frame_max_n;
        frame_min               <= frame_min_n;
        sample_cnt              <= sample_cnt_n;       
        frame_calc_en           <= frame_calc_en_n;     
        frame_calc_en_delay1    <= frame_calc_en;
        frame_calc_en_delay2    <= frame_calc_en_delay1;       
        B                       <= B_n;
        min_save                <= min_save_n;
        scale                   <= scale_n;
        rd_cnt                  <= rd_cnt_n;
        ram_wr_en               <= ram_wr_en_n;       
        k                       <= k_n;       
        rd_pulse_delay1         <= rd_pulse;
        rd_pulse_delay2         <= rd_pulse_delay1;               
        mul_full                <= mul_full_n;
        //RAM写端口
        if(ram_wr_en) begin
            buf_ram[sample_cnt] <= x_u;
        end       
        norm_8bit               <= norm_8bit_n;
    end
end



//============================
//【组合逻辑区：每个变量独立 always@(*)】
//============================
//输入钳位
assign x_u = x_raw[WIDTH-1] ? 'd0 : x_raw;

//1. frame_max_n
always @(*) begin
    if(frame_calc_en == 1'b0) begin
        if (x_u > frame_max && data_valid == 1'b1) begin
            frame_max_n = x_u;
        end else begin
            frame_max_n = frame_max;
        end
    end else begin
        frame_max_n = frame_max;
    end
end

//2. frame_min_n
always @(*) begin
    if(frame_calc_en == 1'b0) begin
        if (x_u < frame_min && data_valid == 1'b1) begin
            frame_min_n = x_u;
        end else begin
            frame_min_n = frame_min;
        end
    end else begin
        frame_min_n = frame_min;
    end
end

//3. sample_cnt_n
always @(*) begin
    if (sample_cnt == FEATURE_CNT-1 && data_valid == 1'b1) begin
        sample_cnt_n = 'd0;
    end else if (data_valid == 1'b1) begin
        sample_cnt_n = sample_cnt + 1'd1;
    end else begin
        sample_cnt_n = sample_cnt;
    end
end

//4. frame_calc_en_n
always @(*) begin
    if(sample_cnt == FEATURE_CNT - 2'd2 && sample_cnt_n == FEATURE_CNT - 1'd1) begin
        frame_calc_en_n = 1'b1;
    end else if(rd_cnt == FEATURE_CNT - 2'd2 && rd_cnt_n == FEATURE_CNT - 1'd1) begin
        frame_calc_en_n = 1'b0;
    end else begin
        frame_calc_en_n = frame_calc_en;
    end
end

//5. B_n
always @(*) begin 
    if(frame_calc_en == 1'd1) begin
        B_n = frame_max;
        //B_n = frame_max - frame_min;
    end else begin
        B_n = B;
    end
end

//6. min_save_n
always @(*) begin
    if(frame_calc_en == 1'd1) begin
        min_save_n = frame_min;
    end else begin
        min_save_n = min_save;
    end
end

//8. ram_wr_en_n
always @(*) begin
    if(!frame_calc_en && data_valid) begin
        ram_wr_en_n = 1'b1;
    end else begin
        ram_wr_en_n = 1'b0;
    end
end

//9. LZC k
always @(*) begin
    if(frame_calc_en_delay1) begin
        k_n = 'd0;
        for(int i=WIDTH-1; i>=0; i=i-1) begin
            if(B[i] == 1'b1) begin
                k_n = (WIDTH - 1) - i;
                break;
            end
        end
     end else begin
        k_n = k; 
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
        8'd0 : rom_q88 = 16'hFF00;
        8'd1 : rom_q88 = 16'hFE02;
        8'd2 : rom_q88 = 16'hFD06;
        8'd3 : rom_q88 = 16'hFC0C;
        8'd4 : rom_q88 = 16'hFB14;
        8'd5 : rom_q88 = 16'hFA1D;
        8'd6 : rom_q88 = 16'hF929;
        8'd7 : rom_q88 = 16'hF837;
        8'd8 : rom_q88 = 16'hF746;
        8'd9 : rom_q88 = 16'hF657;
        8'd10 : rom_q88 = 16'hF56A;
        8'd11 : rom_q88 = 16'hF47F;
        8'd12 : rom_q88 = 16'hF395;
        8'd13 : rom_q88 = 16'hF2AD;
        8'd14 : rom_q88 = 16'hF1C7;
        8'd15 : rom_q88 = 16'hF0E3;
        8'd16 : rom_q88 = 16'hF000;
        8'd17 : rom_q88 = 16'hEF1F;
        8'd18 : rom_q88 = 16'hEE40;
        8'd19 : rom_q88 = 16'hED62;
        8'd20 : rom_q88 = 16'hEC86;
        8'd21 : rom_q88 = 16'hEBAB;
        8'd22 : rom_q88 = 16'hEAD2;
        8'd23 : rom_q88 = 16'hE9FA;
        8'd24 : rom_q88 = 16'hE925;
        8'd25 : rom_q88 = 16'hE850;
        8'd26 : rom_q88 = 16'hE77D;
        8'd27 : rom_q88 = 16'hE6AC;
        8'd28 : rom_q88 = 16'hE5DC;
        8'd29 : rom_q88 = 16'hE50D;
        8'd30 : rom_q88 = 16'hE440;
        8'd31 : rom_q88 = 16'hE375;
        8'd32 : rom_q88 = 16'hE2AB;
        8'd33 : rom_q88 = 16'hE1E2;
        8'd34 : rom_q88 = 16'hE11A;
        8'd35 : rom_q88 = 16'hE054;
        8'd36 : rom_q88 = 16'hDF90;
        8'd37 : rom_q88 = 16'hDECC;
        8'd38 : rom_q88 = 16'hDE0A;
        8'd39 : rom_q88 = 16'hDD4A;
        8'd40 : rom_q88 = 16'hDC8A;
        8'd41 : rom_q88 = 16'hDBCC;
        8'd42 : rom_q88 = 16'hDB0F;
        8'd43 : rom_q88 = 16'hDA54;
        8'd44 : rom_q88 = 16'hD99A;
        8'd45 : rom_q88 = 16'hD8E1;
        8'd46 : rom_q88 = 16'hD829;
        8'd47 : rom_q88 = 16'hD772;
        8'd48 : rom_q88 = 16'hD6BD;
        8'd49 : rom_q88 = 16'hD608;
        8'd50 : rom_q88 = 16'hD555;
        8'd51 : rom_q88 = 16'hD4A3;
        8'd52 : rom_q88 = 16'hD3F3;
        8'd53 : rom_q88 = 16'hD343;
        8'd54 : rom_q88 = 16'hD295;
        8'd55 : rom_q88 = 16'hD1E7;
        8'd56 : rom_q88 = 16'hD13B;
        8'd57 : rom_q88 = 16'hD090;
        8'd58 : rom_q88 = 16'hCFE6;
        8'd59 : rom_q88 = 16'hCF3D;
        8'd60 : rom_q88 = 16'hCE95;
        8'd61 : rom_q88 = 16'hCDEE;
        8'd62 : rom_q88 = 16'hCD48;
        8'd63 : rom_q88 = 16'hCCA4;
        8'd64 : rom_q88 = 16'hCC00;
        8'd65 : rom_q88 = 16'hCB5D;
        8'd66 : rom_q88 = 16'hCABC;
        8'd67 : rom_q88 = 16'hCA1B;
        8'd68 : rom_q88 = 16'hC97B;
        8'd69 : rom_q88 = 16'hC8DD;
        8'd70 : rom_q88 = 16'hC83F;
        8'd71 : rom_q88 = 16'hC7A2;
        8'd72 : rom_q88 = 16'hC706;
        8'd73 : rom_q88 = 16'hC66B;
        8'd74 : rom_q88 = 16'hC5D1;
        8'd75 : rom_q88 = 16'hC538;
        8'd76 : rom_q88 = 16'hC4A0;
        8'd77 : rom_q88 = 16'hC409;
        8'd78 : rom_q88 = 16'hC373;
        8'd79 : rom_q88 = 16'hC2DE;
        8'd80 : rom_q88 = 16'hC249;
        8'd81 : rom_q88 = 16'hC1B6;
        8'd82 : rom_q88 = 16'hC123;
        8'd83 : rom_q88 = 16'hC091;
        8'd84 : rom_q88 = 16'hC000;
        8'd85 : rom_q88 = 16'hBF70;
        8'd86 : rom_q88 = 16'hBEE1;
        8'd87 : rom_q88 = 16'hBE52;
        8'd88 : rom_q88 = 16'hBDC4;
        8'd89 : rom_q88 = 16'hBD38;
        8'd90 : rom_q88 = 16'hBCAC;
        8'd91 : rom_q88 = 16'hBC20;
        8'd92 : rom_q88 = 16'hBB96;
        8'd93 : rom_q88 = 16'hBB0C;
        8'd94 : rom_q88 = 16'hBA84;
        8'd95 : rom_q88 = 16'hB9FC;
        8'd96 : rom_q88 = 16'hB974;
        8'd97 : rom_q88 = 16'hB8EE;
        8'd98 : rom_q88 = 16'hB868;
        8'd99 : rom_q88 = 16'hB7E3;
        8'd100 : rom_q88 = 16'hB75F;
        8'd101 : rom_q88 = 16'hB6DB;
        8'd102 : rom_q88 = 16'hB659;
        8'd103 : rom_q88 = 16'hB5D7;
        8'd104 : rom_q88 = 16'hB555;
        8'd105 : rom_q88 = 16'hB4D5;
        8'd106 : rom_q88 = 16'hB455;
        8'd107 : rom_q88 = 16'hB3D6;
        8'd108 : rom_q88 = 16'hB357;
        8'd109 : rom_q88 = 16'hB2D9;
        8'd110 : rom_q88 = 16'hB25C;
        8'd111 : rom_q88 = 16'hB1E0;
        8'd112 : rom_q88 = 16'hB164;
        8'd113 : rom_q88 = 16'hB0E9;
        8'd114 : rom_q88 = 16'hB06F;
        8'd115 : rom_q88 = 16'hAFF5;
        8'd116 : rom_q88 = 16'hAF7C;
        8'd117 : rom_q88 = 16'hAF03;
        8'd118 : rom_q88 = 16'hAE8C;
        8'd119 : rom_q88 = 16'hAE14;
        8'd120 : rom_q88 = 16'hAD9E;
        8'd121 : rom_q88 = 16'hAD28;
        8'd122 : rom_q88 = 16'hACB3;
        8'd123 : rom_q88 = 16'hAC3E;
        8'd124 : rom_q88 = 16'hABCA;
        8'd125 : rom_q88 = 16'hAB57;
        8'd126 : rom_q88 = 16'hAAE4;
        8'd127 : rom_q88 = 16'hAA72;
        8'd128 : rom_q88 = 16'hAA00;
        8'd129 : rom_q88 = 16'hA98F;
        8'd130 : rom_q88 = 16'hA91F;
        8'd131 : rom_q88 = 16'hA8AF;
        8'd132 : rom_q88 = 16'hA83F;
        8'd133 : rom_q88 = 16'hA7D1;
        8'd134 : rom_q88 = 16'hA762;
        8'd135 : rom_q88 = 16'hA6F5;
        8'd136 : rom_q88 = 16'hA688;
        8'd137 : rom_q88 = 16'hA61B;
        8'd138 : rom_q88 = 16'hA5AF;
        8'd139 : rom_q88 = 16'hA544;
        8'd140 : rom_q88 = 16'hA4D9;
        8'd141 : rom_q88 = 16'hA46F;
        8'd142 : rom_q88 = 16'hA405;
        8'd143 : rom_q88 = 16'hA39C;
        8'd144 : rom_q88 = 16'hA333;
        8'd145 : rom_q88 = 16'hA2CB;
        8'd146 : rom_q88 = 16'hA263;
        8'd147 : rom_q88 = 16'hA1FC;
        8'd148 : rom_q88 = 16'hA196;
        8'd149 : rom_q88 = 16'hA12F;
        8'd150 : rom_q88 = 16'hA0CA;
        8'd151 : rom_q88 = 16'hA065;
        8'd152 : rom_q88 = 16'hA000;
        8'd153 : rom_q88 = 16'h9F9C;
        8'd154 : rom_q88 = 16'h9F38;
        8'd155 : rom_q88 = 16'h9ED5;
        8'd156 : rom_q88 = 16'h9E72;
        8'd157 : rom_q88 = 16'h9E10;
        8'd158 : rom_q88 = 16'h9DAE;
        8'd159 : rom_q88 = 16'h9D4D;
        8'd160 : rom_q88 = 16'h9CEC;
        8'd161 : rom_q88 = 16'h9C8C;
        8'd162 : rom_q88 = 16'h9C2C;
        8'd163 : rom_q88 = 16'h9BCD;
        8'd164 : rom_q88 = 16'h9B6E;
        8'd165 : rom_q88 = 16'h9B0F;
        8'd166 : rom_q88 = 16'h9AB1;
        8'd167 : rom_q88 = 16'h9A54;
        8'd168 : rom_q88 = 16'h99F6;
        8'd169 : rom_q88 = 16'h999A;
        8'd170 : rom_q88 = 16'h993D;
        8'd171 : rom_q88 = 16'h98E1;
        8'd172 : rom_q88 = 16'h9886;
        8'd173 : rom_q88 = 16'h982B;
        8'd174 : rom_q88 = 16'h97D0;
        8'd175 : rom_q88 = 16'h9776;
        8'd176 : rom_q88 = 16'h971C;
        8'd177 : rom_q88 = 16'h96C3;
        8'd178 : rom_q88 = 16'h966A;
        8'd179 : rom_q88 = 16'h9612;
        8'd180 : rom_q88 = 16'h95BA;
        8'd181 : rom_q88 = 16'h9562;
        8'd182 : rom_q88 = 16'h950B;
        8'd183 : rom_q88 = 16'h94B4;
        8'd184 : rom_q88 = 16'h945D;
        8'd185 : rom_q88 = 16'h9407;
        8'd186 : rom_q88 = 16'h93B1;
        8'd187 : rom_q88 = 16'h935C;
        8'd188 : rom_q88 = 16'h9307;
        8'd189 : rom_q88 = 16'h92B2;
        8'd190 : rom_q88 = 16'h925E;
        8'd191 : rom_q88 = 16'h920A;
        8'd192 : rom_q88 = 16'h91B7;
        8'd193 : rom_q88 = 16'h9164;
        8'd194 : rom_q88 = 16'h9111;
        8'd195 : rom_q88 = 16'h90BF;
        8'd196 : rom_q88 = 16'h906D;
        8'd197 : rom_q88 = 16'h901B;
        8'd198 : rom_q88 = 16'h8FCA;
        8'd199 : rom_q88 = 16'h8F79;
        8'd200 : rom_q88 = 16'h8F28;
        8'd201 : rom_q88 = 16'h8ED8;
        8'd202 : rom_q88 = 16'h8E88;
        8'd203 : rom_q88 = 16'h8E39;
        8'd204 : rom_q88 = 16'h8DEA;
        8'd205 : rom_q88 = 16'h8D9B;
        8'd206 : rom_q88 = 16'h8D4C;
        8'd207 : rom_q88 = 16'h8CFE;
        8'd208 : rom_q88 = 16'h8CB1;
        8'd209 : rom_q88 = 16'h8C63;
        8'd210 : rom_q88 = 16'h8C16;
        8'd211 : rom_q88 = 16'h8BC9;
        8'd212 : rom_q88 = 16'h8B7D;
        8'd213 : rom_q88 = 16'h8B31;
        8'd214 : rom_q88 = 16'h8AE5;
        8'd215 : rom_q88 = 16'h8A99;
        8'd216 : rom_q88 = 16'h8A4E;
        8'd217 : rom_q88 = 16'h8A03;
        8'd218 : rom_q88 = 16'h89B9;
        8'd219 : rom_q88 = 16'h896E;
        8'd220 : rom_q88 = 16'h8925;
        8'd221 : rom_q88 = 16'h88DB;
        8'd222 : rom_q88 = 16'h8892;
        8'd223 : rom_q88 = 16'h8849;
        8'd224 : rom_q88 = 16'h8800;
        8'd225 : rom_q88 = 16'h87B8;
        8'd226 : rom_q88 = 16'h8770;
        8'd227 : rom_q88 = 16'h8728;
        8'd228 : rom_q88 = 16'h86E0;
        8'd229 : rom_q88 = 16'h8699;
        8'd230 : rom_q88 = 16'h8652;
        8'd231 : rom_q88 = 16'h860C;
        8'd232 : rom_q88 = 16'h85C5;
        8'd233 : rom_q88 = 16'h857F;
        8'd234 : rom_q88 = 16'h8539;
        8'd235 : rom_q88 = 16'h84F4;
        8'd236 : rom_q88 = 16'h84AF;
        8'd237 : rom_q88 = 16'h846A;
        8'd238 : rom_q88 = 16'h8425;
        8'd239 : rom_q88 = 16'h83E1;
        8'd240 : rom_q88 = 16'h839D;
        8'd241 : rom_q88 = 16'h8359;
        8'd242 : rom_q88 = 16'h8316;
        8'd243 : rom_q88 = 16'h82D2;
        8'd244 : rom_q88 = 16'h828F;
        8'd245 : rom_q88 = 16'h824D;
        8'd246 : rom_q88 = 16'h820A;
        8'd247 : rom_q88 = 16'h81C8;
        8'd248 : rom_q88 = 16'h8186;
        8'd249 : rom_q88 = 16'h8144;
        8'd250 : rom_q88 = 16'h8103;
        8'd251 : rom_q88 = 16'h80C2;
        8'd252 : rom_q88 = 16'h8081;
        8'd253 : rom_q88 = 16'h8040;
        8'd254 : rom_q88 = 16'h8000;
        8'd255 : rom_q88 = 16'h7FC0;
        default : rom_q88 = 16'h0000;
    endcase
end

//rd_cnt_n
always @(*) begin
    if(frame_calc_en_delay2 && frame_calc_en_delay1) begin
        if(rd_cnt == FEATURE_CNT - 1) begin
            rd_cnt_n = 'd0;
        end else if(rd_cnt < FEATURE_CNT - 1) begin
            rd_cnt_n = rd_cnt + 1'd1; 
        end else begin
            rd_cnt_n = rd_cnt;
        end
    end else begin
        rd_cnt_n = rd_cnt;
    end
end

assign  rd_pulse = (rd_cnt != rd_cnt_n);

//15. x_sub
assign x_sub = buf_ram[rd_cnt] - min_save;

//16. 乘法
always @(*) begin
    mul_full_n = x_sub * rom_q88;
end

assign mul_shifted = mul_full >> (5'd31 - k);

//norm_8bit_n
always @(*) begin
    norm_8bit_n = mul_shifted[7:0];
end



assign  valid_out = rd_pulse_delay2;

endmodule
*/


