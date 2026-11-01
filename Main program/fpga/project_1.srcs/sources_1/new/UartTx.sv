module UartTx
(
	//输入端口
	ipClk,ipRst_,iDataForTx,iTxDataIsReady,iTxBspFlag,
	//输出端口
	opUartTx,oTxBpsEn
);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input							ipClk;					//时钟的端口,开发板用的50M晶振
input							ipRst_;					//复位的端口,低电平复位
input                   iTxDataIsReady;			//接收模块完成数据采集标志位
input                   iTxBspFlag;			//发送数据的数据改变点 
input       [ 7:0]      iDataForTx;				//将接收的数据输出给发送模块进行发送
output                  oTxBpsEn;			//发送端口的波特率时钟启动信号
output                  opUartTx;					//FPGA的发送端口,串口CP2102的接收端口
//---------------------------------------------------------------------------
//--	内部端口声明
//---------------------------------------------------------------------------
reg         [ 1:0]      detectEdge;			//记录iRxBpsEn的脉冲
wire        [ 1:0]      detectEdge_n;			//detectEdge的下一个状态
reg                     negedgeReg;			//下降沿标志
wire                    negedgeReg_n;			//negedgeReg的下一个状态
reg                     oTxBpsEn;			//发送端口的波特率时钟启动信号
reg                     oTxBpsEn_n;		//oTxBpsEn的下一个状态
reg         [ 7:0]      txTempData;			//待发送数据的寄存器
reg         [ 7:0]      txTempData_n;		//txTempData的下一个状态
reg         [ 3:0]      bitCnt;					//用来记录发送数据位
reg         [ 3:0]      bitCnt_n;				//bitCnt的下一个状态
reg                     opUartTx;					//FPGA的发送端口,串口CP2102的接收端口
reg                     opUartTx_n;				//opUartTx的下一个状态

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

//组合电路,用来接收iRxBpsEn信号
assign detectEdge_n = {detectEdge[0], iTxDataIsReady};	

//时序电路,用来给negedgeReg寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		negedgeReg <= 1'b0;					//初始化negedgeReg值
	else
		negedgeReg <= negedgeReg_n;		//用来给negedgeReg赋值
end

//组合电路,判断下降沿,如果下降沿到来,negedgeReg_n就为1
assign negedgeReg_n = (detectEdge == 2'b10) ? 1'b1 : 1'b0; 

//时序电路,用来给oTxBpsEn寄存器赋值
always @ (posedge ipClk or negedge ipRst_) 
begin
	if(ipRst_ == 1'b0)									//判断复位
		oTxBpsEn <= 1'b0;				//初始化oTxBpsEn值
	else
		oTxBpsEn <= oTxBpsEn_n;	//用来给oTxBpsEn赋值
end

//组合电路,如果接收模块完成数据采集,那么就启动发送模块开始发送数据
always @ (*)
begin
	if(negedgeReg == 1'b1)							//判断接收模块是否完成数据采集
		oTxBpsEn_n = 1'b1;				//如果完成数据采集,那么将oTxBpsEn_n置1
	else if(bitCnt == 4'd10)				//判断数据有没有发送完成
		oTxBpsEn_n = 1'b0;				//如果数据发送完成,将oTxBpsEn_n置0
	else
		oTxBpsEn_n = oTxBpsEn;	//否则,将保持不变
end

//时序电路,用来给txTempData寄存器赋值
always @ (posedge ipClk or negedge ipRst_) 
begin
	if(ipRst_ == 1'b0)									//判断复位
		txTempData <= 1'b0;				//初始化txTempData值
	else
		txTempData <= txTempData_n;	//用来给txTempData赋值
end

//组合电路,如果接收模块完成数据采集,那么将接收模块中接收到的数据读取到txTempData中
always @ (*)
begin
	if(negedgeReg == 1'b1)							//判断接收模块是否完成数据采集
		txTempData_n = iDataForTx;		//如果完成,那么将数据赋值给txTempData_n
	else
		txTempData_n = txTempData;	//否则,将保持不变
end

//时序电路,用来给bitCnt寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		bitCnt <= 4'b0;						//初始化bitCnt值
	else
		bitCnt <= bitCnt_n;				//用来给bitCnt赋值
end

//组合电路,如果发送数据的数据改变点到来,那么发送数据位计数器加1,发送下一个数据位
always @ (*)
begin
	if(iTxBspFlag == 1'b1)							//判断发送数据的数据改变点
		bitCnt_n = bitCnt + 1'b1;		//如果到达,那么发送数据位计数器加1,
	else if(bitCnt == 4'd10)				//判断数据有没有发送完成
		bitCnt_n = 1'b0;						//如果数据接收完成,接收数据位计数器清零
	else
		bitCnt_n = bitCnt;					//否则,将保持不变
end

//时序电路,用来给opUartTx寄存器赋值
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0) 									//判断复位
		opUartTx <= 1'b1;						//初始化opUartTx值
	else
		opUartTx <= opUartTx_n;				//用来给opUartTx赋值
end

//组合电路,用来将txTempData中的数据赋值给opUartTx进行发送
always @ (*)
begin
	if(iTxBspFlag == 1'b1)							//判断发送数据的数据改变点
		case (bitCnt)					
			4'd0: opUartTx_n = 1'b0; 				//发送起始位
			4'd1: opUartTx_n = txTempData[0];	//发送bit0
			4'd2: opUartTx_n = txTempData[1];	//发送bit1
			4'd3: opUartTx_n = txTempData[2];	//发送bit2
			4'd4: opUartTx_n = txTempData[3];	//发送bit3
			4'd5: opUartTx_n = txTempData[4];	//发送bit4
			4'd6: opUartTx_n = txTempData[5];	//发送bit5
			4'd7: opUartTx_n = txTempData[6];	//发送bit6
			4'd8: opUartTx_n = txTempData[7];	//发送bit7
			4'd9: opUartTx_n = 1'b1;					//发送结束位
			default: opUartTx_n = 1'b1;
		endcase
	else
		opUartTx_n = opUartTx;					//否则,将保持不变
end

endmodule




