
/*
module Uart_8bits #(
    parameter CLK_FREQ    = 50_000_000,  // 时钟频率
    parameter BAUD_RATE   = 115200,      // 波特率
    parameter DATA_BITS   = 8,           // 数据位宽度
    parameter STOP_BITS   = 1,           // 停止位数量
    parameter PARITY_EN   = 0,           // 校验位使能(0:禁用,1:启用)
    parameter PARITY_TYPE = 0            // 校验类型(0:奇校验,1:偶校验)
)(
    input                   i_clk,        // 系统时钟
    input                   i_rst_n,      // 异步复位(低有效)
    // 接收接口
    input                   i_rx,         // 串口接收数据
    output reg [DATA_BITS-1:0] o_rx_data,  // 接收数据输出
    output reg              o_rx_done,    // 接收完成标志
    output reg              o_rx_err,     // 接收错误标志
    // 发送接口
    input [DATA_BITS-1:0]   i_tx_data,    // 发送数据
    input                   i_trig,       // 发送触发信号
    output reg              o_tx,         // 串口发送数据
    output reg              o_tx_busy,    // 发送忙标志
    output reg              o_tx_done     // 发送完成标志
);

// 计算波特率分频系数
localparam BAUD_DIV = CLK_FREQ / BAUD_RATE;
localparam BAUD_CNT_WIDTH = $clog2(BAUD_DIV);

// 接收状态机定义
localparam RX_IDLE      = 3'd0,  // 空闲状态
           RX_START     = 3'd1,  // 起始位状态
           RX_DATA      = 3'd2,  // 数据位状态
           RX_PARITY    = 3'd3,  // 校验位状态
           RX_STOP      = 3'd4;  // 停止位状态

// 发送状态机定义
localparam TX_IDLE      = 3'd0,  // 空闲状态
           TX_START     = 3'd1,  // 起始位状态
           TX_DATA      = 3'd2,  // 数据位状态
           TX_PARITY    = 3'd3,  // 校验位状态
           TX_STOP      = 3'd4;  // 停止位状态

// 接收状态机变量
reg [2:0]                   rx_state;
reg [BAUD_CNT_WIDTH-1:0]    rx_baud_cnt;
reg [2:0]                   rx_bit_cnt;
reg [DATA_BITS-1:0]         rx_data_reg;
reg                         rx_parity;

// 发送状态机变量
reg [2:0]                   tx_state;
reg [BAUD_CNT_WIDTH-1:0]    tx_baud_cnt;
reg [2:0]                   tx_bit_cnt;
reg [DATA_BITS-1:0]         tx_data_reg;
reg                         tx_parity;

// 接收状态机逻辑
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        rx_state    <= RX_IDLE;
        rx_baud_cnt <= 0;
        rx_bit_cnt  <= 0;
        rx_data_reg <= 0;
        rx_parity   <= 0;
        o_rx_data   <= 0;
        o_rx_done   <= 0;
        o_rx_err    <= 0;
    end else begin
        o_rx_done <= 0;
        o_rx_err  <= 0;
        
        case (rx_state)
            RX_IDLE: begin
                if (!i_rx) begin  // 检测到起始位(低电平)
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_START;
                end
            end
            
            RX_START: begin
                if (rx_baud_cnt == BAUD_DIV / 2 - 1) begin  // 中点采样
                    rx_baud_cnt <= 0;
                    if (!i_rx) begin  // 确认起始位
                        rx_state <= RX_DATA;
                        rx_bit_cnt <= 0;
                        rx_parity <= 0;
                    end else begin  // 虚假起始位，回到空闲
                        rx_state <= RX_IDLE;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_DATA: begin
                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_data_reg[rx_bit_cnt] <= i_rx;
                    rx_parity <= rx_parity ^ i_rx;  // 计算校验位
                    
                    if (rx_bit_cnt == DATA_BITS - 1) begin
                        if (PARITY_EN) begin
                            rx_state <= RX_PARITY;
                        end else begin
                            rx_state <= RX_STOP;
                        end
                    end else begin
                        rx_bit_cnt <= rx_bit_cnt + 1;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_PARITY: begin
                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_state <= RX_STOP;
                    
                    // 校验位错误检测
                    if ((PARITY_TYPE == 0 && i_rx != ~rx_parity) ||  // 奇校验
                        (PARITY_TYPE == 1 && i_rx != rx_parity)) begin  // 偶校验
                        o_rx_err <= 1;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_STOP: begin
                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_bit_cnt <= 0;
                    rx_state <= RX_IDLE;
                    
                    if (i_rx) begin  // 停止位正确(高电平)
                        o_rx_data <= rx_data_reg;
                        o_rx_done <= 1;
                    end else begin  // 停止位错误
                        o_rx_err <= 1;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            default: rx_state <= RX_IDLE;
        endcase
    end
end

// 发送状态机逻辑（仅发送单字节）
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        tx_state    <= TX_IDLE;
        tx_baud_cnt <= 0;
        tx_bit_cnt  <= 0;
        tx_data_reg <= 0;
        tx_parity   <= 0;
        o_tx        <= 1;  // 空闲时为高电平
        o_tx_busy   <= 0;
        o_tx_done   <= 0;
    end else begin
        o_tx_done <= 0;
        
        case (tx_state)
            TX_IDLE: begin
                o_tx <= 1;  // 空闲状态为高电平
                if (i_trig && !o_tx_busy) begin  // 检测到触发信号且不忙
                    o_tx_busy   <= 1;
                    tx_data_reg <= i_tx_data;  // 仅加载单字节数据
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_START;
                end else begin
                    o_tx_busy <= 0;
                end
            end
            
            TX_START: begin
                o_tx <= 0;  // 起始位(低电平)
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_bit_cnt  <= 0;
                    tx_parity   <= 0;
                    tx_state    <= TX_DATA;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_DATA: begin
                o_tx <= tx_data_reg[tx_bit_cnt];  // 发送数据位
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_parity <= tx_parity ^ tx_data_reg[tx_bit_cnt];  // 计算校验位
                    
                    if (tx_bit_cnt == DATA_BITS - 1) begin
                        if (PARITY_EN) begin
                            tx_state <= TX_PARITY;
                        end else begin
                            tx_state <= TX_STOP;
                        end
                    end else begin
                        tx_bit_cnt <= tx_bit_cnt + 1;
                    end
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_PARITY: begin
                // 发送校验位
                o_tx <= (PARITY_TYPE == 0) ? ~tx_parity : tx_parity;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_STOP;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_STOP: begin
                o_tx <= 1;  // 停止位(高电平)
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_IDLE;
                    o_tx_done   <= 1;
                    o_tx_busy   <= 0;  // 单字节发送完成
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            default: tx_state <= TX_IDLE;
        endcase
    end
end

endmodule
*/
/*
module Uart_8bits #(
    parameter CLK_FREQ    = 50_000_000,
    parameter BAUD_RATE   = 115200,
    parameter DATA_BITS   = 8,
    parameter STOP_BITS   = 1,
    parameter PARITY_EN   = 1,           // 打开使能
    parameter PARITY_TYPE = 1            // 1=偶校验（匹配上位机）
)(
    input                   i_clk,
    input                   i_rst_n,

    input                   i_rx,
    output reg [DATA_BITS-1:0] o_rx_data,
    output reg              o_rx_done,
    output reg              o_rx_err,

    input [DATA_BITS-1:0]   i_tx_data,
    input                   i_trig,
    output reg              o_tx,
    output reg              o_tx_busy,
    output reg              o_tx_done
);

localparam BAUD_DIV     = CLK_FREQ / BAUD_RATE;
localparam BAUD_HALF    = BAUD_DIV / 2;       // 中点！
localparam BAUD_CNT_WIDTH = $clog2(BAUD_DIV);

localparam RX_IDLE      = 3'd0,
           RX_START     = 3'd1,
           RX_DATA      = 3'd2,
           RX_PARITY    = 3'd3,
           RX_STOP      = 3'd4;

localparam TX_IDLE      = 3'd0,
           TX_START     = 3'd1,
           TX_DATA      = 3'd2,
           TX_PARITY    = 3'd3,
           TX_STOP      = 3'd4;

reg [2:0]                   rx_state;
reg [BAUD_CNT_WIDTH-1:0]    rx_baud_cnt;
reg [2:0]                   rx_bit_cnt;
reg [DATA_BITS-1:0]         rx_data_reg;
reg                         rx_parity;

reg [2:0]                   tx_state;
reg [BAUD_CNT_WIDTH-1:0]    tx_baud_cnt;
reg [2:0]                   tx_bit_cnt;
reg [DATA_BITS-1:0]         tx_data_reg;
reg                         tx_parity;

// ==============================================================================
// 🔥 接收端：全部改成 【中点采样】
// ==============================================================================
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        rx_state    <= RX_IDLE;
        rx_baud_cnt <= 0;
        rx_bit_cnt  <= 0;
        rx_data_reg <= 0;
        rx_parity   <= 0;
        o_rx_data   <= 0;
        o_rx_done   <= 0;
        o_rx_err    <= 0;
    end else begin
        o_rx_done <= 0;
        o_rx_err  <= 0;
        
        case (rx_state)
            RX_IDLE: begin
                if (!i_rx) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_START;
                end
            end
            
            // --------------------------
            // 起始位：中点采样
            // --------------------------
            RX_START: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    rx_baud_cnt <= 0;
                    if (!i_rx) begin
                        rx_state   <= RX_DATA;
                        rx_bit_cnt <= 0;
                        rx_parity  <= 0;
                    end else begin
                        rx_state <= RX_IDLE;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            // --------------------------
            // 数据位：中点采样 ✅
            // --------------------------
            RX_DATA: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    rx_data_reg[rx_bit_cnt] <= i_rx;
                    rx_parity <= rx_parity ^ i_rx;
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    if (rx_bit_cnt == DATA_BITS - 1) begin
                        rx_state <= PARITY_EN ? RX_PARITY : RX_STOP;
                    end else begin
                        rx_bit_cnt <= rx_bit_cnt + 1;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            // --------------------------
            // 校验位：中点采样 ✅
            // --------------------------
            RX_PARITY: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    if ((PARITY_TYPE == 0 && i_rx != ~rx_parity) ||
                        (PARITY_TYPE == 1 && i_rx != rx_parity)) begin
                        o_rx_err <= 1;
                    end
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_STOP;
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            // --------------------------
            // 停止位：中点采样 ✅
            // --------------------------
            RX_STOP: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    if (i_rx) begin
                        o_rx_data <= rx_data_reg;
                        o_rx_done <= 1;
                    end else begin
                        o_rx_err <= 1;
                    end
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_IDLE;
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            default: rx_state <= RX_IDLE;
        endcase
    end
end

// ==============================================================================
// 发送端（保持不变）
// ==============================================================================
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        tx_state    <= TX_IDLE;
        tx_baud_cnt <= 0;
        tx_bit_cnt  <= 0;
        tx_data_reg <= 0;
        tx_parity   <= 0;
        o_tx        <= 1;
        o_tx_busy   <= 0;
        o_tx_done   <= 0;
    end else begin
        o_tx_done <= 0;
        
        case (tx_state)
            TX_IDLE: begin
                o_tx <= 1;
                if (i_trig && !o_tx_busy) begin
                    o_tx_busy   <= 1;
                    tx_data_reg <= i_tx_data;
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_START;
                end else begin
                    o_tx_busy <= 0;
                end
            end
            
            TX_START: begin
                o_tx <= 0;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_bit_cnt  <= 0;
                    tx_parity   <= 0;
                    tx_state    <= TX_DATA;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_DATA: begin
                o_tx <= tx_data_reg[tx_bit_cnt];
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_parity <= tx_parity ^ tx_data_reg[tx_bit_cnt];
                    
                    if (tx_bit_cnt == DATA_BITS - 1) begin
                        tx_state <= PARITY_EN ? TX_PARITY : TX_STOP;
                    end else begin
                        tx_bit_cnt <= tx_bit_cnt + 1;
                    end
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_PARITY: begin
                o_tx <= (PARITY_TYPE == 0) ? ~tx_parity : tx_parity;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_STOP;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_STOP: begin
                o_tx <= 1;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_IDLE;
                    o_tx_done   <= 1;
                    o_tx_busy   <= 0;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            default: tx_state <= TX_IDLE;
        endcase
    end
end

endmodule
*/
/*
module Uart_8bits #(
    parameter CLK_FREQ    = 50_000_000,
    parameter BAUD_RATE   = 115200,
    parameter DATA_BITS   = 8,
    parameter STOP_BITS   = 1,
    parameter PARITY_EN   = 1,           // 打开使能
    parameter PARITY_TYPE = 1            // 1=偶校验（匹配上位机）
)(
    input                   i_clk,
    input                   i_rst_n,

    input                   i_rx,
    output reg [DATA_BITS-1:0] o_rx_data,
    output reg              o_rx_done,
    output reg              o_rx_err,

    input [DATA_BITS-1:0]   i_tx_data,
    input                   i_trig,
    output reg              o_tx,
    output reg              o_tx_busy,
    output reg              o_tx_done
);

localparam BAUD_DIV     = CLK_FREQ / BAUD_RATE;
localparam BAUD_HALF    = BAUD_DIV / 2;       // 中点！
localparam BAUD_CNT_WIDTH = $clog2(BAUD_DIV);

localparam RX_IDLE      = 3'd0,
           RX_START     = 3'd1,
           RX_DATA      = 3'd2,
           RX_PARITY    = 3'd3,
           RX_STOP      = 3'd4;

localparam TX_IDLE      = 3'd0,
           TX_START     = 3'd1,
           TX_DATA      = 3'd2,
           TX_PARITY    = 3'd3,
           TX_STOP      = 3'd4;

reg [2:0]                   rx_state;
reg [BAUD_CNT_WIDTH-1:0]    rx_baud_cnt;
reg [2:0]                   rx_bit_cnt;
reg [DATA_BITS-1:0]         rx_data_reg;
reg                         rx_parity;

reg [2:0]                   tx_state;
reg [BAUD_CNT_WIDTH-1:0]    tx_baud_cnt;
reg [2:0]                   tx_bit_cnt;
reg [DATA_BITS-1:0]         tx_data_reg;
reg                         tx_parity;

// ---------------------------
// 🔥 异步信号同步 + 滤波（核心）
// ---------------------------
reg rx_sync1, rx_sync2;
reg [3:0] rx_filter_cnt;
reg       rx_stable;

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        rx_sync1     <= 1'b1;
        rx_sync2     <= 1'b1;
        rx_filter_cnt <= 4'd0;
        rx_stable    <= 1'b1;
    end else begin
        rx_sync1 <= i_rx;
        rx_sync2 <= rx_sync1;

        // 4 个时钟滤波，滤除毛刺
        if (rx_sync2 == 1'b0) begin
            if (rx_filter_cnt < 4'd15)
                rx_filter_cnt <= rx_filter_cnt + 1'b1;
            else
                rx_stable <= 1'b0;
        end else begin
            rx_filter_cnt <= 4'd0;
            rx_stable    <= 1'b1;
        end
    end
end

// ==============================================================================
// 🔥 稳定版接收端（中点采样 + 同步 + 滤波）
// ==============================================================================
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        rx_state    <= RX_IDLE;
        rx_baud_cnt <= 0;
        rx_bit_cnt  <= 0;
        rx_data_reg <= 0;
        rx_parity   <= 0;
        o_rx_data   <= 0;
        o_rx_done   <= 0;
        o_rx_err    <= 0;
    end else begin
        o_rx_done <= 0;
        o_rx_err  <= 0;
        
        case (rx_state)
            RX_IDLE: begin
                // ✅ 使用滤波后的稳定信号检测起始位
                if (rx_stable == 1'b0) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_START;
                end
            end
            
            RX_START: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    rx_baud_cnt <= 0;
                    // ✅ 中点采样同步后的信号
                    if (!rx_stable) begin
                        rx_state   <= RX_DATA;
                        rx_bit_cnt <= 0;
                        rx_parity  <= 0;
                    end else begin
                        rx_state <= RX_IDLE;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_DATA: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    // ✅ 中点采样同步信号
                    rx_data_reg[rx_bit_cnt] <= rx_stable;
                    rx_parity <= rx_parity ^ rx_stable;
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    if (rx_bit_cnt == DATA_BITS - 1) begin
                        rx_state <= PARITY_EN ? RX_PARITY : RX_STOP;
                    end else begin
                        rx_bit_cnt <= rx_bit_cnt + 1;
                    end
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_PARITY: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    // ✅ 校验位也采同步信号
                    if ((PARITY_TYPE == 0 && rx_stable != ~rx_parity) ||
                        (PARITY_TYPE == 1 && rx_stable != rx_parity)) begin
                        o_rx_err <= 1;
                        //rx_state <= RX_IDLE;
                        rx_state <= RX_STOP;
                    end
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_STOP;
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            RX_STOP: begin
                if (rx_baud_cnt == BAUD_HALF - 1) begin  
                    if (rx_stable) begin
                        o_rx_data <= rx_data_reg;
                      //  o_rx_done <= 1;
                    end else begin
                        o_rx_err <= 1;
                     //   rx_state <= RX_IDLE;
                    end
                end

                if (rx_baud_cnt == BAUD_DIV - 1) begin
                    rx_baud_cnt <= 0;
                    rx_state    <= RX_IDLE;
                    o_rx_done <= 1; 
                end else begin
                    rx_baud_cnt <= rx_baud_cnt + 1;
                end
            end
            
            default: rx_state <= RX_IDLE;
        endcase
    end
end

// ==============================================================================
// 发送端（保持不变）
// ==============================================================================
always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        tx_state    <= TX_IDLE;
        tx_baud_cnt <= 0;
        tx_bit_cnt  <= 0;
        tx_data_reg <= 0;
        tx_parity   <= 0;
        o_tx        <= 1;
        o_tx_busy   <= 0;
        o_tx_done   <= 0;
    end else begin
        o_tx_done <= 0;
        
        case (tx_state)
            TX_IDLE: begin
                o_tx <= 1;
                if (i_trig && !o_tx_busy) begin
                    o_tx_busy   <= 1;
                    tx_data_reg <= i_tx_data;
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_START;
                end else begin
                    o_tx_busy <= 0;
                end
            end
            
            TX_START: begin
                o_tx <= 0;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_bit_cnt  <= 0;
                    tx_parity   <= 0;
                    tx_state    <= TX_DATA;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_DATA: begin
                o_tx <= tx_data_reg[tx_bit_cnt];
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_parity <= tx_parity ^ tx_data_reg[tx_bit_cnt];
                    
                    if (tx_bit_cnt == DATA_BITS - 1) begin
                        tx_state <= PARITY_EN ? TX_PARITY : TX_STOP;
                    end else begin
                        tx_bit_cnt <= tx_bit_cnt + 1;
                    end
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_PARITY: begin
                o_tx <= (PARITY_TYPE == 0) ? ~tx_parity : tx_parity;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_STOP;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            TX_STOP: begin
                o_tx <= 1;
                if (tx_baud_cnt == BAUD_DIV - 1) begin
                    tx_baud_cnt <= 0;
                    tx_state    <= TX_IDLE;
                    o_tx_done   <= 1;
                    o_tx_busy   <= 0;
                end else begin
                    tx_baud_cnt <= tx_baud_cnt + 1;
                end
            end
            
            default: tx_state <= TX_IDLE;
        endcase
    end
end

endmodule
*/


