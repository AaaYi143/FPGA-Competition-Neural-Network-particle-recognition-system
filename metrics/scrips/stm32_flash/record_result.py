"""Record a verified STM32 flash separately from FPGA build/validation evidence."""
from pathlib import Path
import hashlib,json,shutil
from intelhex import IntelHex
W=Path(__file__).resolve().parents[2]
RUN=Path((W/'reports/current_stm32_flash_run.txt').read_text(encoding='utf-8-sig').strip())
R=W/'integrated/particle_identifier_20261022_four_empty_1024'
def read(p):return json.loads(p.read_text(encoding='utf-8-sig'))
def save(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
sha=lambda b:hashlib.sha256(b).hexdigest()
r=read(RUN/'flash_receipt.json');status=read(RUN/'latest_status.json')
assert r['programmed'] and r['readback_verified'] and r['option_bytes_unchanged']
before=(RUN/'before_flash.bin').read_bytes();after=(RUN/'after_flash.bin').read_bytes()
assert len(before)==len(after)==262144
assert sha(before)==r['before_flash_sha256'] and sha(after)==r['after_flash_sha256']
firmware=Path(r['firmware']);assert sha(firmware.read_bytes())==r['firmware_sha256']
hx=IntelHex(str(firmware));expected=bytearray(before)
for start,end in hx.segments():expected[start-0x08000000:end-0x08000000]=bytes(hx[i] for i in range(start,end))
assert after==expected
assert status['state']=='RUNNING' and status['lcdid']==0x9341 and status['font_ok']==1
r.update(recovery_used=True,recovery_note='Initial erase timed out; reset/halt and mask old interrupts before sector retry.',
    latest_status=status,original_backup=str((RUN/'before_flash.bin').relative_to(W)).replace('\\','/'),
    readback_file=str((RUN/'after_flash.bin').relative_to(W)).replace('\\','/'))
save(R/'verification/stm32_flash_receipt.json',r)
shutil.copy2(RUN/'program_recovery_and_verify.log',R/'verification/stm32_program_and_verify.log')
shutil.copy2(RUN/'latest_status.json',R/'verification/stm32_running_status.json')
record=dict(programmed=True,protocol='SWD via Fire CMSIS-DAP',time_local=r['time_local'],
    receipt='integrated/particle_identifier_20261022_four_empty_1024/verification/stm32_flash_receipt.json',
    firmware_sha256=r['firmware_sha256'],full_flash_readback_verified=True,
    lcd_id='0x9341',font_ok=True,received_packets_at_last_check=status['received'],
    fpga_programmed=False)
for p in [W/'fpga/current_version.json',W/'fpga/pro4/project_41/particle_model.json']:
    data=read(p);data['stm32_programming']=record;save(p,data)
text=(R/'README.md').read_text(encoding='utf-8')
heading='# 四类识别、空载横线、1024点平均\n'
note='''
## STM32实板烧录已完成：2026-10-22

已通过Fire CMSIS-DAP的SWD接口写入本目录HEX。确认目标高密度STM32F103、256KB Flash；原256KB已备份，完整回读与期望一致，未写入区及选项字节保留。首轮擦除超时后，经复位暂停并屏蔽旧中断状态重试成功；记录见 `verification/stm32_flash_receipt.json`。

程序已运行，LCD ID为0x9341，内置字体检查通过。13:43的读取中，FPGA有效包计数仍为0；屏幕等待数据时，确认FPGA已下载本版BIT、J5-24/F16连STM32 PA3并共地，PA3断开SIM800A。助手本次只烧录STM32，没有烧录FPGA。
'''
assert heading in text
text=text.replace(heading,heading+note,1).replace('未烧录两块实板。','STM32现已烧录并运行；FPGA未由助手烧录。')
(R/'README.md').write_text(text,encoding='utf-8')
agents=W/'AGENTS.md';text=agents.read_text(encoding='utf-8-sig')
anchor='## Current deployment: FOUR outputs, empty dashes, 1024 average (2026-10-22; supersedes below)\n'
note='''
STM32 PHYSICAL FLASH COMPLETED on 2026-10-22 at13:39, requested explicitly by user. Fire CMSIS-DAP probe FS-00000000 worked via SWD (JTAG mode did not respond). Verified DBGMCU family0x414/256KB; original full flash backed up under `reports/stm32_flash_20261022_131814/before_flash.bin`. Current HEX SHA256 a8dddcf600df039ff80e821e9a0bc257e8647344e83d90a42c16776368222539 was written, all256KB readback matched original overlaid with new HEX, untouched regions/option bytes preserved. First erase timeout was recovered after reset/halt and masking old interrupt state. Program RUNNING; LCD0x9341/font_ok1/fault flags0. Later13:43 status still received0/selected255, so FPGA-UART link/classification is not verified. FPGA was NOT programmed. Separate record `integrated/particle_identifier_20261022_four_empty_1024/verification/stm32_flash_receipt.json`; registry/model metadata has stm32_programming. Build receipt's original hardware flags describe pre-flash build time, not this later event. Isolated pyOCD environment `tools/stm32_flash/.venv`, no changes to training environment.
'''
assert anchor in text;text=text.replace(anchor,anchor+note,1)
text=text.replace('No board programming or independent acquisition test.','FPGA was not programmed; no independent acquisition test. STM32 programming is recorded above.',1)
agents.write_text(text,encoding='utf-8')
doc=W/'docs/CURRENT_BASELINE.md';text=doc.read_text(encoding='utf-8-sig')
head='# 当前使用版本：project_41 四类＋空载横线＋1024点平均\n'
note='''
2026-10-22后续：用户授权实板烧录，STM32已通过Fire CMSIS-DAP/SWD完成新HEX写入及完整256KB回读校验，原固件备份在 `reports/stm32_flash_20261022_131814`，未写入区域和选项字节保留。程序RUNNING，LCD0x9341，字体检查通过；13:43仍未收到FPGA有效结果包，屏幕/FPGA联调尚待确认。助手没有烧录FPGA。实板烧录记录为交付verification/stm32_flash_receipt.json，区别于构建时的deployment_receipt.json。
'''
assert head in text;text=text.replace(head,head+note,1)
text=text.replace('未烧录实板；旧四类同批整数分数','STM32现已烧录，FPGA尚未由助手烧录；旧四类同批整数分数',1)
doc.write_text(text,encoding='utf-8')
save(R/'SHA256.json',{str(p.relative_to(R)).replace('\\','/'):sha(p.read_bytes()) for p in R.rglob('*') if p.is_file() and p.name!='SHA256.json'})
assert all(sha((R/n).read_bytes())==h for n,h in read(R/'SHA256.json').items())
save(RUN/'completion.json',dict(programmed=True,full_flash_readback_pass=True,
    untouched_flash_preserved=True,options_preserved=True,running=True,lcd='0x9341',font_ok=True,
    received_packets=status['received'],fpga_programmed=False,receipt=record['receipt']))
print(json.dumps(read(RUN/'completion.json'),indent=2))
