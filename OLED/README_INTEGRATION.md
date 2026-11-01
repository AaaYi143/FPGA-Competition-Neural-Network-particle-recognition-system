# SSD1306 I2C OLED Driver & Project_41 Integration Guide

## 1. 概述与硬件规格

本模块为 **EGo1 开发板 (Xilinx Artix-7 xc7a35tcsg324-1)** 设计的完整 SSD1306 128×64 I2C OLED 驱动系统，支持全 ASCII 字符集与神经网络分类所需的特定汉字显示。

| 参数项 | 设定值 |
|---|---|
| **目标 FPGA** | Xilinx Artix-7 `xc7a35tcsg324-1` (EGo1) |
| **系统时钟** | 100 MHz (`ipClk` / P17) |
| **复位信号** | 低有效复位 (`ipRst_` / P15 按钮 S6) |
| **OLED 驱动 IC** | SSD1306 (128×64 像素, 8 页) |
| **I2C 总线速率** | 400 kHz Fast-mode (硬件 250 分频) |
| **I2C 物理引脚** | **SCL: H14** (J5-25, LVCMOS33)<br>**SDA: G14** (J5-26, LVCMOS33) |
| **I2C 从机地址** | 0x78 (写操作, SA0 接地) |

---

## 2. 模块层次结构

```
OLED/
├── rtl/
│   ├── i2c_master.sv            # 400kHz I2C 主机控制器 (含开漏三态控制与 ACK 检测)
│   ├── ssd1306_ctrl.sv          # SSD1306 初始化序列、清屏及页寻址命令控制器
│   ├── font_rom_8.sv            # FONT8 字库 (ASCII 6x8 + 汉字 16x8)
│   ├── font_rom_16.sv           # FONT16 字库 (ASCII 8x16 + 汉字 16x16)
│   ├── font_rom_32.sv           # FONT32 字库 (ASCII 16x32 + 汉字 32x32)
│   ├── oled_controller.sv       # OLED 核心控制器 (支持字体选择、多页自动跨页刷新)
│   ├── oled_particle_display.sv # 专用于 project_41 神经网络颗粒分类显示的桥接顶层
│   └── Top_OLED.sv              # OLED 独立工程板载演示顶层 (支持 SW0/1 切换4种演示)
├── constrs/
│   └── OLED_test.xdc            # 独立工程引脚约束 (P17, P15, R1, N4, H14, G14, LEDs)
├── sim/
│   └── tb_oled.sv               # 仿真测试平台 (含 SSD1306 行为模型与从机响应)
└── scripts/
    ├── gen_font.py              # 字库点阵生成脚本 (Python Pillow)
    ├── setup_project.tcl        # Vivado 工程配置脚本
    ├── run_sim.tcl              # Vivado 行为仿真自动化脚本
    └── run_synth.tcl            # Vivado 批量综合脚本
```

---

## 3. 字库系统设计

字模全部由 `scripts/gen_font.py` 生成为纯 SystemVerilog 同步 ROM，综合工具自动将其优化为无时序违例的分布式逻辑/ROM。

### 汉字与 Unicode 映射 (10个特定汉字)

| 汉字 | Unicode 编码 | 颗粒类别关联 |
|---|---|---|
| **小** | `16'h5C0F` | 类别 0 (小米) |
| **米** | `16'h7C73` | 类别 0 (小米) |
| **玻** | `16'h73BB` | 类别 1 (玻璃珠) |
| **璃** | `16'h7483` | 类别 1 (玻璃珠) |
| **珠** | `16'h73E0` | 类别 1 (玻璃珠) |
| **细** | `16'h7EC6` | 类别 2 (细盐) |
| **盐** | `16'h76D0` | 类别 2 (细盐) |
| **白** | `16'h767D` | 类别 3 (白砂糖) |
| **砂** | `16'h7802` | 类别 3 (白砂糖) |
| **糖** | `16'h7CD6` | 类别 3 (白砂糖) |

### 字号规格
- **FONT8 (`i_font_size = 2'd0`)**：ASCII 为 6×8 像素（占 1 页）；汉字为 16×8 像素（占 1 页）。
- **FONT16 (`i_font_size = 2'd1`)**：ASCII 为 8×16 像素（占 2 页）；汉字为 16×16 像素（占 2 页）。
- **FONT32 (`i_font_size = 2'd2`)**：ASCII 为 16×32 像素（占 4 页）；汉字为 32×32 像素（占 4 页）。