module Uart_8bits #(
    parameter CLK_FREQ    = 100_000_000,  // 100MHz
    parameter BAUD_RATE   = 115200,
    parameter DATA_BITS   = 8,
    parameter PARITY_EN   = 1,
    parameter PARITY_TYPE = 1    // 1=even
)(
    input                   i_clk,
    input                   i_rst_n,

    input                   i_rx,
    output reg [DATA_BITS-1:0] o_rx_data,
    output reg              o_rx_done,
    output reg              o_rx_err,

    input  [DATA_BITS-1:0]  i_tx_data,
    input                   i_tx_trig,
    output reg              o_tx,
    output reg              o_tx_busy,
    output reg              o_tx_done
);

// ==============================
// 32x 均匀过采样（100MHz 最优）
// ==============================
localparam SAMPLE_CNT    = 32;                   // 32个采样点
localparam SAMPLE_CNT_HALF    = SAMPLE_CNT / 2;                   // 32个采样点
localparam CLK_PER_BIT   = CLK_FREQ / BAUD_RATE; // 1 bit 有多少时钟
localparam STEP          = CLK_PER_BIT / SAMPLE_CNT; // 均匀步长

localparam RX_IDLE      = 0,
           RX_START     = 1,
           RX_DATA      = 2,
           RX_PARITY    = 3,
           RX_STOP      = 4;

