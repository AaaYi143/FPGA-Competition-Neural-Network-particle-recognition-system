module UartBps
(
	//输入端口
	ipClk,ipRst_,iBpsEn,
	//输出端口
	oBpsFlag
);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input					ipClk;					//时钟的端叿,弿发板用的50M晶振
input					ipRst_;					//复位的端叿,低电平复使
input 				iBpsEn;				//接收和发送端口的波特率时钟启动信叿
output 				oBpsFlag;				//接收数据位的中间采样炿,发?数据的数据改变炿 

//---------------------------------------------------------------------------
//--	内部端口声明
//---------------------------------------------------------------------------
reg		[12:0] 	timeCnt;				//分频计数
reg		[12:0] 	timeCnt_n;				//timeCnt的下丿个状怿
reg					oBpsFlag;				//接收数据位的中间采样炿,发?数据的数据改变炿 
reg					oBpsFlag_n;				//oBpsFlag的下丿个状怿

//计算方式丿,波特率为115200 ,1/115200每一位的周期昿8.68us, 8.68 / (1 /50) = 434
parameter			BPS_PARA   = 12'd868;	//波特率为115200时的分频计数倿
parameter 			BPS_PARA_2 = 12'd434;	//波特率为115200时的分频计数值的丿卿

//---------------------------------------------------------------------------
//--	逻辑功能实现	
//---------------------------------------------------------------------------
//时序电路,用来给timeCnt寄存器赋倿
always @ (posedge ipClk or negedge ipRst_)
begin	
	if(ipRst_ == 1'b0)									//判断复位
		timeCnt <= 13'b0;					//初始化timeCnt倿
	else
		timeCnt <= timeCnt_n;				//用来给timeCnt赋忿
end

//组合电路,1位数据需覿8.68us,实现8.68us的定时器
always @ (*)
begin
	if((timeCnt == BPS_PARA) || (iBpsEn == 1'b0)) 
		timeCnt_n = 1'b0;					//波特率计数清雿
	else	
		timeCnt_n = timeCnt + 1'b1;		//波特率时钟计数启势
end

//时序电路,用来给oBpsFlag寄存器赋倿
always @ (posedge ipClk or negedge ipRst_)
begin
	if(ipRst_ == 1'b0)									//判断复位
		oBpsFlag <= 1'b0;						//初始化oBpsFlag倿
	else
		oBpsFlag <= oBpsFlag_n;				//用来给oBpsFlag赋忿
end

//组合电路,判断接收数据位的中间采样炿,发?数据的数据改变炿 
always @ (*)
begin
	if(timeCnt == BPS_PARA_2)				//判断时间有没有到辿4.43us
		oBpsFlag_n = 1'b1;					//如果达到,将采样标志位罿1送出
	else
		oBpsFlag_n = 1'b0;					//如果没有达到,将采样完成标志位罿0送出
end

endmodule
