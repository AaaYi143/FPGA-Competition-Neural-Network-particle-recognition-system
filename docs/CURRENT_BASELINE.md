## STM32 vote30 physically programmed (2026-10-27 19:28)

User changed PARTICLE_VOTE_SIZE to30 and requested compilation/flashing. Current editable folder remains deliveries/STM32_Particle_Vote100_20261027; output filenames retain VOTE100 but actual current HEX is30 votes, SHA256 01bd6710d861ca5db11ee8406d950f1ab6c6c59676dd5a81357b642d7b94e436. LCD title now derives from macro. CMD launchers repaired to ASCII/CRLF/full PowerShell path after user's screenshot of command fragments. Variable-window metadata/flash status supports30/50/100. Current30 window passed10000 independent FIFO comparisons/full percent/tie switch/empty/duplicates/timeout,13 host UI snapshots bounds. Original fixed100 tests/ZIP and old receipts are historical.

Fire FS-00000000/SWD same UID confirmed; before_flash full256KB backed up under reports/flash_20261027_192656 in delivery (matches previous100 readback hash d1d45f...). NewHEX written, full256KB readback matched expected overlay; unrelated flash/options preserved. RUNNING,CFSR/HFSR0,LCD0x9341. Live FPGA link verified24 fresh accepted packets,no missing/duplicates at19:28:46; all were empty, window0/online true. Classification accuracy/material display not tested. FPGA not programmed. Receipt verification/stm32_flash_vote30_receipt.json/status stm32_vote30_status.json.

## STM32 vote100 physically programmed (2026-10-27)

User explicitly authorized flash after connecting. Fire FS-00000000/SWD confirmed same UID34ffd8053130533136751143, family0x414,256KB. deliveries/STM32_Particle_Vote100_20261027/output/STM32_PARTICLE_VOTE100.hex SHA256 e60e149bb4aad58b4ebd6adb72e98ab17d8762e1cad75e1c5a4041d00f03c1ea programmed; full256KB readback matches expected merged image, unrelated flash/options preserved. RUNNING, CFSR/HFSR0, LCD0x9341. At16:47:29 received/accepted0, vote.onlinefalse, so FPGA link/physical UI update not verified. No FPGA programming. Backup reports/flash_20261027_164538/before_flash.bin under vote100 delivery; receipt verification/stm32_flash_receipt.json. Build-time no-flash flags and ZIP describe pre-flash packaging; this later receipt supersedes physical state only. Original20 source/firmware remains preserved; actual STM32 now vote100.

## Independent STM32 vote100 (2026-10-27; not flashed)

User requested a matching100-vote STM32 project. Delivery deliveries/STM32_Particle_Vote100_20261027, workspace STM32_Particle_Vote100.code-workspace, output/STM32_PARTICLE_VOTE100.hex (SHA256 e60e149bb4aad58b4ebd6adb72e98ab17d8762e1cad75e1c5a4041d00f03c1ea). Baseline20 project and physical firmware remain untouched. Production changes: ring macro100, UI uses macro and shows n/100/VOTE100, main comment only. Parser, UART, board drivers, pictures, four IDs, empty-immediate clear,2s timeout and tie rules unchanged. Flash helper status layout updated to128B/100 slots and synthetically checked; no USB/probe action. FPGA rebuild not needed.

Compiled HEX/BIN/ELF match; Flash127024B RAM5424B. Actual C protocol1024v1+1024v2/64corruptions/10000 independent FIFO comparisons/274 prior actualRTL packets pass. Tests cover90/100,100/100,50/50 keeps winner,51 new votes switches,empty/duplicate/timeout/wrap. Actual UI13 host snapshots bounds and partial redraw pass;100/100 screenshot visually inspected. No physical LCD/accuracy validation. Receipt verification/deployment_receipt.json. Old active deployment registry preserved; new source is a separate manual-flash option.

## Data2 candidate (2026-10-25; active hardware deployment preserved)

