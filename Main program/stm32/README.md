# STM32 四类颗粒投票显示（独立交付）

目标 STM32F103RCT6，256 KiB Flash / 48 KiB RAM，原 ILI9341 240×320 竖屏。

烧录文件仅使用 `output/STM32_PARTICLE_VOTE20.hex`，同目录提供 BIN / ELF。本交付未自动烧录硬件。

接线：FPGA J5-24 / F16 TX → STM32 PA3 RX，两板 GND 共地，115200 8N1。SIM800A 等其它设备不得同时驱动 PA3。FPGA PC 串口是另一路 8E1，不能用它的校验设置接 STM32。

协议版本 2：A5 5A 02 SEQ RESULT FLAGS CRC8 0D。RESULT 0=空载，1=小米，2=珍珠粉，3=细盐，4=白砂糖；FLAGS bit0=背景扣除，bit1=空载。CRC8/ATM poly07、init00、MSB-first，覆盖版本至FLAGS四字节。兼容旧版本1，其原始CLASS0..3会转换为RESULT1..4，空载位优先。

显示使用最近20条新有效识别的投票。暂未满20条先显示临时结果；百分比是当前票数/窗口有效数量，不是模型概率。平票保留原类别，否则取并列类别中最近出现者。空载立即清空，错误/非法/重复序号不计票且不续连接计时。2秒无新有效结果清空并显示连接超时。超时后的第一包可使用与超时前相同序号，以兼容FPGA重启。

四张图片144×96 RGB565，只读Flash数组；图片只在最终显示类别变化时写LCD。数字每条新结果更新，LCD帧缓冲只存在于主机测试程序中，固件没有整屏RAM缓冲。素材与许可见上级 `assets/SOURCES.md`。

编译：双击 Build.cmd，或运行 Build_Vote20.ps1。使用现有GNU Tools for STM32 14.3.1及GNU Make，不访问实板。编译输出在build_vote20，复制的烧录文件在output。默认make亦使用build_vote20。

验证：`tests/run_host_tests.sh` 在WSL GCC运行实际解析/投票代码及真实UI C代码，LCD底层由主机模拟器代替。`tests/render_previews.py`把其PPM输出转换PNG。`verification`保留协议投票日志、实际FPGA串流端到端测试、12张UI截图和Flash/RAM报告。主机预览不能替代实屏颜色/接线/时间性能验证。
