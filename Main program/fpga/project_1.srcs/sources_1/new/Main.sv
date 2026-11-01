
module Main
(
    input                           ipClk, 
    input                           ipRst_, 
    // Programmable Gain Amplifiers
    input           [ 7:0]          ipKey,
    output          [ 7:0]          opEnResistor,
    output          [ 7:0]          opLed,            
    // Ports of Xadc
    input           [ 3:0]          ipVauxP, // Auxiliary analog channel inputs
    input           [ 3:0]          ipVauxN,
    // Ports of Uart
    input                           ipUartRx,
    output                          opUartTx,   
    // Ports of Wireless
    input                           ipUartRx_Wireless,
    output                          opUartTx_Wireless,    
    // Choose Channel
    output          [ 6:0]          opChooseChannel,
    
    // segled
    output  wire    [ 1:0]           op_seg_en,
    output  wire    [ 7:0]           op_seg_data
);


// data type
parameter   NUM_OF_CHANNEL = 6'd32, NUM_FOR_RIGHT_SHIFT = 4'd8, NUM_OF_AVERAGE = 18'd256;
parameter   NUMBER_FOR_CHANNEL_OPEN = 9'd29;
// adc
wire                    [15:0]      outputDataOfAD;
wire                                trigOfEOC;
//通道切换
wire                                trigOfEOC;
wire                                trigOfSwitchChannel_n;
reg                                 trigOfSwitchChannel;
wire                                trigOfSelectData_n;
reg                                 trigOfSelectData;
reg                     [ 8:0]      conversionCnt;
reg                     [ 8:0]      conversionCnt_n;
reg                     [ 6:0]      codeForChannel;
reg                     [ 5:0]      channelCnt;
reg                     [ 5:0]      channelCnt_n;
//延迟
wire                                delay4Clk;
reg                                 delayCntEn;
reg                                 delayCntEn_n;
reg                     [ 2:0]      delayCnt;
reg                     [ 2:0]      delayCnt_n;
//求和平均
reg                     [17:0]      cnt2[0 : NUM_OF_CHANNEL - 1'd1];
reg                     [17:0]      cnt2_n[0 : NUM_OF_CHANNEL - 1'd1];
reg                     [17:0]      cnt2Reg;
reg                     [11:0]      inputDataForSum[0:NUM_OF_CHANNEL - 1'd1];          //  有符号数运算时加上 signed
reg                     [11:0]      inputDataForSum_n[0:NUM_OF_CHANNEL - 1'd1];         //  有符号数运算时加上 signed
reg                     [28:0]      sum[0:NUM_OF_CHANNEL - 1'd1];          //  有符号数运算时加上 signed
reg                     [28:0]      sum_n[0:NUM_OF_CHANNEL - 1'd1];          //  有符号数运算时加上 signed
reg                     [11:0]      averageOfSum[0:NUM_OF_CHANNEL - 1'd1];         //  有符号数运算时加上 signed
reg                     [11:0]      averageOfSum_n[0:NUM_OF_CHANNEL - 1'd1];         //  有符号数运算时加上 signed
wire                    [15:0]      average [0:NUM_OF_CHANNEL];         //  有符号数运算时加上 signed
//串口

reg                                 edgeOfCnt;
wire                                edgeOfCnt_n;
wire                                delay4Clk2;
reg                                 delayCntEn2;
reg                                 delayCntEn2_n;
reg                     [ 2:0]      delayCnt2;
reg                     [ 2:0]      delayCnt2_n;
reg                                 uartEn;
reg                                 uartEn_n;
reg                                 uartEnReg;
wire                                posedgeOfUartEN;
reg                     [ 5:0]      state;
reg                     [ 5:0]      state_n;
wire                    [ 7:0]      rx_data;			//接收数据寄存器，保存直至下一个数据来刿
// function 

ProgrammableGainAmplifiers    ProgrammableGainAmplifiers_inst
(
    .ipKey                      (ipKey),
    .iDataFromUart              (rx_data),
    .opEnResistor               (opEnResistor),
    .opLed                      (opLed)
); 
   
ADC     ADC_inst(
    .i_clk              (ipClk),
    .i_rst_             (ipRst_),     
    .i_vauxP            (ipVauxP), // Auxiliary analog channel inputs
    .i_vauxN            (ipVauxN),
    .outputDataOfAD     (outputDataOfAD ),
    .trigOfEOC          (trigOfEOC )                   
    );

wire signed [11:0] din_s12; // 输入12bit有符号（全负）
reg  [11:0]        dout_u12;// 输出12bit无符号，绝对值
reg signed [12:0] abs_temp; // 扩展1bit防止溢出
assign din_s12 = outputDataOfAD[15:4];
always @ (*) begin
    abs_temp = -din_s12;  // 补码取负，得到绝对值
    dout_u12 = abs_temp[11:0];
end


//通过计数器设定每个通道处于打开状态的保持时间
always @ (posedge ipClk or negedge ipRst_)
begin
    if (!ipRst_)
        conversionCnt <= 9'd0;
    else
        conversionCnt <= conversionCnt_n;
end

always @ (*)
begin
    if (conversionCnt == NUMBER_FOR_CHANNEL_OPEN && trigOfEOC == 1'b1)
        conversionCnt_n = 1'd0;
    else if (trigOfEOC == 1'b1)
        conversionCnt_n = conversionCnt + 1'b1;
    else
        conversionCnt_n = conversionCnt;
end

always @ (posedge ipClk or negedge ipRst_)
begin
    if (ipRst_ == 1'b0)
        trigOfSwitchChannel <= 1'b0;
    else
        trigOfSwitchChannel <= trigOfSwitchChannel_n;
end
assign trigOfSwitchChannel_n = (conversionCnt == NUMBER_FOR_CHANNEL_OPEN && conversionCnt_n == 8'd0) ? 1'b1 : 1'b0;

always @ (posedge ipClk or negedge ipRst_)
begin
    if (ipRst_ == 1'b0)
        trigOfSelectData <= 1'b0;
    else
        trigOfSelectData <= trigOfSelectData_n;
end
assign trigOfSelectData_n = (conversionCnt == NUMBER_FOR_CHANNEL_OPEN - 9'd2 && conversionCnt_n == NUMBER_FOR_CHANNEL_OPEN - 9'd1 ) ? 1'b1 : 1'b0;
// 通过计数器模块 计算通道数

always @ (posedge ipClk or negedge ipRst_)
begin
    if (!ipRst_)
        channelCnt <= 6'd0;
    else
        channelCnt <= channelCnt_n;
end
always @ (*)
begin
    if (channelCnt ==  NUM_OF_CHANNEL - 1'd1 && trigOfSwitchChannel == 1'b1)
        channelCnt_n = 6'd0;
    else if (trigOfSwitchChannel == 1'b1)
        channelCnt_n = channelCnt + 1'b1;
    else
        channelCnt_n = channelCnt;
end

// 根据通道数，编码、发送给FPGA外部的模拟开关，打开相应通道
always @ (*)
begin
    case(channelCnt) 
        6'd0:  codeForChannel = 7'b0011000;
        6'd1:  codeForChannel = 7'b0101111;
        6'd2:  codeForChannel = 7'b0010111;
        6'd3:  codeForChannel = 7'b0101000;
        6'd4:  codeForChannel = 7'b0011001;
        6'd5:  codeForChannel = 7'b0100111;
        6'd6:  codeForChannel = 7'b0010110;
        6'd7:  codeForChannel = 7'b0100001;
        6'd8:  codeForChannel = 7'b0011010;
        6'd9:  codeForChannel = 7'b0101110;
        6'd10:  codeForChannel = 7'b0010101;
        6'd11:  codeForChannel = 7'b0101001;
        6'd12:  codeForChannel = 7'b0011011;
        6'd13:  codeForChannel = 7'b0100110;
        6'd14:  codeForChannel = 7'b0010100;
        6'd15:  codeForChannel = 7'b0100010;
        6'd16:  codeForChannel = 7'b0011100;
        6'd17:  codeForChannel = 7'b0101101;
        6'd18:  codeForChannel = 7'b0010011;
        6'd19:  codeForChannel = 7'b0101010;
        6'd20:  codeForChannel = 7'b0011101;
        6'd21:  codeForChannel = 7'b0100101;
        6'd22:  codeForChannel = 7'b0010010;
        6'd23:  codeForChannel = 7'b0100011;
        6'd24:  codeForChannel = 7'b0011110;
        6'd25:  codeForChannel = 7'b0101100;
        6'd26:  codeForChannel = 7'b0010001;
        6'd27:  codeForChannel = 7'b0101011;
        6'd28:  codeForChannel = 7'b0011111;
        6'd29:  codeForChannel = 7'b0100100;
        6'd30:  codeForChannel = 7'b0010000;
        6'd31:  codeForChannel = 7'b1000000;

        default: codeForChannel = 7'b0_0_0_0000;
    endcase
end
assign  opChooseChannel = codeForChannel;

wire [NUM_OF_CHANNEL-1:0] ch_avg_done; // 每个通道完成标志，1bit/通道
genvar gv_i;
generate
for (gv_i = 0 ; gv_i <= NUM_OF_CHANNEL - 1'd1 ; gv_i = gv_i + 1'd1)
    begin : label
        wire ch_avg_done_comb;
        assign ch_avg_done_comb = (cnt2_n[gv_i] == 1'd0 && cnt2[gv_i] == NUM_OF_AVERAGE - 1'd1);
        assign ch_avg_done[gv_i] = ch_avg_done_comb; // 直接赋值到顶层数组！            
//<<<<<<<<<<<<<<<<<<<<<       
        always @ (posedge ipClk or negedge ipRst_)
        begin
           if (!ipRst_) begin
               cnt2[gv_i] <= 18'd0;
               sum[gv_i] <= 29'd0;
               averageOfSum[gv_i] <= 12'd0;
           end else begin
               cnt2[gv_i] <= cnt2_n[gv_i];
               sum[gv_i] <= sum_n[gv_i];
               averageOfSum[gv_i] <= averageOfSum_n[gv_i];
           end
        end
        always @ (*)
        begin
            if (cnt2[gv_i] == NUM_OF_AVERAGE - 1'd1 & trigOfSelectData == 1'b1 && channelCnt ==  gv_i)
                cnt2_n[gv_i] = 18'd0;
            else if  (trigOfSelectData == 1'b1 && channelCnt ==  gv_i)
                cnt2_n[gv_i] = cnt2[gv_i] + 18'd1;
            else
                cnt2_n[gv_i] = cnt2[gv_i];
        end             
            
        always @ (*)
        begin
           if (cnt2[gv_i] == NUM_OF_AVERAGE - 1'd1 & trigOfSelectData == 1'b1 && channelCnt ==  gv_i)
               // sum_n[gv_i] = {{17{inputDataForSum[gv_i][11]}},inputDataForSum_n[gv_i]}; // 有符号数运算
                sum_n[gv_i] = dout_u12;
           else if (trigOfSelectData == 1'b1 && channelCnt ==  gv_i)
              // sum_n[gv_i] = sum[gv_i] + {{17{inputDataForSum[gv_i][11]}},inputDataForSum_n[gv_i]}; // 有符号数运算
                sum_n[gv_i] = sum[gv_i] + dout_u12;
           else
                sum_n[gv_i] = sum[gv_i];
        end
     
        always @ (*)
        begin
         if (cnt2_n[gv_i] == 1'd0 && cnt2[gv_i] == NUM_OF_AVERAGE - 1'd1)
             averageOfSum_n[gv_i] = (sum[gv_i][28:0] >> NUM_FOR_RIGHT_SHIFT);   //求2的n次方个数的平均等同二进制数右移n位
         else
             averageOfSum_n[gv_i] = averageOfSum[gv_i];
        end
//        assign average [gv_i] = {{4{averageOfSum[gv_i][11]}},averageOfSum[gv_i]};   // 有符号数运算
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
        assign   average [gv_i] =  {4'b0000,averageOfSum[gv_i]};       
    end 
endgenerate

assign   average [NUM_OF_CHANNEL] = 16'hFFFF; 
       
//============================================判断最后一个通道中数据累计到平均数后计数器归零的时刻============================================
always @ (posedge ipClk or negedge ipRst_)
begin
    if (ipRst_ == 1'b0)
        edgeOfCnt <= 1'b0;
    else
        edgeOfCnt <= edgeOfCnt_n;
end
assign edgeOfCnt_n = (cnt2_n[NUM_OF_CHANNEL - 1] == 1'd0 && cnt2[NUM_OF_CHANNEL - 1] == NUM_OF_AVERAGE - 1'd1);

// ============================================在延迟delay4Clk2之后，产生串口发送使能标志====================================
always @ (posedge ipClk or negedge ipRst_)
begin
    if (!ipRst_)
        uartEn <= 1'b0;
    else
        uartEn <= uartEn_n;
end
always @ (*)
begin
    if (edgeOfCnt == 1'b1)             // 在延迟delay4Clk2之后，拉高串口使能标志
        uartEn_n = 1'b1;
    else if (state == NUM_OF_CHANNEL + 1'd1)    // 串口发送完第NUM_OF_CHANNEL的数据后，拉低串口使能标志
        uartEn_n = 1'b0;
    else
        uartEn_n = uartEn;
end


always @ (posedge ipClk or negedge ipRst_)
begin
    if (ipRst_ == 1'b0)
        uartEnReg <= 1'b0;
    else
        uartEnReg <= uartEn;
end
assign posedgeOfUartEN = (uartEnReg == 1'd0 && uartEn == 1'd1);  //串口使能上升沿检测标志

always @ (posedge ipClk or negedge ipRst_)
begin
    if (ipRst_ == 1'b0)
        state <= 6'd0;
    else
        state <= state_n;
end

wire               o_end_of_tx_block_character;   
always @ (*)
begin
    if (posedgeOfUartEN == 1'b1 || state == NUM_OF_CHANNEL + 1'd1)
        state_n = 6'd0;
    else if (o_end_of_tx_block_character == 1'b1)
        state_n = state + 6'd1;
    else
        state_n = state;
end


//============================================33通道串口传输 - 单通道16位数据串口传输==========================

wire                            tx_done;
wire                            tx_trig;
wire            [ 7:0]          tx_data;
wire                            uart_rx;
wire                            uart_tx;   

// 有线串口和无线串口的选择
assign uart_rx = (ipKey[0] == 1'b0) ? ipUartRx : ipUartRx_Wireless;
assign opUartTx = (ipKey[0] == 1'b0) ? uart_tx : 1'bz;
assign opUartTx_Wireless =(ipKey[0] == 1'b0) ? 1'bz : uart_tx;

UartDataReady       UartDataReady_Inst(
    .i_clk                               (ipClk),
    .i_rst_                              (ipRst_),
    .i_trig_uart                         (posedgeOfUartEN),
    .i_tx_done                           (tx_done),
    .i_data                              (average[state_n]),
    .i_rx_data                           (rx_data),
    .i_uart_en                           (uartEn && (state_n != NUM_OF_CHANNEL + 1'b1)),
    .o_tx_trig                           (tx_trig),
    .o_tx_data                           (tx_data),
    .o_end_of_tx_block_character         (o_end_of_tx_block_character)
); 

Uart_8bits #(
    .CLK_FREQ  (100_000_000),
    .BAUD_RATE (115200),
    .DATA_BITS (8),
    .PARITY_EN (1),
    .PARITY_TYPE (1)
)
Uart_8bits_inst
(
    .i_clk              (ipClk),
    .i_rst_n            (ipRst_),
    .i_rx               (uart_rx),
    .o_rx_data          (rx_data),
    .o_rx_done          (),
    .o_rx_err           (),
    .i_tx_data          (tx_data),
    .i_tx_trig          (tx_trig),
    .o_tx               (uart_tx),
    .o_tx_busy          (),
    .o_tx_done          (tx_done)
);


//===============================================神经网络========================


reg [$clog2(NUM_OF_CHANNEL)-1 : 0] ser_ch_cnt;
reg [11:0] avg_reg;
reg        avg_valid;

always @(posedge ipClk or negedge ipRst_) begin
    if(!ipRst_) begin
        ser_ch_cnt <= NUM_OF_CHANNEL - 2'd2;
        avg_reg <= 12'd0;
        avg_valid <= 1'b0;
    end else begin   
        if(ser_ch_cnt == NUM_OF_CHANNEL - 2'd2) begin
            if(ch_avg_done[0]) begin
                avg_valid <= ch_avg_done[0];
                ser_ch_cnt <= 'd0; 
                avg_reg   <= averageOfSum_n[0]; // 数组读出，寄存
            end else begin
                avg_valid = 1'd0;
            end             
        end else if(ch_avg_done[ser_ch_cnt+1]) begin
                avg_valid <= ch_avg_done[ser_ch_cnt+1];
                ser_ch_cnt <= ser_ch_cnt + 1'd1;
                avg_reg   <= averageOfSum_n[ser_ch_cnt+1]; // 数组读出，寄存
        end else begin 
                avg_valid = 1'd0;
        end
    end
end

Neural_network #(
    .IN_FEATURES    (31),
    .OUT_FEATURES   (31),
    .BIT_WIDTH      (8),
    .PARREL         (1),
    .RAW_DATA_W     (24)    
)Neural_network_inst(
    .i_clk          (ipClk),
    .i_rst_n        (ipRst_),
    .op_seg_en      (op_seg_en),
    .op_seg_data    (op_seg_data),
    .raw_sig        ($signed({{12{1'b0}}, avg_reg})),
    .raw_valid      (avg_valid)
);

endmodule