New training requested on E:/fpga/data2. Independent project integrated/particle_identifier_data2_20261025/fpga/project_41.xpr and output/PARTICLE_DATA2_512.bit/.mcs. 1745 accepted rows, 珍珠粉 line205 has61 columns and excluded from copy only. Same four IDs,31-20-31-4,500epochs; best191; float381/43787.19%, integer380/43786.96%, zero duplicate normalized groups across split. Millet recall56.25% integer (49/112 confused with white sugar). All material raw sums>=448; original gate419 preserved; input29 is zero in all new material rows. No independent accuracy test.

Updated weights.vh and paired scales.vh (scale arithmetic unchanged; run comment updated); all other RTL/XDC unchanged from SW6/vote20 512 baseline, current STM32 firmware remains compatible. 2251 actual NN RTL frames/69781 normalization outputs/allFC/activation/class/empty/display pass;512 average49152 samples96blocks and dualUART297events pass. WNS0.348/WHS0.023, inherited warnings; SPIx4/8MB/address0 MCS payload matches BIT. No flashing. Current fpga/current_version.json stays prior working deployment; candidate recorded fpga/variants/project41_data2_512_20261025.json. latest_current_run and future export-only training config now point to data2/new candidate. Reports validate configured project rather than hardcoded old live project. Old versions retained. See candidate README and verification/deployment_receipt.json.

# 当前使用版本：512点＋SW6双模式串口＋STM32最近20次投票（2026-10-24）

2026-10-24 physical programming update: User explicitly requested STM32 flashing. Fire CMSIS-DAP FS-00000000/SWD confirmed the same UID/0x414 family and256KB Flash. Full backup `reports/stm32_flash_vote20_20261024_190128/before_flash.bin`; HEX `81eb93b41f6d19fe58f72b677779ab2046157a382c3f41492e5edafc74848ece` written and complete256KB readback matched, unrelated bytes/options preserved. Program RUNNING, LCD0x9341, CFSR/HFSR0. At19:28 received0/onlinefalse; FPGA result link remains unverified. Initial USB nonresponse recovered after user replug; programming succeeded, post-write status script file-handle bug was corrected and readback/run checks completed without re-erasing. FPGA was NOT programmed. Separate receipt `integrated/particle_identifier_20261023_sw6_vote20_512/verification/stm32_flash_receipt.json`; original build-time flags remain historical. Manual entry `integrated/particle_identifier_20261023_sw6_vote20_512/烧录STM32.cmd`, using `tools/stm32_flash/Flash_Vote20.ps1` and isolated existing pyOCD.

当前默认登记已切换到独立交付 `integrated/particle_identifier_20261023_sw6_vote20_512`。打开其中 `fpga/project_41.xpr`，下载 `output/PARTICLE_SW6_VOTE20_512.bit` 或匹配MCS，STM32配对文件为 `output/STM32_PARTICLE_VOTE20.hex`。旧live project_41仍是1024版本，原512对照版也保留；不要把旧目录当成新的SW6工程。

512点平均、419空载阈值、四类权重和通道映射不变。SW6关闭电脑发原光谱，打开只发v2结果包；电脑1152008E1。J5-24到PA3专用结果线始终1152008N1。STM32最近20次投票，收到空载立即清空，2秒无新有效数据超时；显示的是投票占比。图片及完整说明见新交付README与protocol.md。

975帧NN与49152次采样回归、两端实际串口字节对C解析投票、UI主机渲染和构建检查通过。WNS0.157ns/WHS0.037ns；STM32 Flash126932B，RAM静态及预留5344B。没有实板烧录或新准确率测量。详细日志和文件摘要在交付verification及SHA256.json中。

以下内容为保留的历史记录，新默认以本节和fpga/current_version.json为准。

# 当前使用版本：project_41 四类＋空载横线＋1024点平均

## 独立 512 点对照版（2026-10-22，不切换默认版本）

