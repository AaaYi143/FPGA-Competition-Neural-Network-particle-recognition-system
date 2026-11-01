`timescale 1ns / 1ps


module SegLed(
    input wire                  clk,
    input wire                  rst_n,
    input wire     [7:0]        din,
    input wire                  start,
    // output 
    output reg     [7:0]        op_seg_data,
    output reg     [1:0]        op_seg_en   // 修改为reg，动态切换位选
);

parameter SEG_NUM0 = 8'h3F, 
    SEG_NUM1 = 8'h06,
    SEG_NUM2 = 8'h5B,
    SEG_NUM3 = 8'h4F,
    SEG_NUM4 = 8'h66,
    SEG_NUM5 = 8'h6D,
    SEG_NUM6 = 8'h7D,
    SEG_NUM7 = 8'h07,
    SEG_NUM8 = 8'h7F,
    SEG_NUM9 = 8'h6F,
    SEG_NUME = 8'h79;

// 扫描分频：假设50MHz clk，分频到约1kHz扫描频率
reg [15:0] scan_cnt;
reg        scan_sel;    // 0:个位，1:十位
reg [7:0]  data_buf;    // 锁存输入数值

// 1. 输入锁存：start触发锁存din
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        data_buf <= 8'd0;
    end else if(start) begin
        data_buf <= din; // 简易：负数直接显示0；如需负号可扩展第3位
    end
end

// 2. 动态扫描计数器
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        scan_cnt <= 16'd0;
        scan_sel <= 1'b0;
    end
    else begin
        if(scan_cnt == 16'd49999) begin // 50M /50000 = 1kHz
            scan_cnt <= 16'd0;
            scan_sel <= ~scan_sel;
        end
        else begin
            scan_cnt <= scan_cnt + 1'b1;
        end
    end
end

// 3. 拆分十位、个位，段码+位选输出
wire [3:0] digit_ten;
wire [3:0] digit_one;
assign digit_ten = data_buf / 10;
assign digit_one = data_buf % 10;

reg [3:0] cur_digit;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        op_seg_data <= SEG_NUME;
        op_seg_en   <= 4'b10;
        cur_digit   <= 4'd0;
    end
    else begin
        case(scan_sel)
            1'b0: begin // 显示个位
                op_seg_en <= 2'b10;
                cur_digit <= digit_one;
            end
            1'b1: begin // 显示十位
                op_seg_en <= 2'b01;
                cur_digit <= digit_ten;
            end
        endcase

        // 段码译码
        case(cur_digit)
            4'd0: op_seg_data <= SEG_NUM0; 
            4'd1: op_seg_data <= SEG_NUM1; 
            4'd2: op_seg_data <= SEG_NUM2; 
            4'd3: op_seg_data <= SEG_NUM3; 
            4'd4: op_seg_data <= SEG_NUM4; 
            4'd5: op_seg_data <= SEG_NUM5; 
            4'd6: op_seg_data <= SEG_NUM6; 
            4'd7: op_seg_data <= SEG_NUM7; 
            4'd8: op_seg_data <= SEG_NUM8; 
            4'd9: op_seg_data <= SEG_NUM9; 
            default: op_seg_data <= SEG_NUME; 
        endcase
    end
end
 
endmodule
