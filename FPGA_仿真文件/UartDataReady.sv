`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/21 20:41:39
// Design Name: 
// Module Name: UartDataReady
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



module Uart_data_ready
#(
    parameter       DATA_WIDTH      = 24,    // 支持 16/24/32，必须是8的整数倍
    parameter       NUM_OF_CHANNEL  = 8'd90  // 有效通道：0 ~ NUM_OF_CHANNEL-1
)
(
    input                       ipClk,          // 系统时钟，与Uart_8bits同步域
    input                       ipRst_,         // 异步复位(低有效)
    input                       i_start_pulse,  // 帧开始触发脉冲(上升沿)
    // 底层Uart_8bits接口
    input                       i_uart_busy,    // UART忙标志 o_tx_busy
    input                       i_uart_done,    // UART单字节发送完成 o_tx_done
    output reg                  o_uart_trig,    // UART发送触发 i_trig
    output reg [7:0]            o_uart_data,    // UART 8bit发送数据 i_tx_data
    // 和相关器对接
    input      [DATA_WIDTH-1:0] i_data,         // 输入数据，位宽参数化
    output reg [15:0]           o_ordinal,      // 当前组序号 0~NUM_OF_CHANNEL
    output reg                  o_transmitting  // 帧传输标志
); 

// 内部常量：每组需要发送多少字节
localparam  BYTE_CNT_MAX = DATA_WIDTH / 8;
localparam  S_IDLE        = 2'd0,
            S_START       = 2'd1,
            S_SEND_BYTE   = 2'd2,
            S_WAIT_BYTE   = 2'd3;

reg [1:0]                state;
reg [DATA_WIDTH-1:0]     data_buf;
reg [3:0]                byte_cnt;        // 当前正在发送第几个字节 0~BYTE_CNT_MAX-1

reg                      uart_done_dly;
reg                      start_pulse_dly;

// 上升沿检测
always @(posedge ipClk or negedge ipRst_) begin
    if (!ipRst_) begin
        uart_done_dly <= 1'b0;
    end else begin
        uart_done_dly <= i_uart_done;
    end
end
wire uart_done_posedge = i_uart_done && !uart_done_dly;

always @(posedge ipClk or negedge ipRst_) begin
    if (!ipRst_) begin
        start_pulse_dly <= 1'b0;
    end else begin
        start_pulse_dly <= i_start_pulse;
    end
end
wire start_pulse_posedge = i_start_pulse && !start_pulse_dly;

// 主状态机
always @(posedge ipClk or negedge ipRst_) begin
    if (!ipRst_) begin
        state          <= S_IDLE;
        data_buf       <= {DATA_WIDTH{1'b0}};
        o_ordinal      <= 16'd0;
        o_uart_data    <= 8'd0;
        o_uart_trig    <= 1'b0;
        o_transmitting <= 1'b0;
        byte_cnt       <= 4'd0;
    end else begin
        o_uart_trig    <= 1'b0;
        o_transmitting <= (state != S_IDLE);
        
        case (state)
            S_IDLE: begin
                if (start_pulse_posedge) begin
                    state     <= S_START;
                    o_ordinal <= 16'd0;
                end
                else begin
                    state <= S_IDLE;
                end
            end

            S_START: begin
                // 等待UART空闲，加载本组数据
                if (!i_uart_busy) begin
                    state <= S_SEND_BYTE;
                    byte_cnt <= 4'd0;  // 从第0字节开始（最低字节）
                    data_buf <= i_data;
                end
                else begin
                    state <= S_START;
                end
            end

            S_SEND_BYTE: begin
                // 取出对应字节：byte_cnt=0 → 最低8bit，byte_cnt=1→次低
                o_uart_data <= data_buf[byte_cnt*8 +: 8];
                o_uart_trig <= 1'b1;
                state       <= S_WAIT_BYTE;
            end

            S_WAIT_BYTE: begin
                if(uart_done_posedge) begin
                    // 当前字节发送完成
                    if(byte_cnt < BYTE_CNT_MAX - 1) begin
                        // 本组还有剩余字节，字节计数+1，继续发送下一字节
                        byte_cnt <= byte_cnt + 4'd1;
                        state    <= S_SEND_BYTE;
                    end
                    else begin
                        // ✅ 当前这一组全部字节发送完毕
                        if(o_ordinal >= NUM_OF_CHANNEL) begin
                            // 帧标记发送完成，整帧结束
                            state <= S_IDLE;
                        end
                        else begin
                            // 序号+1，准备下一组数据
                            o_ordinal <= o_ordinal + 16'd1;
                            state     <= S_START;
                        end
                    end
                end
            end

            default: begin
                state <= S_IDLE;
            end
        endcase
    end
end
endmodule
