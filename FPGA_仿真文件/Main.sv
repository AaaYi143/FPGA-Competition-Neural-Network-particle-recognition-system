
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
    output  wire    [ 7:0]           op_seg_en,
    output  wire    [ 7:0]           op_seg_data,
    output  wire    [ 7:0]           op_seg_data_bank1,
    output  wire                    opParticleTx
);


// data type
parameter   NUM_OF_CHANNEL = 6'd32, NUM_FOR_RIGHT_SHIFT = 4'd9, NUM_OF_AVERAGE = 18'd512;
parameter   NUMBER_FOR_CHANNEL_OPEN = 9'd5;
// adc
wire                    [15:0]      outputDataOfAD;
wire                                trigOfEOC;
//通道切换
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
reg                     [15:0]      average_mem[0:NUM_OF_CHANNEL - 1'd1]; 
reg                     [15:0]      average[0:NUM_OF_CHANNEL - 1'd1];         //  有符号数运算时加上 signed
wire                    [15:0]      average_uart;         //  有符号数运算时加上 signed
reg                     [11:0]      average_nn;
reg                                 averageValid_nn;

// 背景扣除参数/信号定义
wire                            sub_bg_en;          // 背景扣除使能，ipKey[7]
assign sub_bg_en = ipKey[7];

reg [7:0] rd_chan_idx; // 读出通道索引 0~89

//串口
wire                    [15:0]      ordinal;
reg                                 frameDone;
wire                                frameDone_n;
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
    abs_temp = (din_s12 >= 12'sd0)? 12'sd0 : -din_s12;  // 补码取负，得到绝对值
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

// EXPERIMENT ONLY: fixed consensus permutation from three light levels.
// This table preserves measured amplitudes; it is not physical ring calibration.
always @(*) begin
    case (channelCnt)

        6'd0: codeForChannel = 7'b001_0011; // v3: previous v2 slot 2
        6'd1: codeForChannel = 7'b010_0101; // v3: previous v2 slot 0     
        6'd2: codeForChannel = 7'b001_0010; // v3: previous v2 slot 4
        6'd3: codeForChannel = 7'b010_0110; // v3: previous v2 slot 7
        6'd4: codeForChannel = 7'b001_0001; // v3: previous v2 slot 5
        6'd5: codeForChannel = 7'b010_0111; // v3: previous v2 slot 6
        6'd6: codeForChannel = 7'b001_0000; // v3: previous v2 slot 8
        6'd7: codeForChannel = 7'b010_1100; // v3: previous v2 slot 9
        6'd8: codeForChannel = 7'b001_1011; // v3: previous v2 slot 10
        6'd9: codeForChannel = 7'b010_1101; // v3: previous v2 slot 11
        6'd10: codeForChannel = 7'b001_1010; // v3: previous v2 slot 12
        6'd11: codeForChannel = 7'b010_1110; // v3: previous v2 slot 13
        6'd12: codeForChannel = 7'b001_1001; // v3: previous v2 slot 14
        6'd13: codeForChannel = 7'b010_1111; // v3: previous v2 slot 15
        6'd14: codeForChannel = 7'b001_1000; // v3: previous v2 slot 16
        6'd15: codeForChannel = 7'b010_1000; // v3: previous v2 slot 17
        6'd16: codeForChannel = 7'b001_1111; // v3: previous v2 slot 18
        6'd17: codeForChannel = 7'b010_1001; // v3: previous v2 slot 19
        6'd18: codeForChannel = 7'b001_1110; // v3: previous v2 slot 20
        6'd19: codeForChannel = 7'b010_1010; // v3: previous v2 slot 21
        6'd20: codeForChannel = 7'b001_1101; // v3: previous v2 slot 22
        6'd21: codeForChannel = 7'b010_1011; // v3: previous v2 slot 23
        6'd22: codeForChannel = 7'b001_1100; // v3: previous v2 slot 24
        6'd23: codeForChannel = 7'b010_0000; // v3: previous v2 slot 25
        6'd24: codeForChannel = 7'b001_0111; // v3: previous v2 slot 26
        6'd25: codeForChannel = 7'b010_0001; // v3: previous v2 slot 27
        6'd26: codeForChannel = 7'b001_0110; // v3: previous v2 slot 28
        6'd27: codeForChannel = 7'b010_0010; // v3: previous v2 slot 29
        6'd28: codeForChannel = 7'b001_0101; // v3: previous v2 slot 30
        6'd31: codeForChannel = 7'b010_0100; // v3: previous v2 slot 31
        6'd29: codeForChannel = 7'b010_0011; // v3: previous v2 slot 1  
        6'd30: codeForChannel = 7'b001_0100; // v3: previous v2 slot 3
        default: codeForChannel = 7'b000_0000;
    endcase
end
assign opChooseChannel = codeForChannel;

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
        
        always @ (posedge ipClk or negedge ipRst_) begin
            if (!ipRst_) begin
               average_mem[gv_i] <= 12'd0;
           end else if (frameDone && !sub_bg_en) begin
               average_mem[gv_i] <= averageOfSum[gv_i];
           end 
        end
        
        always @ (posedge ipClk or negedge ipRst_) begin
            if (!ipRst_) begin
               average[gv_i] <= 12'd0;
            end else if (frameDone) begin
                if (sub_bg_en) begin
                    average[gv_i] <= (averageOfSum[gv_i] > average_mem[gv_i]) ? (averageOfSum[gv_i]-average_mem[gv_i]) : 12'd0;
                end else begin
                    average[gv_i] <= averageOfSum[gv_i]; 
                end       
            end
        end
//        assign average [gv_i] = {{4{averageOfSum[gv_i][11]}},averageOfSum[gv_i]};   // 有符号数运算
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
//        assign   average[gv_i] =  {4'b0000,averageOfSum[gv_i]};       
    end 
endgenerate

// 和average数据同步，framDone寄存一拍
always @ (posedge ipClk or negedge ipRst_) begin
    if (!ipRst_) begin
        frameDone <= 1'b0; 
    end else begin
        frameDone <= (cnt2_n[NUM_OF_CHANNEL - 1] == 1'd0 && cnt2[NUM_OF_CHANNEL - 1] == NUM_OF_AVERAGE - 1'd1);
    end
end  

//assign  average [NUM_OF_CHANNEL] = 16'hFFFF; 
assign  average_uart = (ordinal == NUM_OF_CHANNEL) ? 16'hFFFF : {4'b0000,average[ordinal]};  
  
 /* 
// =====================【背景扣除逻辑 + 背景存储数组】====================
// 组合逻辑：读取当前通道均值，减去背景，负数钳位0
always @(*) begin
    raw_signed = $signed({1'b0, averageOfSum[rd_chan_idx]}); //原始12bit无符号转13bit有符号
    if(sub_bg_en) begin
        data_sub_bg_s = raw_signed - bg_mem[rd_chan_idx];
        if(data_sub_bg_s < 13'sd0) begin
            data_out_sub_bg = 12'd0; //负数直接钳位到0
        end else begin
            data_out_sub_bg = data_sub_bg_s[11:0];
        end
    end else begin
        data_out_sub_bg = averageOfSum[rd_chan_idx]; //不扣除，直接原始值
    end
end

// 时序逻辑：仅当【关闭背景扣除】且一整轮采集完成时，更新背景数组
integer bg_idx;
always @(posedge ipClk or negedge ipRst_) begin
    if(!ipRst_) begin
        for(bg_idx=0; bg_idx<NUM_OF_CHANNEL; bg_idx=bg_idx+1) begin
            bg_mem[bg_idx] <= 13'sd0;
        end
    end else begin
        if(frameDone_uart && !sub_bg_en) begin
            for(bg_idx=0; bg_idx<NUM_OF_CHANNEL; bg_idx=bg_idx+1) begin
                bg_mem[bg_idx] <= $signed({1'b0, averageOfSum[bg_idx]});
            end
        end
    end
end
*/
   
// ===================== 【串行读出控制逻辑】=====================

localparam S_RD_IDLE = 1'b0;
localparam S_RD_SEQ  = 1'b1;
reg rd_state;

always @(posedge ipClk or negedge ipRst_) begin
    if(!ipRst_) begin
        rd_state    <= S_RD_IDLE;
        rd_chan_idx <= 8'd0;
        average_nn <=   'd0;
        averageValid_nn  <= 1'b0;
    end else begin
        averageValid_nn <= 1'b0; // 默认无效
        
        case(rd_state)
            S_RD_IDLE: begin
                if(frameDone) begin
                    rd_state    <= S_RD_SEQ;
                    rd_chan_idx <= 8'd0;
                end
            end
            
            S_RD_SEQ: begin
                // 当前节拍输出rd_chan_idx对应的均值，拉高有效标志
                average_nn <= average[rd_chan_idx];
                averageValid_nn  <= 1'b1;
                
                if(rd_chan_idx < (NUM_OF_CHANNEL - 2)) begin
                    rd_chan_idx <= rd_chan_idx + 8'd1;
                end else begin
                    rd_state <= S_RD_IDLE; //90通道全部串行输出完毕
                end
            end
        endcase
    end
end


//============================================33通道串口传输 - 单通道16位数据串口传输==========================
// 有线串口和无线串口的选择
assign uart_rx = (ipKey[0] == 1'b0) ? ipUartRx : ipUartRx_Wireless;
assign opUartTx = (ipKey[0] == 1'b0) ? uart_tx : 1'bz;
assign opUartTx_Wireless =(ipKey[0] == 1'b0) ? 1'bz : uart_tx;

// SW6 dual-mode PC UART; independent STM32 result UART is always enabled.
wire [1:0] particle_class;
wire particle_empty;
wire particle_valid;
ParticleSerial serial_ports (
    .clk(ipClk), .rst_n(ipRst_), .sw6(ipKey[6]), .frame_done(frameDone),
    .spectrum_data(average_uart), .spectrum_ordinal(ordinal),
    .class_id(particle_class), .result_valid(particle_valid),
    .no_particles(particle_empty), .background_enabled(sub_bg_en),
    .pc_rx(uart_rx), .rx_data(rx_data), .pc_tx(uart_tx), .stm_tx(opParticleTx),
    .result_mode()
);

Neural_network #(
    .IN_FEATURES    (31),
    .OUT_FEATURES   (4),
    .BIT_WIDTH      (8),
    .PARREL         (1),
    .RAW_DATA_W     (24)    
)Neural_network_inst(
    .i_clk          (ipClk),
    .i_rst_n        (ipRst_),
    .op_seg_en      (op_seg_en),
    .op_seg_data    (op_seg_data),
    .op_seg_data_bank1 (op_seg_data_bank1),
    .raw_sig        ($signed({{12{1'b0}}, average_nn})),
    .raw_valid      (averageValid_nn),
    .result_class   (particle_class),
    .result_valid   (particle_valid),
    .result_empty   (particle_empty)
);

endmodule