用户为对比识别准确率要求另做512版本。交付 `integrated/particle_identifier_20261022_four_empty_512`，下载 `output/PARTICLE_FOUR_512.bit`，对应MCS为SPIx4/8MB/地址0，可编辑工程为其中 `fpga/project_41.xpr`。BIT SHA256为 `11d8d1fb82c306f74989627250d646c5157cb1f4a1c67fbc7289d9229d9977a3`。与当前1024源码相比，仅Main平均次数512/右移9有变化，四类权重、419空载门控、横线显示、通道映射和UART均相同。STM32固件相同，无需重烧。原live project_41和current_version.json仍保持1024。

实际Main平均仿真49152次采样/96块/32路/4暂停通过，保留首块511点除512、随后512点的原边界。布局布线WNS0.439ns/WHS0.026ns，继承实现告警；MCS记录校验与BIT载荷一致。网络与显示/UART源码完全一致，引用原975帧NN及IO/解析器验证，本次未重跑。未烧录FPGA，实板准确率尚需同条件A/B测量。登记 `fpga/variants/project41_four_empty_512_control_20261022.json`，重建脚本 `scripts/Build_Particle_Four_512.ps1`。

2026-10-22后续：用户授权实板烧录，STM32已通过Fire CMSIS-DAP/SWD完成新HEX写入及完整256KB回读校验，原固件备份在 `reports/stm32_flash_20261022_131814`，未写入区域和选项字节保留。程序RUNNING，LCD0x9341，字体检查通过；13:43仍未收到FPGA有效结果包，屏幕/FPGA联调尚待确认。助手没有烧录FPGA。实板烧录记录为交付verification/stm32_flash_receipt.json，区别于构建时的deployment_receipt.json。

## 2026-10-22 后续更改：恢复四类、无颗粒横线、1024平均（本节优先）

用户取消第五背景类别，确认“激光开启、没有颗粒”时四位显示 `----`。已恢复原四类模型配套头，训练ID仍为0小米/1珍珠粉/2细盐/3白砂糖，显示1～4，OUT_FEATURES=4，没有重新训练。另加独立空载门控：31路输入原始值总和<=419时显示四条横线。原背景记录499条最大总和233，颗粒1866条最小605，所以先取419；阈值需在1024平均后的实板条件复测，不保证任意光路、弱颗粒或SW7设置适用。

Main实际参数改为右移10、1024点平均；通道映射、ADC、增益、SW7、PC光谱串口仍保留。继承首块少一点的边界行为：复位后首块1023点/1024，后续1024点，本次没有顺带修改。FPGA结果UART新增FLAGS bit1为空载，CLASS仍0～3，bit0仍SW7；配套STM32显示“无颗粒”并取消材料选中，旧HEX需要更新。两端引脚和PC8E1协议不变。

使用 `fpga/pro4/project_41/output/PARTICLE_FOUR_1024.bit`，SHA256 `f8cd3839a80e19ed5703f409c2af117a011605065456208270f25377d20e3a22`；同名MCS为SPIx4/8MB/地址0。当前registry为 `project41_four_empty_1024_20261022`。交付 `integrated/particle_identifier_20261022_four_empty_1024`，备份 `backups/before_four_empty_1024_20261022`。前面背景版BIT/MCS与原四类版本都保留，旧Main.bit未覆盖。

真实RTL检查975帧：467条原四类验证＋499空载＋9边界，30225个预处理输出与所有网络层、类别、空载/显示一致；显示5885次。实际Main平均98304采样、96块、32路、4暂停通过（ADC原语仿真替身，不代表模拟硬件测试）。8个串口仿真包通过真实STM32解析器及1024例/64种位错误恢复。新BIT已布局布线，内部WNS0.359ns、WHS0.035ns；原DSP/BRAM告警保留。STM32已真实编译。STM32现已烧录，FPGA尚未由助手烧录；旧四类同批整数分数452/467不等于1024采集条件下的准确率。

桌面训练入口恢复四类；保留E盘背景TXT但配置为明确排除，不删源数据。当前模型指针回到 `materials_20261021_4class_500epochs` 并附新部署记录，未改旧run指标。后续重建 `scripts/Build_Particle_Four_1024.ps1 -BuildDirectory E:/co1/一个新目录`；默认训练仍只导出。

