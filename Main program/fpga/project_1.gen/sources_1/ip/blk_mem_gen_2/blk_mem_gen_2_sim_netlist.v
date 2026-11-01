// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Mon Apr 13 20:13:54 2026
// Host        : whr running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Program/FPGA/Xilinx/Xilinx_Vivado2024/nn/mnist/project_1.gen/sources_1/ip/blk_mem_gen_2/blk_mem_gen_2_sim_netlist.v
// Design      : blk_mem_gen_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_2,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_2
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [4:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [4:0]addra;
  wire [4:0]addrb;
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
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_2.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "30" *) 
  (* C_READ_DEPTH_B = "30" *) 
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
  (* C_WRITE_DEPTH_A = "30" *) 
  (* C_WRITE_DEPTH_B = "30" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_2_blk_mem_gen_v8_4_9 U0
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21776)
`pragma protect data_block
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
RaI=
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
