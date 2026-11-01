# 屏幕材料图片及许可

这些照片只用作识别结果界面说明，不输入神经网络，也不是本实验采样颗粒的实拍。获取日期：2026-10-24。图像统一裁剪、Lanczos 缩小到 144×96，再量化为 RGB565。未改变材料身份，未生成或补画材料。

| 编号 | 材料、作者与原文件 | 采用许可 | 本地原始文件 |
|---|---|---|---|
| 1 | 小米：[Milletgrains.png](https://commons.wikimedia.org/wiki/File:Milletgrains.png)，Zigzig20s（页面历史另记录 Penubag 的编辑） | 作者释放至 Public Domain；原页面明确可为任何目的使用 | `originals/millet.png` |
| 2 | 珍珠粉：李月、李晶，《珍珠粉和贝壳粉的鉴别研究》，物理化学进展 2025, 14(3), 472–483，[DOI 10.12677/japc.2025.143044](https://doi.org/10.12677/japc.2025.143044)，图 2(a) | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)；本文第 2 页明确声明 | `originals/pearl_paper.pdf`、提取的 `originals/pearl_page4_Im0.jp2` |
| 3 | 细盐：[Table salt with salt shaker V1.jpg](https://commons.wikimedia.org/wiki/File:Table_salt_with_salt_shaker_V1.jpg)，Poyraz 72（EXIF 作者字段 Kadri Damla） | [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) | `originals/salt.jpg` |
| 4 | 白砂糖：[Sugarpile.JPG](https://commons.wikimedia.org/wiki/File:Sugarpile.JPG)，Drtony999 | [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/)（原文件双许可，本交付选择 CC 许可） | `originals/sugar.jpg` |

## 下载地址

- 小米：<https://upload.wikimedia.org/wikipedia/commons/d/dd/Milletgrains.png>
- 珍珠粉论文：<https://pdf.hanspub.org/japc_2370393.pdf>
- 细盐：<https://upload.wikimedia.org/wikipedia/commons/a/ad/Table_salt_with_salt_shaker_V1.jpg>
- 白砂糖：<https://upload.wikimedia.org/wikipedia/commons/3/3c/Sugarpile.JPG>

## 珍珠粉面板核验

使用 PDF **第 4 页**（印刷页码 **475**）图 **2(a)** 的左侧照片。图注明确左图为 Pearl powder、右图为 Shell powder；只提取左图 `/Im0`，没有使用右侧 `/Im1`。该照片为研磨后珍珠粉的宏观照片，不是显微照片，不需要在屏幕标注“显微图”。PDF 中 `/Im0` 的位置变换矩阵及原始 SHA256 已记录于 `generation_report.json`。

## 重新生成与分发

运行 `python assets/generate_images.py`（需要 Pillow、pypdf）即可从随附原图重新生成 `stm32/User/particle/particle_images.c/.h`。四张独立图片共 **110592 字节**只读 RGB565，行优先，R[15:11]/G[10:5]/B[4:0]；不分配 RAM 图像缓冲。`rgb565_preview/*.png` 由实际量化数据反解得到，`four_materials_preview.png` 为预览拼图。

本项目对图片所做的修改为裁剪、缩放、RGB565 量化。修改后的细盐图片（含相应数组）继续使用 **CC BY-SA 4.0**，白砂糖图片（含相应数组）继续使用 **CC BY-SA 3.0**；珍珠粉图片保留 **CC BY 4.0**，小米保留公有领域状态。再分发含这些素材的固件/源码时，保留本文件、作者署名、来源及许可链接。本说明没有把整个 FPGA/STM32 程序改成图片许可。

照片展示外观可能受光线、白平衡和颗粒尺寸影响；它们不证明当前样品一定属于该类。