## 2026-10-22 背景光模型已接入并构建（本节优先于下方历史记录）

新增背景类别定义为“激光开启、没有颗粒，设置与颗粒数据一致”。训练ID0～3仍为小米、珍珠粉、细盐、白砂糖，新增ID4背景光，显示编号为0。四位数码管分别显示 `1---`、`-2--`、`--3-`、`---4`、`0---`；上电等待为 `----`。网络输出扩展为5，采集通道/ADC/增益/背景开关SW7/512点平均及PC光谱协议未改。

下载 `fpga/pro4/project_41/output/PARTICLE_BACKGROUND.bit`，SHA256 `eace5499ebc0ce843bb4761323cf03199a6158ef9cf66bf3c0cb666481e58b61`；同名MCS为N25Q64、8MB、SPIx4、地址0。工程仍是 `fpga/pro4/project_41/project_41.xpr`。旧 `project_41.runs/impl_1/Main.bit` 没有覆盖，不包含本次新模型。

统一交付：`integrated/particle_identifier_20261022_background`，含FPGA源码、下载文件、配套STM32背景光中文显示固件及验证记录。前一版 `particle_identifier_20261021` 保留；部署前备份 `backups/before_background_20261022`。原gsm-phone工程未改动。J5-24/F16至STM32 PA3及共地接线、屏幕硬件均不变。

训练运行 `learning/competition_training/runs/background_20261022_500epochs`：2365条有效数据，背景499条，500轮，最佳第78轮；浮点和整数参考均583/592（98.48%），背景122/122。22组归一化重复输入跨随机划分；去掉26条重复验证记录后557/566（98.41%），仍为同批诊断，不能视为独立实板准确率。源TXT保留，3行格式异常只在训练副本排除。

全网络实际RTL验证594帧、18414个预处理输出，各层/分类/显示0差异；数码管扫描5163次；7个实际RTL串口包通过STM32 C解析器及1024例/64种位错误恢复。真实布局布线WNS0.267ns、WHS0.043ns，原网络DSP/BRAM等DRC告警仍在；尚未烧录实板。训练报告/部署证据分开保存，模型run内 `deployment_receipt.json` 为本次部署凭据。

重建：`scripts/Build_Particle_Background.ps1 -BuildDirectory E:/co1/一个新目录`。桌面训练入口保留原WSL CUDA环境并使用五个标签，未来训练默认只导出，不自动部署。SW7应保持采集训练数据时的状态；它的背景扣除和神经网络背景分类是不同操作。

## 2026-10-21 新四类已接入project_41，配套四位显示及STM32屏

按用户要求，已将 `materials_20261021_4class_500epochs` 的权重/缩放与OUT_FEATURES=4一并接入实际 `fpga/pro4/project_41/project_41.xpr`。0小米、1珍珠粉、2细盐、3白砂糖；数码管显示编号1～4，四位图案分别1---、-2--、--3-、---4，额外四位关闭。原通道映射、ADC、增益、SW7背景逻辑和上位机8E1光谱串口未改动。

新增独立115200 8N1结果串口：EGo1 J5-24/F16到STM32 PA3/USART2_RX，另共地，需断开SIM800A的PA3连线。用户确认沿用gsm-phone原ILI9341＋XPT2046屏。原代码未修改，维护版CubeIDE源码复制到 `integrated/particle_identifier_20261021/stm32` 后独立整合中文颗粒名界面；14个汉字字模内置，不用改外部Flash字库。

新注册制品：`fpga/pro4/project_41/output/PARTICLE_FOUR.bit`，SHA256 `ee16056ff30b693fcfcc1ddf7edd7a8e793dc8ab23f8e5a8e846058f40bacda9`，配套MCS为8MB SPIx4。真实综合/布局布线完成，内部WNS=0.538ns、WHS=0.027ns。存在原网络DSP/BRAM相关DRC告警，不能称为零告警。`fpga/current_version.json`已切换为project41_materials4_20261021；早期FINAL_TEAM_CURRENT.bit及旧project_41.runs/impl_1/Main.bit不代表本次构建。