localparam TX_IDLE      = 0,
           TX_START     = 1,
           TX_DATA      = 2,
           TX_PARITY    = 3,
           TX_STOP      = 4;

// RX 变量
reg [2:0]  rx_state;
reg [7:0]  clk_cnt;           // 时钟计数器
reg [5:0]  sample_cnt;        // 0~31
reg [5:0]  bit_1_cnt;         // 统计 1 的数量
reg [2:0]  rx_bit_cnt;
reg [7:0]  rx_data_reg;
reg        rx_parity;
reg        rx_bit;

// TX 变量
reg [2:0]  tx_state;
reg [9:0]  tx_clk_cnt;
reg [2:0]  tx_bit_cnt;
reg [7:0]  tx_data_reg;
reg        tx_parity;

// ---------------------------
// 输入同步 + 3级滤波（抗毛刺）
// ---------------------------
reg rx1, rx2;
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        rx1 <= 1;
        rx2 <= 1;
    end else begin
        rx1 <= i_rx;
        rx2 <= rx1;
    end
end

reg [2:0] rx_filter;
wire      rx_clean;
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) rx_filter <= 3'b111;
    else rx_filter <= {rx_filter[1], rx_filter[0], rx2};
end

assign rx_clean = (rx_filter[2]&rx_filter[1])|(rx_filter[2]&rx_filter[0])|(rx_filter[1]&rx_filter[0]);

