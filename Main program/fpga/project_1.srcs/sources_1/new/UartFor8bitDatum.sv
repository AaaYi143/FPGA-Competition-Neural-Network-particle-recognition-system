
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/02 23:13:00
// Design Name: 
// Module Name: Uart
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


module UartFor8bitDatum
(
	//输入端口
	ipClk,ipRst_,ipUartRx,iTxDataIsReady,iDataForTx,
	//输出端口
	oRxBpsEn,opUartTx,oTxBpsEn,oOutRxData
//	oRxBpsEn,txBpsEn
);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input							ipClk;				//时钟的端叿,弿发板用的50M晶振
input							ipRst_;					//复位的端叿,低电平复使
input							ipUartRx;				//FPGA的接收端叿,串口CP2102的发送端叿
input                           iTxDataIsReady;
input         [ 7:0]            iDataForTx;
output						    oRxBpsEn;
output                          opUartTx;				//FPGA的发送端叿,串口CP2102的接收端叿
output                          oTxBpsEn;
output        [ 7:0]            oOutRxData;
//---------------------------------------------------------------------------
//--	内部端口声明
//---------------------------------------------------------------------------
wire                            oRxBpsEn;				//接收端口的波特率时钟启动信号
wire                            rxBpsFlag;				//接收数据位的中间采样炿
wire                            txBpsFlag;				//发?数据的数据改变炿 

//---------------------------------------------------------------------------
//--	逻辑功能实现	
//---------------------------------------------------------------------------
//例化波特率模坿
UartBps		UartRxBps_Inst
(	
	.ipClk                 (ipClk		),	//时钟端口
	.ipRst_                (ipRst_			),	//复位端口
	.iBpsEn                (oRxBpsEn		),	//接收端口的波特率时钟启动信号
	.oBpsFlag              (rxBpsFlag		)	//接收数据位的中间采样炿
);

//例化接收模块
UartRx		UartRx_Inst
(		
	.ipClk                 (ipClk		),	//时钟端口
	.ipRst_                (ipRst_			),	//复位端口
	.ipUartRx              (ipUartRx		),	//FPGA的接收端口,串口CP2102的发送端口
	.iRxBpsFlag            (rxBpsFlag		),	//接收数据位的中间采样炿
	.oRxBpsEn              (oRxBpsEn		),	//接收端口的波特率时钟启动信号
	.oRxData               (oOutRxData		)	//将接收的数据输出
);


//例化波特率模坿			
UartBps			UartTxBps_Inst
(	
	.ipClk                 (ipClk		    ),	//时钟端口
	.ipRst_                (ipRst_			),	//复位端口
	.iBpsEn                (oTxBpsEn		),	//发?端口的波特率时钟启动信叿
	.oBpsFlag              (txBpsFlag		)	//发?数据的数据改变炿 
);

//例化发?模坿
UartTx			UartTx_Inst
(		
	.ipClk                 (ipClk		    ),	//时钟端口
	.ipRst_                (ipRst_			), //复位端口
	.iDataForTx            (iDataForTx		),	//将接收的数据输出给发送模块进行发逿
	.iTxDataIsReady        (iTxDataIsReady		),	//接收模块完成数据采集标志使
	.iTxBspFlag            (txBpsFlag		),	//发?数据的数据改变炿 
	.oTxBpsEn              (oTxBpsEn		),	//发?端口的波特率时钟启动信叿
	.opUartTx              (opUartTx		)	//FPGA的发送端叿,串口CP2102的接收端叿
);

endmodule