验证：467条验证数据和2条零/常数边界输入，共469帧，预处理14539点、各FC/激活层、分类和显示映射全部匹配独立整数参考。定点452/467与此前Python评估一致。四位扫描检查4440次。真实FPGA串口仿真的6包由STM32实际C解析器通过，另测1024组序号/分段/类别、64种位错误及截断恢复。未进行独立样品验证或实板烧录。

STM32 ELF/HEX/BIN已真实编译，15,532字节text、140字节data、3268字节bss（链接脚本另预留堆栈）。统一交付 `integrated/particle_identifier_20261021`，含两端源码、下载文件、模型、接线说明、界面示意与报告。部署记录 `fpga/pro4/project_41/particle_model.json` 及交付verification/deployment_receipt.json。修改前XPR、srcs、旧BIT、注册表备份 `backups/before_four_class_display_20261021`。

后续重建用 `scripts/Build_Particle_Four.ps1`，不要使用历史v3脚本。桌面训练入口保留新四类配置，已允许实测过的四位显示/结果端口包装器哈希；下一次训练仍默认只导出，不自动部署。

## 2026-10-21 当前训练数据改为新四类（尚未部署）

用户要求舍弃旧五类训练，改用E盘 `Neural network trainling/data_txt` 的新数据。当前配置为 `learning/competition_training/current_training.json`，训练ID为0小米、1珍珠粉、2细盐、3白砂糖。桌面“FPGA 神经网络训练环境”和工作区 `Start_Training.cmd` 默认进入新四类菜单，复用Ubuntu-YOLO CUDA环境。旧五类运行、权重和原始数据保留历史备份，不再作为新训练默认。

本次有效数据1866条：505/461/449/451。珍珠粉第214、254行及细盐第132行各61列疑似粘连，原文不改写；仅在训练副本排除。准备报告 `reports/training_20261021/preparation.json`，原始快照/排除明细 `learning/competition_training/prepared/materials_20261021_initial`。

RTX4060完成500轮，最佳第99轮，同批随机75:25验证455/467（97.43%），Python定点参考452/467（96.79%）。3组相同归一化输入跨训练/验证；排除3条验证记录后452/464（97.41%），仍非独立采集测试。模型/预处理/训练算法未变；增加已审查的五位显示包装器哈希许可，网络运算路径未变。

当前结果 `learning/competition_training/latest_current_run.json` 指向 `runs/materials_20261021_4class_500epochs`，含模型、配套头、配置、原始数据处理说明、指标及图。已重新加载checkpoint核对全部导出头和验证结果，未对新模型进行RTL或实板测试。

本次没有修改project_41源码/权重，没有生成或烧录BIT。实查project_41仍为旧五类配置，显示映射只适用于旧五类；部署新四类须另配套修改输出数和显示。`fpga/current_version.json`仍是更早的已登记硬件制品，不随训练结果自动改写。

## 2026-10-20 project_41 五位颗粒显示接口

用户确定五种颗粒各占板载数码管一位：1荞麦、2小米，其余按最新五类数据顺序分配3玉米、4珍珠粉、5高粱米；仅对应位显示编号，其余显示短横线，第6～8位关闭。已扩展 project_41 本地 Main/Neural_network/SegLed 端口与 EGo1_Main.xdc，使用两套独立段选总线、八条位选（后三条固定关闭）。训练ID保持小米0/玉米1/珍珠粉2/高粱米3/荞麦4，不重排。

本次只接入显示层，未复制权重或生成/下载BIT。复核实际文件及修改前备份发现 Main 已为5输出，weights/scales 已来自 `learning/competition_training/runs/aligned_20261020_214825_4991739`，与该运行 deployment_receipt.json 的哈希一致，classes.json 为上述训练ID顺序；下方旧“三输出、未部署”记录描述先前状态，不能替代实际文件。保留本次之前的五类配置与权重，显示层进行编号映射。若回退三类配置则显示五条横线，避免误标。

