// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Mon Apr 13 20:14:32 2026
// Host        : whr running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Program/FPGA/Xilinx/Xilinx_Vivado2024/nn/mnist/project_1.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]dinb;
  wire [7:0]douta;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7033 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "784" *) 
  (* C_READ_DEPTH_B = "784" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "784" *) 
  (* C_WRITE_DEPTH_B = "784" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 22128)
`pragma protect data_block
mLYW/6kba1WXHLXVVlGbZ/tQWhjnxx1CXS5iR+6mcqJQ9Wq8DCTk8qC5ez4oDuIJ9xsNbC6vXyEh
r5C+b8TL69sCFhaqrMkK/RTzlWDLUUX+3+e76y1M0ZBlOyzMGUvUbF9Ezq/nBC6iMS02fY+DkGKe
YdyhTrPk7wIiHjGcRWE+C7L1ylW+MqpLVXkytlxWav9/uWxVY4QQ2W7YwDiH2WcGx/xHymfAa0cn
jGZK60Xrk5t2xO3bksXlmn5JoJyl7lsSmdvVAj05RFnxhUgqfuiJWQHG4F/MM29PQxwAzbAGVr3H
pp/4g43a/FsiKrCLO6qVHQWUHKeLesStfj9dEI5K0vj+AT42wZQyVcY/x2JWQYl2m06/dNpmVaeO
KdXMj0QMm6qCnrHAQ+n3/RUl6iAREkNUXtrM5PPBZU/yZP7py3cfwZwlVf9D5AXknHAEe4NxlYiI
tlp9e+dqH16D5MRA/Qyr7B7fcZEgP8mrXhxnQmSZeW631qGb1qfBBpBaEICe08PAjMHd4AVsMOVN
CjJPDO+/t2BjUe4Vz/5U5pK1+PpsOx4b6uVSu8T7eWqcLVpzsUMf9uLCCXqVe7dVMvhxyP5rD7wK
h+9YA3XtW5XWyKdYOAWokvpaVVc/rG+XajiqE6woX0Esv7QBMwhY4wqkcrDHDvXD3DtiSa+CMxHt
eVOeZWYg29jJE09aq933iq0IaQgetF4Ttr97IzWJANOH5L0OBLzBDk0OqncOlCjmXVdk8WozlXy6
SdagAQbIsVKH81odTGaNFuzV2NJ6RSMi4Rz2z/W/77ldO2wBvP8SGkyq6lsRuDoY41pYj11VNvpx
wy4WiyRTtN8lnGbprz48RWe8e3TjjfzPT4ZuWmswiDKFF5zWQ4mmfRNvQ6hBKxktsoqt/oP4bhbi
He+CkOWfLdFfXoVnnGva5t7Dk++YEK4iZYPcSUVy7Dw+CvqBkR2DQQzRm4OP6u+Y0RFMiZqr9hXt
SXIi+A+CLfgcWQPSXiXLXL0vP7vg8HY87pxtKIeiCyhCnBShYgGirvyJNkxy4H3YY41So4jFdpx2
1d7oQ/qD3HiQNGpZpygvWoifSVG2O4bXMsuhvgIuFZegNe/UGjRGUYnDrIsS019ALVGen/x5Q8b4
P3vv0SPLVU4U75bFviFMDl7+SVxRmzf+dlW6S/mBK4NAJlrVMhUbcSYvgHf4iSKYv/tV5wCPOchl
6SSzsvT9r8SDMyEdoCCjhescsfyeaAarkkig9HeErk/czgqzeEHswezq2DXL4raeRIKDQlx+kZhm
EWVGqlqOlvks9NZVNKrHrwgLNC/q41pe5R6v/KyP4rSZASZzgaVVIa5HL95oTaMrBzg/7pntVqmI
m54oOF6Fa91/nG80qY+vPrasGAEigtS2RUyOfIrt9CfDbfBf/6ytt504D9jk1xXK2Hm1Y138Zj8w
vMp9BgNRkpWRmZn1rCsSQBV9kPqboatnWipWyZJjh2TgEcJJKRwrsHYkybY4EViP3HvjDjYzypXg
Q5OXBBsCwaxFikRFsyr0/Ee5baQq0uuygl2hRsj+La3+IJsQ3URPdfVsLnEYiwzHs2ZaXx8wanMN
r8n05YL2OUZngZ/G6oFJvAQDGpBUH/BKBhZ0ZbActPkq3bXBJm4mvkR6Yq11LVx7df+5UCZA3IPL
1lAcSXL/4XlseIo7DCv/li6BbnnuaJxbLrB8WUc8l/8nednzFk4qy+CMqBEpCJfNf6xJDAnvkeHg
yqUhphgL1PFm9BSFPmhxbiWGOQ8ydfkImbSVkmp8tJksGtOcKru9aPP42jZrdIULdhkIdB9aeqHh
MYrTDO9LXHeMNG7gnm33z2Oej9R6kJa+A8XG2w5rYpGmVFBL3mff46qoyAUfgAwnFLiNwQuBjYg0
eG6RSHtUtMclqRPWXE01H0xX5xYaj4NIPp5zNqDKpMxX4PhlfHHyVExcJEvHvpNm4QEujzJFWtdN
oxeLg9ttOUxuDkf8D4urhL4rUH7jHvrgtETYEv5FVYRZJTJrmiTWaSgii3SBAZnhUW/iZmVnihlh
eAedtsuGY4Cs1BZNmINB7CZsEMugOhGHIt4M2eA3ulrVhC/+gIj7n1ZzuEZ5v9G6poV13DuV3fo2
toYQ/lB+zK5QtxvJBW2YUlU+P2jbqBHnOkJuvRTjpom/n88PtryYGlzMZLXh05QVuSAY+VEn0Dyq
n/kmatBIwoXGPGFiGmgVpQVzJ9hc197fs+oY1Er7aeOjnNHeKfwZGEac7cCpFVdJQxCn01yY8+ZQ
/2UhV851ccSi9z5PtQH0IDyNrVU+RToyrwDQrQ3QTmAKIDbzzgK+FoSGTeRecMNAl/dYabZTMs1E
C0677OWxGlmOgB2+KYVeF9SRvw1/kQ4RVdYwR7gCb0F2Wh3tpWsr3W3/5vPy4ASra1K5r1RF8ryT
/0PByl9G5ssjkniMk6UV2n8Yb2cEMFq4F31YxP7dIKUxyMoSxD+n9E+IZlhHaE1eR/h0eKl8v/cw
oYfap4tDesaqpj6Vce+ZpBM/2/OPEwZXN+JDhOIZ+GBNGp8yZWvnkKrN7TfA8sHN/FpivHpjuIsp
1GIazN23EnTs3rC9DZEIxoOE4STiSTCKyRO2UjNeZvBHSBEZUxR0KYtCuF+3g7GR66b6+9qJ0dEs
c+xV3hSOlTO/oeiuFnbegLpSJ7oS1uITgkeK/KUPzzc4gvQTT600GkegWxnE0e5GG+SD+p4zejES
N1f7jWLpIFnQ/kwm/JMbYg8COnMdA//GNGJGS5rosPIG6ob2wT/yXShswd0wDHou2gMoyLn9C+/U
z+kacmvk3A/7G8Wum/euggo7e/nZ1QXtllzKnrwkFD1YwEZ8GPZ/tB+0SuaQ4gbJr16xf+3Klnj9
eqxvWoCIIyk7+4e/HtIOHKAOVlSLQAvYQStm7PtpY8pzi41EQCC0ZQf8NZYFpSAaaqAdTSMBWpuJ
qv2+XZuP9Q4MwO98yQMCKaaIDue7xYRIOd+f9iXdgugQAuLCt+nI2d5jgZBbC9BQcz7AObqXawqk
c3FsKSX6pSM/TRfNA806iBMBktitYMaTTgFUrbv0OEAVlzV1FH3syHDNX3DqgjKVMfU4F9WdMh7G
h1rLwTFk2IirOyL9eJmtUfPh4hdPQuZQAq1O2fdUblwrzEUKR5kY0AYxTvclH86qls5MqNMbBqNZ
28seDUwC0Rxz/pcXy4SyoFY6M2SVxD3oVl/rcY33wOebRSxAQlOIJOvQuamUxBgSYe2j6+OJkLMl
z5+BkuFnCwOktnApzfsYLAawn95a/SX4dWmn008tvv+UM/hlBc6cWYLEdw/zHvyr9Laj2l1tFZwH
/UBK2DycmUYhuVPHH6DtLD4kAlLy0Y4okBRmIZZEvAShYhAR7CG8dHaoKEStv1mtLXdVpkG++l6n
SfLF4W6MeO/0BADKvTbC6/Sg9feF3NZzxnB1umMxE1ITOG8uplfhIWNGVBoFPnBQU7y2/IzJwMxm
7n+l5ExBg/hAwR0mAqqO8MTozS0ZE2fDNwluLeU8Ger/LcLMU71j4Tsf1uNK9vqK5pqrRfn77wnw
1PAqsI+JHW/AlVWpj3xsmEyCeiptKm3AYr8KPwMwroyg3s9lhrwejsGLKawKyS2TFVlZZHS9xfDi
uNFoouMY0xDDLEXWxNRcElEVn+NVjaPtwDxP1neo0+cxQ5eyG6uTvv0O+SBbr32ahZFCx74ZDiLq
znKSIq58NAdJ2wgSbNHr2j7Yk1eBGNZIZsvCSgU69HE9Eoyq4VDKkjOgLyaBr6MBnjVaps3pkHtB
k5arlMoWX+QhYeoQcCAHXd/OWaeImbEzOxA+pW+RD0A4VflaARl8gExJ0w1R26O222gSEW8dTm7h
Q3WrfgunUr2K/Dr5XV2EnllnKmtbXjd9OnxHm5DfwKpT2Jum1hciBrG++fUGdsMBVdt4zqX2Scvm
5D9IZebrz5liWAiRL/A3fhorsL52vV3LI/FeYg0AA+lyEQ9veBMUN2FnBeLd8L6ofMS1MwjEK4ws
xMYeC9FcJvqwLhvCdrwaFz9fD1BASrq+KFHNvR01Kjn7NnBvJ/F1bWTK/haM06ZkVY/Jzz+DdT4m
Ijx4atFRm/Y44VwlRFAr0/8wHlzA9tb+MOImwyET0dW7JHffaQKLygD7jeIDI3f11qfKb6j2SCgw
fCOq6pqDmg44hNu7EnJt86mpQnED/aOz55XxF8uu1wdnTDsswCh3ThqW5jpf6XtUE2yXCEixixaO
/D17+PaoEdJklZcoDkfEoeClEgslWGjc7xUuNGCGao/7SI0fibmAuH7lBAj04OW1cg0sMEGtGmtL
WMOxQF3MC4mr+0JYU72fSDYvr399MJBOpmud38LkYaJbYIy78POrJZPd6HyObRkDYP42XLJgrTW2
hRW085r3pbUAgVHbFslDryShcITGC+UFfYYniFkxu9vLRBL4HPXgAEKwvrWoyhKC5tXKfpIQ5U+4
UNR5kMtoUyDk2sn6YRd7ke+TZMJj+G1/ZOU3+tuQ3FK77omEDpDLwIvmLFF9d4hLklaTLW6Hs44U
JM9zxa23GuCh/7nEwT318hkYaUnwsaHH+jDrppQLK9tIek+Bdm4nzG8jCcT4ufK0eQMvRMYwjdcc
Vjg9x2DmnMlVRd8K434gIsWG6pOY1q/be1+DZPlS3ceq02C6jOuwbWvlwhW7W7gBD+TCyMS5rZdT
k5aEg5WKXzNEnFHfzD0ULwXEnxPp3sh/heK8tug0Q52T8P4mGt5MIe88X2j8DrKl+4pAfw8ywsUf
Vr4z7OTFEK8jF3H6vrZYebL0z6pxcqQGp3KMRkakHJlv/nZbWYdHA1mS86xlmXdhHVgqsEoMManS
x2MU7kTTt7FUG+41qIKfl3enYFGef0qjsDhNOYWq9pWKshxat8bDCcyu2hJodOOd023IzH8PeLrq
+ox2Gs1J9jDJpYA9IWESZ1SZUfGNfaoadDk1wMXvlTggRq8EEg4l/pE5+0aa6m81ksORS/9XMtMK
KLat2rsmb3RawDKfjkPs0WmTWXQNW5jgaqBMKlYsOsRmMh8WMLj2l5bdxA6joQehJDN0f0OeFP1D
L5WDe3Kt1EH3vN7Cr+DM1r6tJWTuTYlvWA3mj7vOkVbILzFx/v3CRz8YvT0EYrnKGCaZtoNKrtN8
f7itfh0vIhetklQ5M/Y7Z0w3RJUVVMl3TL0RiAJosyuu6DLbMX4P632bQgDCk5pJ9yLu9HcstBUz
U1/8476ZBIqDHrMFJkkOHBfWffw+SV3+DM7JurQQv6Dt0uhBRJ3ALVB2pBrqdZak9SNvRwTA7dxi
EnvTZ/kCi76MT1KVyvybLPnNktRp8pMIomIV16VN9jCNgJ0RjcWlBpo03If3rYKXEbfiz0H5PWXu
pl8cZ8+Bmu23jkpAB0Nttds5n4rNFAjw3E5smXZH1zP5QAvXJfZ7jbca3Xogp1FIVum8J3N9pxK6
y1/x8iHu4EH72BY7fL7NN8dZUNPBjXmKyES/d+jCVIQ+vZtwOkYiWyfhKIDIV6YkEYkHODQjK4UR
dGLe1vJ0DQfRX+/VBfXB08Y9oEJMpwXSNBCeQ2V13D5dAhSLvtczWikrUR4e8LJ8Vd3YTGlXYMOt
bWjuinfWyDx1DV1EUZHL7Rxqgf8vfnmxcZ80/d1sLvlZVzoH6JTr/bEtzc3LCIBa5QI8DbBCasMK
s6z07iaAVI0YBTVkf3cmYGJOE/Y2AvLOnTG0ayKlK0dBoiHCzEyb5PVvD1/YzKrFzXzDQJlibUMR
MyM07G43+fqiXlpp4x5PkLibuv0a/PkV2MO3blFVmp9JEoVytAZ+5xjZSrR+VzaZiAFBYHWimV1G
dtMGQzIRFn3MhCsGUFMEGs6lGh+e7sLLMoY2loO+csm9tQRyMToqHz+Gm77c4p1L2U0mRHdJT8Xv
drWHd9+s6UOeawsBpSudVuLSqY0vJ1NEsommDxgFuc8kGEI9nLkOSq5YATuAHtu4W22zME6ulzww
WMPIR263HOVSMYMoPEL/zaAILSXEKVtO/W7xnyI8OF6lpLHwLVq3WFEb2s4hHu06Shzn0P9DtER7
LidOODsign1HlQyYmDXQgGJc9fHDm9OGymxdSPhsVXd0Tp9W0BsVxG1c+L/D5rS82y60DR85D0RB
CjitqZPDBDSrzLoVA1awXpEDDxrGD1E1sppepY3peRWONrKqWTf1SSYgEtV/F78L4VviaARTXEic
n98npUY0ZMB5+08MKcDbUFhXW6of8RxwnQaM3LsIrYwYs/msWbZz25dZx1G9XDHprXBkRWhTns9k
C5oaJygqYA4aKcqu15cpEyi5FIUI3qW2LpM/Cc/0wWGaL8Sf7k0CwawVgfY1WiOF1Dqj5a24lIJq
ClfafBy7yQAt4XvUx066T63bkg520w13C/LDrUKk9eWPYF/1ovBL9HKKKkw5Ice34sQhtLKB768L
DaqwpdcjncX6645Kho8QvMlaq4wkppMD7EH05jIH4IK0TQE72DcKZySnrxeWugi3PlD0kroI9PQA
drvDumhWTAnhQeBWJ5Gshf4xJUK9E1WcbCEEoA6DbL6wKbUal4r3y+xY0o9I/A3YQ10qZ5PK53ja
0rddyoWYH9pRfVkwKhqrqapOb1L0IwOvPrfGsVsPMfSpwCbwu8rYbBN03y4dxIZrrH0ItDC4OwJM
uDCTBedRwUk8acYseVzjfT4tqTN/y5dtLEtg+zwYabdmU9GTRKqtQqxvwV6GTpVNNSTUH7s08VkE
wYSz/7vMPQ68K0bk3mIa/CwphKn5HMdsloii4XD3d8i0A9K3Q6+WhGBqMakowrJOcPldj0rXjEtK
gwegGXBJ1nuFbSkAQQ0a/Cunvy4LFXUagfjmCcWoWwp5kNhQP9cg3DZdMhB/daoKYNFDbnBpGh2e
bxPOYatyV6xRW1zwXHm14Fq93+KUE/5B9o3G40gzJIcadkpOFG6b8xIDR2xYHVTSxvHn/DBc/n5D
+nglrFp5iY4i0xDAkGAIhUeM2J0s2fMUPVW7WRpXFMiK5Dp/1/6IsPvlKWWpDspzyfgE/ZxEfG1K
GTkQ6a9DktTun2NyD5CB9+evt06YgfPz7JpILArjAv/AKOp4PMNM4PD2EbwWeEuDlOEdEyu7mX2J
CoJ22cFV7Q1Uwv2F8V5EmT08WtODR0s8MgI8EPW+rJmNr7KCVkfdn/oqV+j7tL5Pnh19t49RWyVe
LSplSKtdrjs9lW8ut2xCTkG3nGUDV+P/g9EggygKq66qEIW4kk4LPsudiDlVT5X1OmDPczBm/6Cs
Nzj+rOlGgpZtogPZ9nyi2nWITIwjXFKmHfxmLtSvz34hwZomv7q3GfORnfp5WqwtdlJKbrx1F1+J
Tpga1iMZwwD4jgxqAtLI3pt4a4XbSk1kbjpq+ahFmTSgV4IUSleUNNs7E5zxWnNYOiBILT0vb6Od
daT13JaugZmYrKUMF/sBpiAxNauG5eXcwzNU5mJskpGhWVyxv+pZBmFhjHCWSFN/12CV+yCWNMOD
lj12c/Y8KtYu5hvOJPu81grlt3rLUodJy3oC1MenYD9jBSvwbQQ6l8i6zNFVrMajcsb/mjcmNAKD
mGLJgkXiapcmRFJ2UQW1/a3FrzTK5zvrwtXxEn2WMBrQqyqtnCF6O/bc3kJhM+ADFbhnzR5HgyXB
yVCoofTYWcsI+8oy4GqJ2+TZZEKX57qw5tk3JFeD4thAcbUgfBgmXbG9bJEC9zG2paewLTwFn3WH
YdkyAgm2ueoDUBsys/REbw8Qf8ZpfYjG+s6kJF71T0CR9KMCNkIxFP8VdCbwRdipd4nRzYRx8Ig+
enNtoDnFR9zwNuVlRgu+k3iviyLuDwrPwwh7mjZRn2zfpselyLlZGCSFoaZ/jnNcpI1eUpDXih5b
1au/ndMxpt3woGsYRCreODEVMB9sB3mUGAIG7rC/VBy3twQMwjriYVt4BYRw0aBbAnNcpxkAkYC3
cK4QB8/USbxe2ual+hf5PeSikXZivkAk+U0uIOFvl10chvb8KxdIhOTfqfc1dn768n69Y76Jhfyd
h++H6jHa9IU4Wgnb1cka806MtGx0ELzorNRqohFQipm2Vj1+uE2CYj286i1vTEmiIMzeQL0deZL+
VgJwiHQkzU1vyW+9l7K6oGQDwsy64Zl2ax6Y4ib2l6CtGcZAl4aAJuxKQUY5ZKPOUx88jSLwB39W
PMg8S4GS1YNgaIBIno/mDa9ISVbHsMPcXrehA6lwyayvm/u8vzrgZ1XSdUYDmg94cYCKDqLnUhnA
ITEVSSPd2j72OmKXisTSW99TW3n+ViUOX3rPE9M3t5Cq7dLOZHPZzS6rzTINKMfc5p7+Zw2UusNT
6MfL4nM4e7Y88RMTxD8vM5cectprLVmeBWJYvsBidrs4SdKfE3hM3S9x5cwjcH4h0WNqQf59bKzC
jojjYXF/ugoxVz6MwKZ1rxV2YZE20fmmN8JKSjWjaP9j0zZzjQAmD8Lyfw8FsKgq3BoUTaJqEHEe
eZ4pVNuqBhRCRKBGeQtJ0EVbQpIRIhNGd86GmPGpai0QCru8CPsV7CdwfuahsrbUaFBrwjVBkycU
kgbhyzZYWSzgQpepWHjpB5h7BZiHx6aZ445s8BLQoymDVgZsi3C5WUC9hxQd9RVGhNR8mb9Z+aQb
6APScGnuMi39QzOugNqeZLvfwKKwqrENliEG+0I0KA+IzYCletWiHDRAuxkfueci4EIFEuHmu6iI
C6/XMaQr3qYICgdAZpKP7k9FUWFUzZk5YxS+Se/rmktRv01InrPl7lRvqywQ5JQibL/f+x20KNyD
qB85zAfJdUKB2M27qFmH6OZS0z+t1RJFwr2OShp0XKWU5kx1DS6UnvbDchPQzqimI2zg2/adDijS
+c617N9Ah4t8KR5CuHaFPfywjn8AL+719/V23ks1+hFIdAnJm6E69uBmxQcnv94YRVG2+fE+M+Dd
WowXJGPPk3gCVjRnJQHguEL3EX/CklxVtyAXvlhmfCsHk2s+BWZesdr1s4Kt4PUvZs243NAKihdC
+tGP+z0ZZjWdo2pprZzCg0hzT3jq1Zk1MhWZW2mfi8oqVV0jVSn9u9Xs7Kknr2BqjEVqIarbd2e+
lSjEIzJx4lLuEHQGz+WWIaM6CExxCX2iPxjuqjxxnWkc7s01rMx0cg6nmA9Ew2jpl61uJdCAKQCn
TAzh8ysx0lfdjYp3i3p6pAzMxbF5ZhR7kYkvqdsGN/ebwnG8EeAUTRlDdKhGGjJMOoUSlaWC8FDO
8VSgQLUCepKXecEKZuMUYnEooAtOfvXiKD2ZU/Xn4Ojy3hk3DMlqXbrGjHmXDz+c+W5RQgQH/Xz7
Bpgt+NL/3uqrPi44lyfiD6Zhphwk1rx4GLNp+iY17qnQfjfUX1e6xDAS8z5f525aRP7zqI3lXTAp
9UQToc23fnvw65jXgEHsG/B74zaoQOPfMAG2iCADBOSna+nM0glZ3oR+U3a1iQ0IoFdqup2SsmAG
fEUkXOyG5JeDUb9oX3Xtd2Ft1Cxl+pStGzgNIKIEwbcgyM1VwkU4K+OPcwYL5UG6nH0M21MvjruD
MJOwHOnD4ZmX6xqIMNwGrUA1SvevHpDlgZwyHixgfJCJH2zrhE5aDvSWsjN5qJGn9cY1fvb4gSt8
mjR69VB+laF9J3w+gKK0h5kk8b6ussBuK6ONNyifZ1uZgwUJDP4vrWBvFosqBZRtSjWBT7e7/2Ow
OrjbFsMwEPFwKSpSyGr98Qs0KdaJAu5VhhQbj3UKe2tGllAX91Slo6MQfwKz4XbgKboOdUgpgPDo
f7b2tdmU6mpLZUOCjKjk31/IA6EgzDe4JYkEh8O8jOR0eCeQ+mo55AHsXoMsvqy3XYRuPw12e6tp
2K+wu6+bmpbCdKN6t1CYNw38DNCt9QRp6/wEK/wjWZ+JC4E6abIlT66vIDe/XNe1u9CzVrgn08Ik
Ng5x3br9TytxheSyPOPCWmlmd+alhuv/j2vXQr6x/Syd14Um7NN044k2sV3F0ZAXUq5VAmhHfnG5
xYjv13y9Xm6X4Ttz14Ei8oc8PUhgid0YQTjUdsEe2NV+pvgKp43IvOWyAB2RksAn5oLYR5WWl7q/
u6yKbOAVHpZrehMvmfTad2Pv84r4djcrKxWKfb/TGGhi2Z/43+IIoJrEVq8JYgHJxOLEitvw5evD
cNZ8gK+uKZFyeX0n3Tu8Xw5k4sxYZSO55V4T6cwRKlyHc7aTs7DEB8mRCUw0CvlU1InDhe2G1RD6
+62oGYwyZnE05hKwufXmS/jAKpBHB9aVF/rBpBzNravYFiuLp8qA3P5inBeWqDFMnvJRo6KxhVY+
93vEP5g646uxw3qaatY/+6BLvt0iHapGrlxxHAtJ4frG/OgM/Z/MENvi3w7JP/5GOGl2IgVLpOgk
hvemr339a96OHpN+lQeFvygdqj1sAd1UmcZNXBgxzXBL2nFSxfC9erRVyMT7Lxjuipb3AZ9d0+DL
WUhsGefXjD04cvZBjnPCJDq4jrq8uZmr/Lnwr9o0FjGxybCPXddl8erxhtFIgm0jto/tKmXncJdA
05pbiNNI6xQx9S3S8+6qruNlvM7QbUNyJF/GrJWfPKlSa0ztl35AwoNEGn1NHRgJyuFBqu7fQE5O
028awzY9uPuPMEqbbPphUaLSuv4coWa9+M0VA0EV/4M80xJEBvTMj3pWOG3haufel8IBOtikkWlJ
40D1s53/BnVY+cUbfYCCGJ9jNrEBf/BTWxiOzt2uSYhkDiIV6oAp4YzBVG6IJvzKAB60ZIGYaiew
+AKZn00E/uMXbl9vbLy2+yFcvqBrjCZL1hg9cSAr1VTy3YkMjDQsEJlbRmcXeGPM+jbLUG+l9g0V
kGX/KwidiTcNXSZ2+mcA1lKNZwua9ptQjoQPQ10b5m/ndU/uWtK/WkksAxer3h/tG4X8/fg0kYQP
XlJod/JKXSKEFSHojzJZVPu3Cj/HSK37x4/BWvNpQKJk53rEQgyUDOp07kKx4RDGZxaTcDfP4gdY
QrCfeV109ZUFrSOLLFJEr5l1er3PRwU6AOI4Ivqo0pKSc6J4zW7uVDczMHXb6ydKoHAUwnaOESME
Ld/s2B+IFI7mRZr/uKsoKIPuVBTvKYeP+IOtyhn75AclZauVfDopTWG7kHQ6tmlyvAyvEV9SQMPN
kyBO3vjaSRM9S62FznesU/qv0I59OW3htT4OgpSgqvT46GmQv52OTVwghytJaG6B8NjqrCDgdG3o
sl0vOrjqy7oD2Urulk2go0FMpwQ02B4BNv7OM1hSeiY1uFSI/uNlpk3LV4RrAk06MjTzwLfCmHTY
MWSOPem/LeWEKX6PJGXZcEpVUr54M6jZCy1Oetyg7YVbI4xdxoxANrIa1eEhNHPRR31cfCScQySw
iYOe5Ueh0b9hlFkKbmYk1oz2XQQa7DdD/j9+YRmPq20Sx4kZx0/4ANOWjBEGWffnpNspoOyGlweu
zr141RdxSqP4LX4SbhsR+MFtTlT8fp/wozka7pNkjtVu0wK+RlPEs2bTt5kwsNViEA+M/XNHd6LC
a4wQU878kQt6CX9C84PYORRcMZPCUTEIQYqj8x18mUfgP92p8trBnVHbflCzWBkTsiGVl2y/8CfZ
Mz6fOcOeLGgAjKtumH/6nUlYnG6VWLjOsQpgrLvzC0zEKd98UgQXWohXbfcdvPyk78x3O8KRdyG2
VHwwsxyRQf1x/iB8UbKorsWsJ8wTyGceymOjP3QabFOHZdei7rDEKR/5+XrD7y7F0jeFXyAOf9cj
yo7p52B9r6zmqtLjEImyrDpxOoive+XVmYLGVHAG6yxWCyys7TkM60n21O/KEUbDRMS/oE83l3q7
1sYz8MSwiw+lELC1oDvYMjTm1RLG7dDKJM8O/Z4GbnT0/O6Ek7o69nGoT8UQPch3DEJdYEO7tD6N
S4Hq1oZ2GFYWD7o0nPSfjomr3D181vo+L4aZ9lpDc4xbjD9n47QhpStTD8YMDFMl89SCiLzaE/ln
37EHW00ymuUXbkXmy2+qETB6YdB082PRq7iecbzPJXEHfoV7VwgktS+/pf1WJq9jiyQpTePUxX98
xjgL8NX+VRpEjkdNLjwneWUD79Huvs0LNkRyCUfYvnT2p6dOJUDj+hppeD+dBgux3oZQDJn4jUrc
6GmAMNbIF+lcLhuBU+pAtTQAGhHL8JP0Q40LhKZd3C/ngTo5t2vQqpwXHeyVhay54fbxIzd/reW2
GLT1Exv5yQN5jmc0OheSPbYhmItq6m4Mwq/Vf8sqYKlo4YmCLrxn2E0udDHLZqikxFohD945iF4Z
18NtLncO4IZOaeV9DVoaiive8XYKjl/gf5U3gal5vQsNRgRfBMj5XN16KgnVNOaSyJAV85+5QG6m
Gp3quPyWUX1ddpJ9SszyihnPVoR9kkHYKbhSBv1BOq3W4tfGvH3VEhEGiy0DgrDuLISLa0l0aH9t
WSwhuYr4F/q9bpdVRWFcVE81VoArnceyt0KJajMsmcw0N3/Kofo1SbIhwS38eI0KgmAMPZ0LQLwW
4VM7So5dZAwB+nEFwY0ayXBMFU117ysD3eKbIl0VPslu1MVd9WUE/heKOCvKqOypwIVrLTc/v9sc
W6yljnzOoMBMO9O9X1b8dXMKdHoDvIBFBW9jOxD4xBgAjQ+7ySmeZBgT5WD6UiK5XPb4Rgjxvnw0
0QJYtiu9FkQ3JrhHlA/5F0O/tYN8Hd6NoXLbRBK41EsR3QtH/0Q19tngwET94Bc92TbLvlOQVX+N
eHcFlpDhY7LdJyq6BLcK6XS+AqbB7bxu0YFyR6cCs2Ian3Z74kIDqPYNvj1ooGTuOjOjGOpaRHOZ
27J+uPLN5LYimAHLvNZqqsjyxMvYw4w3BMxFgtWFlPvPq/z/GnFcyGNfqXN8UdsjesF8HEjtKW3b
ULshW3nLInPvF0O0L4movm6fw9s4P7Sp6XmDk4Rvmk5CJgEYY0pYt1Sjw0drak9ESkSRbDkWXws7
WAfFd6WYRUXLz/lqsnuyO2QSe3/Mw0Jr6oNFl9C4Q2vCGmfgRQGE0mtHUxPhgSYGEDRDHMLZEP7m
trWaXd3fMiHVbLHSQezNVM/URRXZAeOmV5mmPcy5OYhPz9bJ8nxGFvRp5d+SepzhH//woBoncILf
bSbsFEFZKPARjUKHbbkjJYaCDazJRvmtCALdJdf6jOfKvJsjTG79xIrolj/tn7OP+O3Shv7/K3L8
5C7b094sN29pgBU+TMmr5mspzlBnWMqOx1opVXCslGHtPJlRzPnKBZ5G7wbzZsMLGkDZ750T0sFu
fGMWu9tr//YD7xtgQVz81hnWa9sCswQNAUIrTUA/SyXTkmfg26DBJg2x5xg9CWl8j+33GNmHA4MO
TcNf+kKFpo6M+FkTMefzcnce6yysHbHlEa/xbxLtKvY0Yy5oRX/GiSs4BfY97zvoJlXkTGrbcMkm
kGjKG7IA03ULixGjWxizkcChSL80uUYkbsQckow84G/s+5lqzjkNvppJlFJCgKG2w7uF/SuTQ1tv
1p7weZlwiZQMRsRtC6gKAgSoBLS9adESB7/CtWx0dl4sP70xwtg7M24iLtBEnSS15dkxWNwtswTG
RD08Lt0RuQJUBXXccSVhSywJESPFO4wwy8Crnwj7OSQVw4Rn2GARhYXMSFThjJDjzvO1pvUFJ3HL
owksJhn8WBjHS2ubaG6R7+544ucKlebuOI7uZ+tLrDTfzQ0TKm1ZbMey7Zo/dsoXXo9xtTX1Tz+H
72idGEOCTVFUxmbUdCI3xSljlVv+Kx9VtkXeGe/vV+Ao4B025kpRM1gZL0ZElJ2Pb0lWxVAsJ/uh
JhV6ZjUiA3K7FrSGXOyfwnuyq++oQwSSZ6oAJi8mGT3EBlX9XmHm89o7amGQtZwrL0k0l+XSbEgX
DlEDZPTnBXzobiGR2RXkWepFbo89z5fFAOw8wjq6EqmBta+5pZ46m0cy9tM0EHBVMFj0Mp05tLQE
WGJf9v4fgiPcLiKSY8L3GyGPKdqzNmm+9AFIlRO0KNeQU2Qow5492g1hzmc9ovrsf0k3tWS7Zfsr
MqOElFp4kH480UOjbGpp9zYoBwyvgF2xcKXdq8FIQoAr7ULHyQaDX5YYCrQ/HAMk37rg/nyK/PFf
kkJhVp8WMVqbvkYKIl/039F6De0Qi8YxGH/cO+DUGLohqy1xn6Ia6TdRFfIb5rBmYwuQuH0bO1Xv
ilqPmhtztT0qiiCBfLF7I1sAC2G4Bv/95DHAgsCxLLBeaUQ/ax2ntLX3hLVzykbukXVeFn4uwddX
kn7ahjhQpj0d01RRUinos7QGLuTiXvP5c5e4gM3/Sd3uXp/CJBE+IxtPYZs7sc5LX/jdHqsVRNEp
682HpvpI96iSAx28J6PmUFkZrpmREeg+B1EdTmqbAJki33Ndi4abGmLdNV8gHtxwX7jWUX7WBXS+
hnH05GQoXNM7FaOwUI8AnRc8Hpn3eH4BEwZwrh8QQ5/bANT6Ac8NU2rDBo4twvlTYqAvima5x1l/
ljaCp+kiYG/CCyLw8ZAlkXCI/KFyyCJPC8uah/iahQL+b9Njp5l4cB4vgwD3KV9hhV4sArj8LGvm
3kw+pIboSRFoKs1+d3n6x+2qlZijRc4T+qUCspN2oPvcakfYE+LpGj9CnLZmAkWpXgZ27oZ8AFqH
nS1JO+YcTFDLdjHdGWvAhR05MVODHRzqMDmLkdsxu3WqRpJXB6uRfEK5C1PIBUaWE0HVjyxkWFB5
jz050SpbcHoRFxXqV808WM6XInasrVZATKhQSxntlpYFaZzjuyQRzU/verWIuFi4dlZ1tqNvY/XM
zraDY2d/FAtxpK9n/sSSfgo3l78VWa1mokZG8vNSzGfao4EtCzh4paae4LTKn6oYJTb7d1mmtJH3
Q0nRIlWRbJ4QbDCDabmX84BWUhT+G7IEBAQt30E/F2GouViIqwUqzzwmH/lmsqH2Eh15Ss5U+Clb
m3L6EZ2SsGrVVYNhKQ4syBFnSJD4nwiC53e3+9ETOrUk/87lFSDKZmIURrUDBmdf1PiXyz/Hgkq6
jAujxtKdMq6Sbt/XXY0A3s/updiSpt0d+uukeqvZurhzH2RM7ngNXO8HIqkbhXfiDEWruyMk7e+h
ltlV5fWu/k2fvsH9Vm2Zp3eSPepvLgjZq2JQmfyl3/KUzl/oB2wSyQylT1S7TFg+Vj8j+Mnzc9bs
JJ/CDC7GiMqbwbxh/0dE3WtdTf0ULPRqUar2CD14FXub17PDOQ+UZm69HxKRvdBB7eCmsknz6Zqg
b7x2rsEf/KH7pMy2j6amIN0Cq/AbFFMPaK4/kCSgyxKPvgGFfKAwg7Kv/Euzyt6DhefRVAbrRjuf
Ww1Vp6Ce59VLsGAMzuhkGNcNtPB2/69ZT+hEncDhhQAPjkYLVSlay3ldCNW5MXP6inFV/4i+XGQT
q4ygNbSEsL0d3nUHgiUXEnEnkbYG4gJlONlRGJFa7JXumqmJlyKK8yMgtyKSi9dCC5bbxxdl0UFh
AGC2VQJNbmIezkhNL+qaYEyPnRJ8W41yiZ0rR699D7mQVFVHy837ECGDFleI5LQgQfUJ6mvtktSF
670D32DKRyE4s3OAwaX+BlgBXHAQxHULJOldNyfC9zNHWiikvhcYSE08cLXyMysepdGU3HSugVYE
gDENK+O1yMsjyBnmlVWkh+Q7XoDhE36CE6mbHG/hnS1lpoDjEUve5+arLOYXp1/BOvR9Sibrhk8e
xDj1I7UTkn0l8ov9gb+qQ7WV99Pr/R3/7o0VgAYUmrAFTR5meC0hSUXMQfHCdScdoBJ4rnATIB2E
aFFiVioIcLK7OG8OF2EeT9LoVpFZYaonTDy83SywSPKP+oUA1aPRc71UCyI4Fz3wBJsmAAldV4qf
ljxEumFAPkNRTF3K1mpVOIPbyNfo9yPeHkw7qBZGCDtQ56kyHiM/fcNy2d8HRkpU28+p8qUFqc11
mMJrXEuGsRYsmajM7osEmbmC00Wn6rq5VbI1d5Mj9/ew2FnqUslUgls+JxnZL3fO9DIk53HajujS
nt/l19SK0pPf0Z1YhneL2MfyGgaifXpGB+60hSyfk5+Bp+iTsKA6MLpxOkJKan02AXdSwHN+6rv3
NduzD3e6w3c41SfME8NwPinehLV3pzk3LIShFi6rjPH+R6kC7JKfu7RuRIgKzUkcInM1f50+FSOs
NMm+7L/femeG/MM6wB+YOzMrJClq/B0uUnI4soKmnLyo+8UkK59X5oon0WpPYFvatRo9d3HVapiE
RL82BsT/Xcwbguj27lCnNIGtxqFFwD1JgbBlQf6qGSadE7XKCiwTQGDDXFJw4UzQcnPveRyhbOiB
4YMppswrJ584kvSLg2b99/gcDQfH51UUgLPFd/HHsUz0cdJxERhlbYmzdD4ipMJu9z+/I0qTvWgR
SathIFAGgNUIcLwMBIJk831YaUueQg4QBQ9G8M/Uba5Lb/RXbzDer7nG+k0jw1LAzO7aDS2dAXuM
c6l2afNiHY/tSTL0EelNz5xjFJEpzEMURm+3fm0sOGwbHexLv3eonGuTJe5aT/qN7D+qOaaHGaqr
yjwj0O7CRELntKU6tlj1Uc4UB6FgGAdkaXR3O3JIHCJOKdjZ/yDHg9ghNa9BAPhOTxsI/s2b2kKc
Uvg0eUQNlgSGz50046cTvpUgs/6bIGRQGy5m57ndGEUzOXpdbaU5sYb/jdIdNELTDK1NGCkqxYhH
A1pOJ0QEd0ZXq6/6jiREzsu73j1IzOiKh3T83mye0uGMd66bf/TouPtYbYt9mMAFHSQH2lmogD10
EHvvrlfMES1bVAkfiVHRAbBiXludM94Z12fWZu+SHrl8wIjTwG7IHDLJ/0uBcWqFry9zrgTcxGTG
Q58Xx/TmZp5y5tan0sEWmfDVR7L3/5CgBxY5XYrDyooQt1CPBMvCTDSzgJEQPW678D30HKfc1yuf
c68R6yy74YaaenmaDRnpVpp2I2QtlTMFJRwhakmWXgffOXMIAV1YX25nnMFUT9YEV97taoHZw+Zq
jbJ9kOiUIfTlM6Pb8LRtXHjACvN1S4I2f6u7jc5pMe2O3WX+qmNxdJfNDv4CZvZzh7jT8Vhh+AKh
dDqEpVqbTMVBb8GhzsSKaXvAalO2Dhi0QT5Rr88IFJqUEdfS9hryEeeA2qngHVh0xADILAoNCMh9
4WvZ/7y6etkhHa8S3vSVIX92lXBt/b8da+S3+vJuQQJlN9VQAhWFXnY9dDyugDw6AoqTEE2iaWy9
s/0cEhunaYtCZ/iFWmYr3bRDcwiS5SFcXQErmUsDawrVtNUvwOAyt97OqJVPVNsOHlARMVJL7C6o
BcpvJMa0i7jpw7cXdMWd/ulXXDe8MqPZBeN39C7yyCotHFjvx4ElyzZ2qem+zcrhVi8P4vQAiYcd
ba3CzMScxCYhfPfpIgjaLIPPm9V1pF6ouF7sXG/Df1nj9PcTNmKe2gbYJu8s2NRP1z+C/lSnh+vE
OnNR06Tg0r9UyIqMIbVANM0HhHivcf7nj/Vd1qMSBA0ycXVD5wl11D+x68rG5t499CB/bCZrQRhI
tIs6O6z4kT/+45Qm9EBqp0R6K0QO9dP29O14BPM7jQSNoRJvEOxE849G8++GKnus22lxqnK/O9Le
z9VmYjIYOmUSt1rBpo9KLRG2dAiGLyMV+vJ+Q/4zbUy/haN/fV0O/Tu4fycjpZRSUKu0P4ZY3ZQt
2qdACsuY+Mp/ySVQx1fv/zcR9FlRLySOpG8deYOp2tjqaZhob0+kF2oGspoSY5xdFSivJBvQsNgM
dLneQuPOBjeDPTv5EoIJbFBt1okoojyH3ObwKERaoqPuQDoaBh/DCLlcTKPa48MmyX1cnEtq3EpE
qphbmUWvfJGntsnSu8Kh4bj2nrsadVM25KPSKvVe7+Mj/YmKFdvU80HUQEilm/T2dPt5HphnaM0H
0pwy/yMwK5Kz3Om5uUeaRzRTDY2cJUEwcFiR4rOBbXxDIx/k6F9ByXMuosWAJj6Qk1YdVR39DJXu
+wUi9RhK3u0hTza6eYGZ92cd3pMVF9VQVMH3PEYuariJxMR4oxKrkHfkC6FHX4nlJje/hesVd0f7
bI+oCHnVZQQptr9v5R98TrzLtTAW69GirGLXPnbwoP+fCI9FhNiLeIH9RxMEB77m5MSRyrL/wuhS
sZxRm7doqi61PHCUWmhSYzY0N1bykRVWVNXgQge39XHImrgZktJWxDoI6Ci0ouVhlM8s6ceb/RPK
mS+q/BGM/XklN3zxYt0AboRymnq2xaQuVRunDqrsoN1QMRfVez8XnRuT/niNKA95Zb3qeDwBRW6w
KraAfRUINqLVQwPC8MW54DYw7iq2e+ZVHjQ6H6r609H5onH3B83f+1xT5G3o4xwkbDmi1YCHRmtx
HjlScct8bjmXJZAKPHH/HaQ26scBI2Hk8cl9PSdKjooANeaatrKFHUloIEtH6FIKMnZ8QDabV1WF
pzLAV0+W1bda3EmKut5WYod6cG6tAWlS+bpWl6kVcVadBCiWDf+sG6g2q2+rYEVCtCLFaFucZhLl
bGEpRv6qKg3b6HRE8A3W5dwGRrMIbWyKhkGaS1Eq5D0563sevKKOmlyzFxCUnpY4UJAhja81DHiZ
Rsw0Fd2BAjKo+c6gkbIrtjlIbEZsNBgNvj+yx4dhvboS/QmoF3umGeqDk82DkDeXqBe7RvNcq3lB
COuTwhE8octSyhptQMHnEaZ0uRb9K7dVf0H0kBRLk66sC+i32fNa8T7fotk8CceJIuA2hufAUmFx
Wr3HbsezID8SPqA4FJ+UI7ffjv/FCJTwlZOYK/hbjMpZQL9YrO1tzQLRurl4fdpNtQIM93ae1vBS
YPMRwlIh9hGBUkuVCIahPv8SVXEwyhFMu9H6sIuRbmjORQp9Au5mC3DiS2fhfdrR9dLjEqVSmlJR
rpmSEtv3uN1gxUeNnRmogvsK0zy3/V45Lcv51Bgz9dG3EApMeDlsTKLxof2URYq7PdFbctqsqGdK
HaDqsPLGSiKs4Y7bESAD5Kcn0m6EYWYVlH+AC8x5+fbuPHdXwgYpTxCqQrfYjStPNDmzH9LqRA57
4JzTKRcJbzcnhZrSOaudsHMkUf7rurqYwcyW9BjvuKuIbG+3+Oz2sDkNg+0fQNLPsZCve8MTTlN4
kQyjnInsIebqJ5PHjC9jKEmEGAuD5dQr5vdKEVDDsAcE3FCtcaqFKH+vxbkRrhEnQeRuUtEfzHDB
yDU2ZUtIPD+gJHXXtwOdulXels9EcIP6ZXWbHRPPx57n1sP4crOx4ib2OMqPABTtcYpdj2j7qzY5
XMTWWZGQG5vCIKUlGJwPRYl44P71Df5Tgquso7liy0Ci2Vz8t4yh3BOZWyVA3asLYZL4H1PFpHBX
40kdUr4w8J8Plwr26qA6FDugRPPz0yi4uCQzgj5dgOH76hSaGIeFV090uncEINVFmWF8z8aZKHFm
a14ZaQgGZFMy/CPVft301X/GMcj2rXP53VClQkSEoy5IA28kqR7ipj9Jb+7zd/e/Ud0HpO5G9hj0
i/XExmE7ExlOM73CliXovJ4e16SIJtNeeOi8UqGHz5zMLwutzTeShL7ZAl8fFnxRGAkZmJoPB3Ej
i+WQLJtCQIlYFYRUqWRcTjlAhJO2LKdtVMrzDSC/plI7qbJ9ZLQ9vNWN9xTTs1Njp8m5aAoiYzc0
+IRfv83gGf4XJPCz82xe3nxV0fCIY8kso0qMdm54mToTrbuS6J2DgKywxVTEhM3hgcuRWECTmlrF
zMCzMPiVbom0ryjOMMfuGU4ESrN6tiFK68poFbFV89PPyWp6usvk8Isf0XFwWpzMni7mG6dlQCwi
j2WkHwaH//yzchDkuURe4a3cJaDv+vyrXuREwxH2RNWzFP3fbm/294six8oAp4jE3UsI20vKdSg3
LbxWLLdGbWWLuS5HoAqeZriAAjH4BUTETnyrQp9rExN685CmZqNM/qfK6y02QrfBCLsJ+5hrxrkc
eMbbxybYydpsxpEmA4UpHN5kvbhuN9bq7KeSxltr+1sUcA52g4+lTewLqPKsy2yZcunoWV6EqsDb
DuWTPO48FjgUR6S/6QUsXSgZGHz4TO+9HAeY5yV+KrgI1CK9DvNGFZrsXs5sj7PmygcLCK2CPvfl
tak/T9FrYGFJvKk9ozRHhHQ+sTqr827ptNHTm29eKICp3GLiSTNwokQYLktFZXL4Yzbmty3VORYj
2WjkzFC1YJkvUUuGIUQhe/PEHVu8HxHObAKCyxRsP7OKxHfQ6G1UvWsteWJ064Dxb4jKx8NZBdtW
gcepfTv4yhYiHA/WmqRbKwDmlx0/xlI9o5A2/9kEkNpCuqcL4LbVdnM3oh+dK3fjdE+YK+pP7SLi
NUQ5aPcn0f0S2RbZhSlSZ+PIvyj+RbzM7YgFopYdCggRZMNSHfmpEYkQQFz53DCePy4NvhLQ7kmR
GOSzM3WTw6eAJcdXRKNcbYw8cX7KH6aLzVgnK3zgaqNI9ZH1MxLpwve8rwE43TWwmss7gZfqTdY4
8jNb8t02vp6DpaPhrFk6uey6r7TqJ6x+0ylJwfMWzPSW48cXKaZvfzXuhQQIAHoJe2qGzn5AgSyH
bMddT1z9ZDVbkb6aaEOyI2R2+HSXc5lVmP+ogZSYh9sU9H2ea5AkFcKe+Zo3LZEdOQ5aJ/c9s9vs
ZEk1fBxIGH7YpqkE0A1FbyyG5s1bSobdHvOKiX+0HPSF+3EG4smwuTg0SEv1FH7uOg4haJ0eSpJZ
W4+aC40d0n9KeR4dkUT6LJNd1TKXONCNDfUw+60EovQXohy3SA+Y58N9e4U40ugfbJ0wk6v+P6qF
0ymMpQtW1tLzlMXKDlSe7YGgDclZspj8yLXmJs0uD3DcjBa/RTCHwULqELMmFu3V4gRaZ2yt6UBv
T8qqutn7vEWAcYnW6IDPZF3xb6YxifMzT18Fyv2EP4HQL6kyArK4YFJwtvfSz7Qo7xwgD+1UIVe4
MDw6E4JI++zyb/M4g+59L37+bf7LzH9g8wTBKCdIoUl4CM8FNocKDRgFs4MZkygmzCIfH4dtTs3S
1Gbn+3eOA1Lh+ghKLWEttpTLPyZYzBH2lAwprXxEtoOozRHADTVObVEm8G/VUBrQUYoOmc0wGzjh
VmLkSb04Ed1xbcWc3EJ+uN9rFtsixh2F22Fjd+6VudC9nMW6Bk/QbEdH694ONwUE2hYXIHqs+NJ/
C98xWPglWoQZVsCMhEFSZxQfTT5931rtp7DThPkrGT+xlvjhFRQuoG8yw1s1zznYdWwrh3JzGrRI
TA4a2GNWGjiwALzzrXRAsfh9d292EZLWWCF71COhyNVqLc6TXavc14DiiqSJYpFTMWPzsUCbV37u
PmoV1Z9vr5q4LviymZCr63A272akWkrQa/JId3IL/OxEpYfFMillEn4z7jJosV3zHOeOJ/n/mzzU
x2x+rEb4sxoKUn2W0YK5SjH0zlUip3t2FOFvGZpGqrg9ch36iJdN9lvksgAWcyFpaR5FbDwRW23C
dEH4pbHW2o8to3gUOAYAL4SRKrLW7HQQa3UM8bcuDdm1f6cDY17seLZ9I9zczi27K9ax3FjpiIKa
0BU3HiVEeRokFsbbJG6XlaBloJDEgkhi5FPygro+xNr3mCfAKVCCv34sEbx4nDBg4PVdO6tx593R
QnrIgsmQnpvKZXQZGvq7B92jnW8dexFTafiZr7kv0PFcxB3WynhJUQuBYn4vXKj4j5x+SpRcMuFX
I9OuyC1/0kXjULI03vhYp18tsoHR/icgV1/plNPRgJ1INhQoTvCmK9KYeoUcxZpouq7JBA6YNk57
kE+V0oNMS19WOmC/acIoG5Tu1AcD1f2pVCBCeUVM4Wk269ny6ofXy6WjPPJz0ABqjQoAMU1qmbP8
8JlgwBGEVhNACo7oe4akc35J7wG25EY+BPM5qYHpWKJDrq1u8hGZcW5dYMGMIC0vh845Yf+OOmo4
jmfxYQm92lQ3O0MNwmI/3X3xCD9TXT4aO1jc71qvP7ZHqioJKdjBtZap89B3BlIRlP2kKmCmD3xu
vjGdqy/KKEpEUpWbcDAqOEbd5bx4iTpvIEKJH/VVZxBNGepL4mWJac0DLkPbf8yWSBCyUUt4s3Hb
hzrK8y69R3uVFnOvRU8SkkXlyMgMI4hUUhVJvdowwjs9b3mMl3u0s8wXfjtKZXAl8b5XxjZupnIZ
jASjqCofmYoBV669kP6aFxUSkxQhrc8p0R8t2uUwd87qwsCmHxdlJAqIo3v5EpvL8hDcXIhNTr1+
3bXl+HGxcz8zDq1LxNRxITYn3sTdS5QCHanP/8GkLm8hO9T0kVxsuTIzyV/x9OZJcWR2W3UrAI8v
qEnW2JO7w/7I70F6HAZAf+Rxo8CpBCYU4nTxhfJnDdEutsksZZwhe7HZFN0xtz4yy4p6BWNK19Lv
H79EpiNA8tb254hBtVNndozBlSg0UbBFqokRgEySR1xPsqF9AerdBPcyAPXt4vRylTe669zAfdbV
rSwxFFDkdqZUN5ES3BsIgpVmBRh6kzpWjWOv3j16yudHQFcXJQXtzVy2kRIN/2+EwQq4AVrNlqcT
92U/k1TJut+RE2kMpkKC88PlBXDh5/NLy+eMpFp3oQxN0fhbgLw6IRo+R6tRGPNkRx7DAPgV+n+G
xZXiuy+2yC7zZ8NW0XaIIjVDq03J0xygm2Icfr0MeRapzSBla/SiVvFGpt52o23hG8p52HQ/vtyx
RBbOYPLzGOugokuhE0s91mrpVIApiH9+QJfQoDEdzRLrPwXM9LiRCfZaK8A3AmcNivngmKguZ6of
k0dyelVdu3lEqlj8oU3YQzRE8r5jsdFV3iTglrnU+DXhpvigNGAWxT4ZL0K+pqup+R3WJFW8/Bi9
twbEJxU5H+ywD5p29kHEi/oakRggkZt/JEVUqTkpWgZrZsLZIQuxqbZiRNkmgEHxqzWyhs+g3gsF
FyiNMh3KLNdJQkm3JTMvEOjrV3EVUK0u4tjOND+hLDkWzHivpklWWwZwja6/o8mz2cguFCFGt7bJ
2aqLQoVUgVFNbCPEq8+MZxZFUDuKn4O7nt4No4DdJ+67qGFZSxLCBuVKhnPwWa0deSLRnfJ5SpYl
zH0O8TeQ2dinqHvPUmwIcCw+FbyOPgenh0SVID2nidl8msHx7sJDISHzC0DuW69Ys38VCVo1/Zcm
N/m8pjNI2baXzRfrLt1D9uMgBDTKSiUcuysn4+wFPcxQ4aN2Cg0HyBWPg8qOz9DNQx8H7zHVP4Lm
p4EEMoTa6lXd8nHBTgCgGuRc1nHbX3HE9imDFgn4MD1B1PJp2eIfZUvrK0riUjfQ9OicXPCKBfRz
ndtefq/ZwX0PMlNSB2U1rUi1z8FbF6nEqdzuAhbrjPnBXDKdOswfr0caxqTZaVjR2JzGm7gSl+hd
h2H4TKT+4E7Yy0gGD6KQBY7UiO4TXZq2F2Jepafsf5clCMiJYSDlVOXwRowV3EEJtmw8GIwaoykV
18mrf4hUA3vsIp2AwIhcsNd9R8yLNUdupoa6biR4G8uHoKtIasq6HvABdZdw8MroixszelwIUeja
oZ18drzuDW/SYb85tZKFRXZ4iLtvn6dtX78yhSLcR3Wj2AknpdUDWv/aqCXDW6Pk/hrT6EzAQwrE
FYSE6314ici0L6yeolYuMwd2SL5dd18kmn7p3dLq15kh3goqM8WLXljmBRCUX53s83d01NOJYveU
VuloN7UQw+k1bH6d03c2Vf43837tOdYGr16tq+TEFkxD984B9fjuEzOi6DRt8KrAYVf5Dr1NJce3
gOKiBm3XSUDqNxkc/+OgLDvZ6nVJV9r5aeOstqseFZ+nmtcUrMS5XfHjDbcPuo2OrZ2JtUwh+nz+
LmGidcxldOkXIgH9ZHXpnTLW/uGtxqiDdBUCB7CR7/kbnfIYhmBCbX3Jd8QdSfzYOxdLwFTOvsy3
64KO4HEIx4IsDaaE1PIxQWaMSw9aVVOOwkn/BECWsqiHe5DXFTXGvWmUFBNAafdyfLIsykk1DzC6
Dy5N8K3z5Kc8H82P7fECVm0gQ8ey3Zcq7pHPjsNKdTmabz73i8a/DWNaYef3kATEgXWqoC0J6i+S
HJAnDQu32eBv9H/JbVRXBVwYYuxTxVoGJmGic5gSQF6yk+1MmGVdLNE0OPPwZ8oPsphIwuPwCedK
ZU+GTI1KPzfDiVT2m5/6Eu63pXIZ8p0EtV/HpcCQRb4cksaeR9fMlZ99vQDhj4jS5D+YKRzpMEl7
32trtH1Gp62SGh9ZJ/fiINBjhPhwkK7ixoebT6gbDvKUWfoATjM+XZ/1IpOIgTxmJ5+R5dgtDGGm
lxD+HIImz11qNfsUsDORhXrQkE0/EGtBfX2pr9yFvL3PV7jpvaiupWRv3ewB88KQ2PBnCXqFTyE9
nmTNgyzJSXd1cL/smTsMSCp5NEZaIfdZi13Ts4tyBoithB1sZgM4+J7lMpVZ0opX4/6NIIw996qA
AQontBNRTLpJldfG+ahkeHoxA0GVAXrxoRV+/PxCf8MWhdqrSZ4gzgfSmb/DRwahxlqRa9EuXnrP
QycM9ivZhoytQoofcE8DmCubHUo9m2vb/AzXjU5OxSh5tGxl5w8WM0jVPGBYpWzlWaMii3CMoggi
BbsUU5BkX4N4+LgMYvSM8LT99iRhCUhsbfRounHEPrStM5RFYCtLGuGQ8ggbxvMDuOSpom2H9w25
2P3Hgylun4CvGl1ldccMQiYK5+dEK0fL0fUXlvyaxX3nB58bEVM+sxjPS70CXHmXgRNIio80+zog
8o9iT3LRh4Gwtv6xnxMfi2t9Hdp55NlaNlQhA7wof2R19fsyxS68cIg3RbPiMtPRTXtbM4Fmc1NE
a5lajoLLVOqIsnQf20PFTCOX3xzRyUM+dOpq1GiaRGfbY+/RvHlqSWKeZza6fqd/WEiYSNk8WBpA
1YklZ73a5DdAVUPVDsAgv+14KmAUGWjXYMHobq4lCWHC3j8J2zP1RsG7VxuHalyIfTfSfGVTOTY2
bFxuHIy1lCVzTWuVL6Rva31zo9OQHBoImaBDD0w39+V1vCH/MXakiwhCIO7mLu1hnVaitesBYR1Q
z0NZu0/zDHRQnKRpEcjlzMx8TCa4Vx7Gp7wUDf9PvuT+4dCHU5BDiZeCfsgMqJ68WSMx3JNw/Pw7
z7YoDL0AeH3EMU67oKIu8jWy6nMdnxyNxbu65kK4Z89AZvqDfglTTLl7eefs+h267R0dfy/LgrZ4
MsTRTLexeyDoW5tQQ2B6wZIXSnGf7m3K4PXoCY8Fpg5q9/I/albAPFYxYfGjAsl1o8ChyNrEoe6q
6OuikE8G2g+CTC9/QAzkc8dLfrQguyMgQs7anQmsyYnAtkDz6Y4T+kOH9puMGRksYW8hmkC4ck8z
nRAZpgAY/DKc29nH2HMxLWsovxP5EwTpF/1Shj+c5wCw+n3ERVaTnFpuj7loRByHyyNWZHaKO1hy
0LgiLLHfWqTWqDanIIXMYHB0gboVK3Hejin+xie9WQIoGjohI4xQ024Ob7uMctdPb0fEtDtOAaYv
fe2bYPCsiBSqZDz6wyAeeauTOL2WFvRi4NfNPRt4ZhqbWJZL1AEIo0hYU0nUv4qzb9z4yVttjaTb
iso247VhJXDdCzOuVoa7rjTxMkOfoiCHgYfmYMs5rqaFvQAzts4fsvcppp/h3Rh1zsBJqkaUWXNh
tYnGJ3evdS4w1UtxcvtEvA790xcn1G/mbd247ngSbkR/aJlrVPgONpj5VSFlRXqLnZSjBjlUtNZe
oqi59mzgeg1henAIFlmmK7njg2dnOTbUNOm4hXgx8GciZiYeCtZla2dI3Ct67AgHtxcFPA/lHmBi
5BaF52tOwcP4Gwg+Wkx14Fq2NiD3CtDvPZcinJODrr86TB9aC1xFhhgTSePIhC926yM1HnLck65W
w+Ay5dyLnmgBuiwFX/teXEgItmrJtyFL/REKm35CB/1pd4RjRWiWFvCOk8BMdzgsp/YfRU2r9WXX
MKKTJP+7Pyv9LCHYCuF12LAv6z5LhCng3AviC6raIRr5vXC8ErxPEuIt+swHigV5QTjTM7p0rxl8
7SnKNWOwQURuY0gofgH8Y4UsphTuslPQa4paJRZJT3xYSrlFXPfLX4yTuoRCBegCWT5AzZxld4HT
VmqjrvflcYBlUJnOVn9udQ/wB56fr2Bukbij7UKZKuHVrcv1Q98CPUxpA3c3pYFmDD+m9i4E6R5P
zzRLeQvflDopOIFSEU4ZvmVMvc6DVUfFHZkMY7+XT2q3p62TKl78caW0HaQtdMzxaHwx9a+3ti4s
+Kp9+hiwLljg5q38oe1gHwx85sWe7zWU0nPn6OQuNqIZ9rOxx695JWHLeMca90f2yMBlw7fFtmBp
rJOeUUPYKcA/Bn5fhqb6gc5tG5R6Ox2V8/JTGhFvt8g5IniCI9ffod0J7PBjBNLBED8/GUau07KC
Ojutpdidu6YyFbPQlTSqMfURvsi2bItQbcl2Qtx4yEnmMNxSWlcBT+1oaWhHFZTyiIukde2UfPD/
JDbcX0FB66oylQ8TENsinLeD0G2NZtBB5qa2eDLi1rHVCdd8fyyPHoVjATybKLyt4e7/qeKEhJSA
i3P/I03GD3oAaVToLtGu+UaFCXFISRq1rMDx5duJh+yPy+R74bl3CsFBCn+sQRwvk7G5XcitmABO
kV5a20xw3/4WMYn010bukHhpmSBmmWNjheUEN1myS5BJOVDDXZzOgOvTZeffgyuSzjDpO1Mf9lfD
AGI8z9YflnHJoJJrN9YCUFaprD03w2qc/YG4YRqwVUQQKCVTFevdoXNseOKHyVCvZqik4rC2tPlw
GpLgEr1lHou5gVtbuDAApvGbhIT3PbYjmbf1ogiglNTRvWsHv/mmdzQVnpm2uFL4vRkO2/YV9Z/3
bwXh6FDOl6as7VSvtHy/Z/qSCqsOWuiTZcqy5jitKYxfAYE33pIbq7faiunCHrcOOy8M1Dz2cLVZ
CUT1v3v4v7c3ZEN9U5I0r25Z+mH1oul/JwVbbxwhJ1fkpWqPgr0lUjJqWoaB57Asutd8LtHOC+EH
z3pUpalpHAj8QtUmKM3659m4ALXZsH5hnMi8slA8ttKvVfRCq8A1WUFj8IOPZn+XgQnXi6tGxuRm
xdrYrlX/kNG1Coaveh+7GG1eQ7uRgLoHFhW6nXibzghH4EwOg21VgRcpUCmf3GRH/WzqsEJv5BaQ
cQOAd00IFmXAu7g9ue/VLY7s/BRl13ZqFht7o5reVWo951bWUk25+7Bpga1yBn4gUr/QWT9cG7ps
vD+JRoE+gvWYZjSURv5349zZ4OkB9em7yZAT2KxKr3quZfskaRy5Y0s+KEXgwCBqeC1R++G210GL
aroA0ax+ExlvV45MpyREQqXo9EIXx5ZvcADlo8B2Z8dSeEheO5Kl8uP4rKla0M+Tg8815wdzGUrj
+HvX4UjwVcLrfVcqVNJih6NBMY6GSnOl/SD/pIOjhdqtOAyEXP6pHJQsEODt2A+FnsLeAAUF+J+n
ZI4OVmSGExwg3n3a3j4odwjDClm9tEmZ1XsKdjokKnWLnCf44RmZD4nKShia6jLtMcGtpt25yv+D
k4VSb3h/Lnd4XwqCyRnipo57ji4oJL+wZ3lzj1MXPKKtTkIQmKktTcl9mBBsDjmLNeW6q6mDQNoS
MDzpjoYKXrUAgCO1x0hKiaDxt0YHmZgnSebWJoNFDO1hbVjT9Y06E4vBj6zKXn5dBEATZ6J5PD3S
g9xIDadpT8mLqNI3wN6+5KnFcHbA5HBgP/eM9f5HtA397xDYwReWbbyXC5e6VnoMufxfaHd600ZS
zX+lrlLudheVcYXshj3jgmGKsBVgu9Q4iO39zuhOzk4ewxVuyAf+UqWVuf6Mfqkl9y1iv6cBcRXq
oR2ZRcFFfFdHxua6XWQFham2SpaUic1V2U2Zl88JtVO81D/OWOh6Ni2BLQlWS9zO0UQd6celH7Cn
E7Z6PiYPzAbqHKro8xO/HfP6UUffiurh2LYyW/RhXkHkl1y4VUGMyXWOAnfJRG7oNVKbF3tCUtGR
o5ERCTaCi0AxGMKbm7PSv3v9KCV7yc9Qv71/zYdO7RxH5MByHMGX23l6QAiJTn+rZTxmXYuCi7I7
GceeBT1ju94QOa/Akn1vFM7M9fNHnMQDD/g5nxmfNGq7d2IaahkJIxuEa4ND21BIreXXVHAcO7oR
eUGOBGy3w5XSXqbVfe7GVt5zm+VWmF04475JghIl+I7XnPE7BXvCaxLLozugosnxt2n1uj+ErUge
/AyZlNwP0B5czme6Zdz/P4s7hhgEFRCUz48FRAQiPirtmyZwWKrjY42/UO6XEwsRTZW/8XegblSS
YKokzT0iBI3lc7zcMwxrsP713Z1lUZKrnrLVFVM4iH87wnZti7MM0efu5sPQyhwrk1qc2Q6ywFeJ
a/7xeQa1tkLtvZRrTd20S7rPVF4pOPXemcbw7df+eNZPlLJsiMoADc+4UhDGHA9RlYG1wwpia3ed
4niUwdCsgbVPHZVUlNT7HdoBsxgPVb33sHhTaV6dUHtgVLs87ofUrRrENnQBNddtDUqetiCukDQz
0nYeci53kGSbrO2nLlOjCr0M0Hh2LZLjgS5Bnz6vP5IAr/1fGoY68GQypgAF8C1EZRdS4eEwl8eB
Ms9VpZSJlIKAKo7dUaw/uJmo9ZahuoDDvRXhiSlDorsS+5gO4/b7wMMkdqAXKpiwCgdLKtiZwiSA
bzvjSbdLNy2lrXDuqQlNSzbI0vshQC+VNp3CQhCRYN8+KlEFz3dvU+ghC60ciB2HNVwH8oTpOpkD
TzZpAIYsegCoyQodFoSsM4ThOG+/2cEffab/EBXlvYROdyb8+b75VLlzvoB25HlsQxD/7fEwB/dE
LnqOZK54gBljaxEsRw5o7HNSM92CbTEmjR3ZC1BZBgWpTCZAAew2aTQ3Fy5nprCNrWXrDL6b4nx8
wfuxEQrq6kXHNxj8NsHd8Wo3KSVXQvb8sg+F5zVND1vIU9RfdLOEmm3/oZNuNVH8VIMWanlNv91/
AjlqCoX3x6F6dZAoRlZ1KwX6RX9eLetxlKdk4jUbJPvL9TbO4sUG6fCLzOwoX8cuvi4P9AH8rdmU
PSaSLlBkj69EUwM7cewsrp/qrt1LoKBl0fJ+3ttTyXZ7uXs0RDzLKpXwzVxBV8qMqF5KjsD9bYyK
oPiT6A3A8OWSnWczQuL9I79azYMCHCBnynhAY84SpH99H+sOveaZCy0ursP/nVp5D2KUFicYemgM
RnHCsAAhanOvjDFRH1e8Oqu1JMJtWYSstFtgRqbADXclYzmE4GYsBAkKLNmpGfQNYhoh22tuhKzx
GqP88gv87WCWueufhmVbK2N5tqm55igz/ISK6ljoPxUgGCf6p6nlrUzRg/8B18lXNhf+nK7RlqTa
egHJj45FG3ni+tRtRqqMpWcqga8XVoUeh7QBcXkH58iBb3uu0iJcj9UHwJJefvxo/54xq4a1eRvp
STOScguzGv2N7mGq
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