// ==============================================================================
// ? 32x 均匀采样 + 统计 0/1 数量（最强版本）
// ==============================================================================
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        rx_state   <= RX_IDLE;
        clk_cnt    <= 0;
        sample_cnt <= 0;
        bit_1_cnt  <= 0;
        rx_bit_cnt <= 0;
        rx_data_reg<= 0;
        rx_parity  <= 0;
        o_rx_done  <= 0;
        o_rx_err   <= 0;
    end else begin
        o_rx_done <= 0;
        o_rx_err  <= 0;

        // 均匀采样：每 STEP 个时钟采一次
        if (rx_state == RX_IDLE)
            clk_cnt    <= 0;
        else if(clk_cnt == STEP - 1) begin
            clk_cnt <= 0;
            // 采样 1 计数
            if(rx_clean) bit_1_cnt <= bit_1_cnt + 1;

            if(sample_cnt < SAMPLE_CNT - 1) begin
                sample_cnt <= sample_cnt + 1;
            end
        end else begin
            clk_cnt <= clk_cnt + 1;
        end

        case(rx_state)
            RX_IDLE: begin
                sample_cnt <= 0;
                bit_1_cnt  <= 0;
                if(!rx_clean) rx_state <= RX_START;
            end

            RX_START: begin
                if((sample_cnt >= SAMPLE_CNT - 1) && (clk_cnt == STEP - 1)) begin
                    if(bit_1_cnt < SAMPLE_CNT_HALF) begin // 确认是起始位（低电平）
                        rx_state   <= RX_DATA;
                        rx_bit_cnt <= 0;
                        rx_parity  <= 0;
                    end else begin
                        rx_state <= RX_IDLE;
                    end
                    sample_cnt <= 0;
                    bit_1_cnt  <= 0;
                end
            end

            RX_DATA: begin
                if(sample_cnt >= SAMPLE_CNT - 1 && clk_cnt == STEP - 1) begin
                    rx_data_reg[rx_bit_cnt] <= (bit_1_cnt >= SAMPLE_CNT_HALF);
                    rx_parity <= rx_parity ^ (bit_1_cnt >= SAMPLE_CNT_HALF);

                    bit_1_cnt  <= 0;
                    sample_cnt <= 0;

                    if(rx_bit_cnt == 7) begin
                        rx_state <= PARITY_EN ? RX_PARITY : RX_STOP;
                    end else begin
                        rx_bit_cnt <= rx_bit_cnt + 1;
                    end
                end
            end

            RX_PARITY: begin
                if(sample_cnt >= SAMPLE_CNT - 1 && clk_cnt == STEP - 1) begin
                    if(PARITY_TYPE == 1) begin
                        if((^rx_data_reg) != (bit_1_cnt >= SAMPLE_CNT_HALF)) o_rx_err <= 1;
                    end else begin
                        if((^rx_data_reg) == (bit_1_cnt >= SAMPLE_CNT_HALF)) o_rx_err <= 1;
                    end

                    rx_state   <= RX_STOP;
                    sample_cnt <= 0;
                    bit_1_cnt  <= 0;
                end
            end

            RX_STOP: begin
                if(sample_cnt >= SAMPLE_CNT - 1 && clk_cnt == STEP - 1) begin
                    if(!(bit_1_cnt >= SAMPLE_CNT_HALF)) o_rx_err <= 1;

                    o_rx_data  <= rx_data_reg;
                    o_rx_done  <= 1;
                    rx_state   <= RX_IDLE;
                    sample_cnt <= 0;
                    bit_1_cnt  <= 0;
                end
            end
        endcase
    end