显示行为仿真通过1080次扫描位图检查，当前五输出工程RTL展开、总线位宽及全部端口管脚/IOSTANDARD检查通过。没有进行布局布线、生成BIT或实板验证，不将显示检查视为网络精度证明。接线、验证日志与范围见 `fpga/pro4/project_41/verification/five_digit/README.md`。原文件备份在 `backups/project41_five_digit_20261020_220435`。

## 2026-10-20 使用用户新 train.py 的五分类实验

用户随后指定 `C:/Users/cyka1/Downloads/train.py` 并更新了 E 盘数据。该脚本SHA256为 `ffce8632139eb1acb0ece30d2a5d08d82fc9cfccc6c91af08b178e36a87a1bdb`，保留其500轮、lr0.001、batch32、余弦退火、随机75/25划分及最佳模型选择规则。仅在隔离运行副本追加新荞麦类别、禁用原F盘自动部署并记录指标，模型与预处理AST及训练主体算法均核对未变。

数据更新为小米461、玉米292、珍珠粉277、高粱米470、荞麦305，共1805条。编号0～3保留，4为荞麦。新结果位于 `learning/competition_training/runs/downloaded_20261020_5class_500epochs`，指针 `latest_downloaded_run.json`。RTX4060完成500轮，第194轮最佳，随机验证334/452正确（73.89%）；小米77.34%、玉米21.43%、珍珠粉100%、高粱米95.83%、荞麦45.95%。

荞麦有61条重复记录，随机划分后24组相同输入跨训练/验证；排除这部分验证输入后，同一模型316/428正确（73.83%），仍非独立采集测试。脚本输出96.02%是浮点与Python定点参考的分类一致率，不能视为实板准确率或完整RTL位精确证明。数据、类别数和划分规则与前轮不同，不能用总分直接断言优劣。

已保存原始脚本、适配差异、数据及工程权重快照、best.pt与5类权重头。没有覆盖project_41（仍为3输出）或生成BIT；后续部署需配套5输出与验证。原Downloads脚本和源数据均保持未改动。

## 2026-10-20 新实测数据训练

用户提供 E 盘 `Neural network trainling/data_txt` 的四类实测数据并要求检查后直接训练：小米461、玉米211、珍珠粉277、高粱米470，共1419条。每行31个0～660整数，无非法行、原始重复行或跨类别相同归一化帧；所有数据的29号通道都为0。文件没有采集批次、增益、固件或背景状态元数据，不能验证各类采集条件一致。

新入口 `learning/competition_training/Start_Measured_Training.cmd` / `train_measured.py` 复用老师 `train.py` 的预处理与模型隐藏层，输出为4类（0小米、1玉米、2珍珠粉、3高粱米）。为避免混入历史类别，原三分类入口和数据保持历史复现用途。四类实验结果指针是 `learning/competition_training/latest_measured_run.json`；训练数据、原始源码和原权重在每次运行中独立快照，不会覆盖 E 盘 TXT 或部署至 Vivado。

已用 WSL RTX4060 完成60轮和同参数300轮训练，最后25%连续记录按类验证。300轮最佳模型在第224轮，验证正确285/357（79.83%），类别召回率为小米83.62%、玉米39.62%、珍珠粉100%、高粱米82.20%。结果仅适用于同批验证，玉米仍明显混淆；不宣称已达成实板四分类。定点Python参考正确280/357（78.43%），尚未验证完整网络RTL算术。老师新版预处理已在全部1419帧43989个输出上与Python结果逐点核对，0差异。

当前 `project_41` 的 `OUT_FEATURES` 仍为3，新导出的4类 `weights.vh` / `scales.vh` 留在运行目录。部署时需配套修改输出数并重新构建验证；本次未改源码、未生成BIT。旧 `fpga/current_version.json` 仍描述此前已构建的三分类制品。

## 2026-10-19 用户指定的当前工作工程

