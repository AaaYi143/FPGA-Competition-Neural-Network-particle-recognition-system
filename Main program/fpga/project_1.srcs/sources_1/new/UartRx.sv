module UartRx
(
	//输人端口
	ipClk,ipRst_,ipUartRx,iRxBpsFlag,
	//输出端口
	oRxData,oRxBpsEn
);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input							ipClk;					//时钟的端口,开发板用的50M晶振
input							ipRst_;					//复位的端口,低电平复位
input							ipUartRx;					//FPGA的接收端口,串口CP2102的发送端口
input                   iRxBpsFlag;			//接收数据位的中间采样点
output                  oRxBpsEn;			//接收端口的波特率时钟启动信号
output      [ 7:0]      oRxData;			//从ipUartRx数据线中解析完后的数据

//---------------------------------------------------------------------------
//--	内部端口声明
//---------------------------------------------------------------------------
reg         [ 1:0]      detectEdge;			//记录UART的开始脉冲,即第一个下降沿
wire        [ 1:0]      detectEdge_n;			//detectEdge的下一个状态
reg                     negedgeReg;			//下降沿标志
wire                    negedgeReg_n;			//negedgeReg的下一个状态
reg                     oRxBpsEn;			//接收端口的波特率时钟启动信号
reg                     oRxBpsEn_n;		//oRxBpsEn的下一个状态
reg         [ 3:0]      bitCnt;					//用来记录接收数据位
reg         [ 3:0]      bitCnt_n;				//bitCnt的下一个状态
reg         [ 7:0]      shiftData;				//接收串行数据流中用到的移位寄存器
reg         [ 7:0]      shiftData_n;			//shiftData的下一个状态
reg         [ 7:0]      oRxData;			//从ipUartRx数据线中解析完后的数据
reg         [ 7:0]      oRxData_n;			//oRxData的下一个状态

//---------------------------------------------------------------------------
//--	逻辑功能实现	
//---------------------------------------------------------------------------
//时序电路,用来给detectEdge寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		detectEdge	<= 2'b11;				//初始化detectEdge值
	else
		detectEdge <= detectEdge_n;		//用来给detectEdge赋值
end

//组合电路,用来接收ipUartRx信号   1,0
assign detectEdge_n = {detectEdge[0], ipUartRx};	

//时序电路,用来给negedgeReg寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		negedgeReg	<= 1'b0;					//初始化negedgeReg值
	else
		negedgeReg <= negedgeReg_n;		//用来给negedgeReg赋值
end

//组合电路,判断下降沿,如果下降沿到来,negedgeReg_n就为1
assign negedgeReg_n = ((detectEdge == 2'b10)&&(oRxBpsEn == 1'b0)) ? 1'b1 : 1'b0; 

//时序电路,用来给oRxBpsEn寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		oRxBpsEn <= 1'b0;				//初始化oRxBpsEn值
	else
		oRxBpsEn <= oRxBpsEn_n;	//用来给oRxBpsEn赋值
end

//组合电路,如果下降沿到来,那么将启动波特率计数器
always @ (*)
begin
	if(negedgeReg == 1'b1)							//判断下降沿
		oRxBpsEn_n = 1'b1;				//如果下降沿到来,将oRxBpsEn_n置1
	else if(bitCnt == 4'd10)				//判断数据有没有接收完成
		oRxBpsEn_n = 1'b0;				//如果数据接收完成,将oRxBpsEn_n置0
	else
		oRxBpsEn_n = oRxBpsEn;	//否则,将保持不变
end

//时序电路,用来给bitCnt寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		bitCnt <= 4'b0;						//初始化bitCnt值
	else
		bitCnt <= bitCnt_n;				//用来给bitCnt赋值
end

//组合电路,如果到达数据位的中间采样点,那么接收数据位计数器加1,采样下一个数据位
always @ (*)
begin
	if(iRxBpsFlag == 1'b1)							//判断有没有达到数据位的中间采样点
		bitCnt_n = bitCnt + 1'b1;		//如果到达,那么接收数据位计数器加1,
	else if(bitCnt == 4'd10)				//判断数据有没有接收完成
		bitCnt_n = 1'b0;						//如果数据接收完成,接收数据位计数器清零
	else
		bitCnt_n = bitCnt;					//否则,将保持不变
end

//时序电路,用来给shiftData寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		shiftData <= 8'b0;					//初始化shiftData值
	else
		shiftData <= shiftData_n;		//用来给shiftData赋值
end

//组合电路,采样每个数据位的中心时间点,每采样一个便开始启动移位寄存器记录数据
always @ (*)
begin
	if(iRxBpsFlag == 1'b1)							//判断有没有达到数据位的中间采样点
		shiftData_n = {ipUartRx,shiftData[7:1]};	//如果到达,那么接收ipUartRx中的数据
	else
		shiftData_n = shiftData;			//否则,将保持不变
end

//时序电路,用来给oRxData寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(!ipRst_)									//判断复位
		oRxData <= 8'b0;					//初始化oRxData值
	else
		oRxData <= oRxData_n;		//用来给oRxData赋值
end

//组合电路,如果数据接收完成,那么将移位寄存器中的数据输出
always @ (*)
begin
	if(bitCnt == 4'd9)						//判断数据有没有接收完成
		oRxData_n = shiftData;		//如果接收完成,那么将移位寄存器中的数据输出
	else
		oRxData_n = oRxData;		//否则,将保持不变
end

endmodule

