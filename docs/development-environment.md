# 本机开发环境

## 3D 建模

- 主工具：FreeCAD 1.1.3（参数化机械 CAD、STEP 交换、Python 自动化）。
- 推荐用途：PCB 外壳、安装孔、光机支架、装配干涉检查和加工模型。
- Codex 入口：编辑并运行 `cad/scripts/smoke_model.py`。

## STM32

- 编辑器：Visual Studio Code。
- 官方扩展：STM32CubeIDE for Visual Studio Code 3.10.0。
- 构建：ST 官方 CMake + Ninja。
- 编译：ST 官方 GNU Tools for STM32。
- 下载与调试：STM32CubeProgrammer + ST-LINK GDB Server。
- 配置工具：STM32CubeMX2 1.1.1。

STM32CubeMX2 目前面向 HAL2 支持的芯片，不是经典 STM32CubeMX 的全系列替代品。如果后续使用 HAL1 芯片或已有 `.ioc` 工程，应继续使用经典 STM32CubeMX；具体项目需要先确定 MCU 完整型号或开发板型号。

运行环境检查：

```powershell
.\scripts\check_dev_environment.ps1
```

`stm32/toolchain-smoke/` 是不绑定具体芯片的编译链自检工程，仅用于验证 CMake、Ninja 和 GNU Arm 编译器。正式固件工程仍应由对应芯片/开发板的 `.ioc` 或 CubeMX2 配置生成。

## FPGA 神经网络（2026-10-11）

独立环境位于 `learning/nn_fpga/`，使用 Python 3.12.10 + PyTorch 2.14.1 CPU + Vivado 2024.2。电脑训练，FPGA 推理。已运行 400 轮人工数据训练、定点导出、14 项 Python 测试、两种核心各 40 帧逐层 XSim 比对、独立教学核心综合和布局布线；中文 Jupyter 教程也从头执行通过。

入口为 `Run_Demo.cmd`、`Start_Jupyter.cmd`、`Open_Vivado.cmd`。具体命令、数据格式和验证限制见 [学习环境说明](../learning/nn_fpga/README.md)。人工准确率不代表实测分类能力；现有 Main 仍用 XADC，尚未完成 ADS8681/整机网络集成。本次保留现有板卡工程及 BIT/MCS。