用户已更正：现在使用的是 `fpga/pro4/project_41/project_41.xpr`（不是 project_4）。已将工程实际引用的本地文件 `fpga/pro4/project_41/project_41.srcs/sources_1/imports/rtl/nn_preprocess.sv` 替换为老师提供的新版（SHA256 `280cc1d53035c152834e8fb6c0f983c29099090f62ef86bff2bd271b5f1fa674`）。旧文件和 XPR 已备份到 `backups/project41_preprocess_20261019_214442`。此前误针对 project_4 替换的 E 盘文件已从备份完整恢复。

这次只替换上述工程实际引用的预处理源码，没有生成 BIT。下文及 `fpga/current_version.json` 记录的是此前已构建验证的队友版制品；不能将该旧 BIT 视为包含本次更新。`scripts/build_teammate_current.tcl` 和训练脚本的权重同步目标仍是此前工作区副本，尚未迁移到 `project_41` 的本地 imports/rtl 目录。后续构建或部署权重时，先核对用户指定的工程与真实源码路径。

用户于2026-10-18明确指定采用队友的 `Embedded-Systems-Competition-main/embedded-systems-competition`，覆盖此前保留的v3。后续采集、训练、FPGA修改以此为基准，不再默认恢复旧v3。

- 当前版本注册表：`fpga/current_version.json`。
- 首选下载文件：`fpga/final_scan_v3_20261016/FINAL_TEAM_CURRENT.bit`。
- 旧链接兼容：同目录 `FINAL_SCAN_V3.bit` 已覆盖为同一个新BIT，文件名包含v3不表示旧映射。
- 当前源码和Vivado工程：`fpga/final_scan_v3_20261016/final_scan_v3_with_backups/light_asc/rtl` 及 `vivado_current/teammate_current.xpr`。
- 当前训练代码：`learning/competition_training/train.py`；入口 `Start_Training.cmd`，默认复用原Ubuntu-YOLO CUDA环境，Windows既有Python作为备用。
- 采集入口：`tools/v3_csv_capture/Start_CSV_Capture.cmd`。目录名保留兼容，界面和CSV固件标记已经切换队友版，已有CSV不改动。
- 回退资料：`backups/before_teammate_20261018`，包括旧最终工程、旧工具备份和队友提供的原始完整压缩包。

## 已确认的差异

相对原v3，队友Main交换了0、3号映射，OUT_FEATURES为3；网络为31→20→31→3，类别为背景/颗粒1/颗粒2。串口采集仍为115200 8E1、32个小端16位字加FFFF帧尾。可疑单通道CH07、CH09在本版对应上位机0、1号，保留原始值并标注。

队友附带的两个BIT实际均为旧v3（SHA256为a24c962...），不能代表修改后的源码。已重新综合、布局布线并生成匹配的新BIT（见注册表的SHA256）。输入通道扫描64位置仿真通过；内部WNS=0.211ns、WHS=0.037ns、SPI_BUSWIDTH=4。这不代表新模型实板识别效果已验证。

## 训练与数据

队友数据包含背景116条、颗粒1共42条、每条31列；缺少颗粒2。保留原始数据，不伪造第三类。`manage.py check`明确报告缺失，`manage.py train`在三类未齐时停止。
已实际验证队友网络在Windows CPU和原WSL RTX4060 CUDA环境中的前向/反向运行。没有重新做完整训练，也没有证明Python参考与RTL逐层位精确；队友README中的相关宣称不作为本次验证结论。原脚本按行随机划分，实测泛化需另按独立批次验证。

CSV继续完整保存32路；训练导入桥 `learning/competition_training/import_capture_csv.py`明确使用0～30号，保留原CSV，拒绝自动混入不同固件版本的数据。训练后自动同步新权重至当前RTL；需重新构建BIT才会改变板卡推理。

## 重建当前BIT

从工作区运行Vivado：`vivado -mode batch -source scripts/build_teammate_current.tcl`，或在Vivado Tcl控制台source当前源码中的 `scripts/build.tcl`。
成功后脚本更新下载BIT和 `fpga/current_version.json`；旧生成器仅留作历史，当前入口不再执行旧幅度排序。