---

## 4. 独立工程功能验证结果

1. **行为仿真 (`tb_oled.sv`)**：
   - 验证通过：严格检验所有数据包格式（字节 0 必为从机地址 0x78，字节 1 必为控制字 0x00 或 0x40）。
   - 0 协议错误（0 Protocol Errors），成功验证初始化序列（0xAF 亮屏指令）、屏幕清屏、全 ASCII 表、中文颗粒分类名称（小米、玻璃珠、细盐、白砂糖）以及 FONT32 大字模演示。
2. **Vivado 2024.2 综合 (`Top_OLED.sv`)**：
   - **LUT 占用**：2527 / 20800 (12.15%)，远低于 30% 预算要求。
   - **寄存器占用**：365 / 41600 (0.88%)。
   - **Block RAM 占用**：0 BRAM (字库由逻辑/分布式 ROM 快速实现)。
   - **时序分析**：在 100MHz 主时钟下，**WNS = +3.180 ns** (余量充足，无时序违例)，**TNS = 0.000 ns**，**WHS = +0.134 ns**。

---

## 5. 嵌入 Project_41 实施指南

在 `F:\Program\FPGA Competition\project_41` 中嵌入本驱动极为简便，仅需以下 3 步：

### 第一步：复制源码文件
将 `F:\Program\FPGA Competition\OLED\rtl\` 下的如下文件复制至 `project_41\project_41.srcs\sources_1\imports\rtl\`：
- `i2c_master.sv`
- `ssd1306_ctrl.sv`
- `font_rom_8.sv`
- `font_rom_16.sv`
- `font_rom_32.sv`
- `oled_controller.sv`
- `oled_particle_display.sv`

并在 Vivado 中将它们添加到 `sources_1` 文件集。

### 第二步：在 `Main.sv` 中例化颗粒显示模块
在 `Main.sv` 底部（约第 444 行 `ParticleResultTx_inst` 附近），添加如下例化代码：

```systemverilog
// ===============================================
// OLED 屏幕实时显示神经网络分类结果
// ===============================================
wire oled_scl_pin;
wire oled_sda_pin;

oled_particle_display #(
    .CLK_FREQ           (100_000_000),
    .I2C_FREQ           (400_000),
    .PWRON_DELAY_CYCLES (2_000_000)
) u_oled_particle_display (
    .clk            (ipClk),
    .rst_n          (ipRst_),
    .particle_class (particle_class), // 来自 Neural_network 的 2-bit 分类结果
    .particle_valid (particle_valid), // 结果有效脉冲
    .particle_empty (particle_empty), // 空帧标志 (1=无颗粒)
    .o_ready        (),
    .o_init_done    (),
    .oled_scl       (oled_scl_pin),
    .oled_sda       (oled_sda_pin)
);

// 将 oled_scl_pin 和 oled_sda_pin 连接到顶层端口 oled_scl 与 oled_sda
assign oled_scl = oled_scl_pin;
assign oled_sda = oled_sda_pin;
```
同时在 `Main.sv` 顶层端口列表中追加引脚：
```systemverilog
output logic oled_scl,
inout  wire  oled_sda
```

### 第三步：在 `EGo1_Main.xdc` 中追加引脚约束
在 `EGo1_Main.xdc` 末尾追加如下引脚约束：

```tcl
# ================================================================
# SSD1306 I2C OLED 引脚约束 (J5-25 / J5-26)
# ================================================================
set_property PACKAGE_PIN H14 [get_ports {oled_scl}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_scl}]
set_property DRIVE 8 [get_ports {oled_scl}]
set_property SLEW SLOW [get_ports {oled_scl}]
set_property PULLUP true [get_ports {oled_scl}]

set_property PACKAGE_PIN G14 [get_ports {oled_sda}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_sda}]
set_property DRIVE 8 [get_ports {oled_sda}]
set_property SLEW SLOW [get_ports {oled_sda}]
set_property PULLUP true [get_ports {oled_sda}]
```