end

// ==============================
// 发送端（标准）
// ==============================
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        tx_state   <= TX_IDLE;
        tx_clk_cnt <= 0;
        tx_bit_cnt <= 0;
        tx_parity  <= 0;
        o_tx       <= 1;
        o_tx_busy  <= 0;
        
    end else begin
        
        if (tx_state == TX_IDLE)
            tx_clk_cnt <= 10'd0;
        else if(tx_clk_cnt == CLK_PER_BIT - 1) 
            tx_clk_cnt <= 0;
        else 
            tx_clk_cnt <= tx_clk_cnt + 1;

        case(tx_state)
            TX_IDLE: begin
                o_tx_done <= 0;
                o_tx <= 1;
                if(i_tx_trig && !o_tx_busy) begin
                    tx_state   <= TX_START;
                    tx_data_reg<= i_tx_data;
                    tx_parity  <= ^i_tx_data;
                    o_tx_busy  <= 1;
                    
                end else o_tx_busy <= 0;
            end

            TX_START: begin
                o_tx <= 0;
                if(tx_clk_cnt == CLK_PER_BIT - 1) tx_state <= TX_DATA;
            end

            TX_DATA: begin
                o_tx <= tx_data_reg[tx_bit_cnt];
                if(tx_clk_cnt == CLK_PER_BIT - 1) begin
                    if(tx_bit_cnt == 7) begin
                        tx_state <= PARITY_EN ? TX_PARITY : TX_STOP;
                        tx_bit_cnt <= 0;
                    end else tx_bit_cnt <= tx_bit_cnt + 1;
                end
            end

            TX_PARITY: begin
                o_tx <= (PARITY_TYPE == 1) ? tx_parity : ~tx_parity;
                if(tx_clk_cnt == CLK_PER_BIT - 1) tx_state <= TX_STOP;
            end

            TX_STOP: begin
                o_tx <= 1;
                if(tx_clk_cnt == CLK_PER_BIT - 1) begin
                    tx_state  <= TX_IDLE;
                    o_tx_done <= 1;
                    o_tx_busy <= 0;
                end
            end
        endcase
    end
end

endmodule