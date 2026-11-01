// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Mon Apr 13 20:14:16 2026
// Host        : whr running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Program/FPGA/Xilinx/Xilinx_Vivado2024/nn/mnist/project_1.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [5:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [5:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [5:0]addra;
  wire [5:0]addrb;
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
  wire [5:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [5:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "6" *) 
  (* C_ADDRB_WIDTH = "6" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "50" *) 
  (* C_READ_DEPTH_B = "50" *) 
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
  (* C_WRITE_DEPTH_A = "50" *) 
  (* C_WRITE_DEPTH_B = "50" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_9 U0
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[5:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[5:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21840)
`pragma protect data_block
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
3feG3xPo/o88
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
