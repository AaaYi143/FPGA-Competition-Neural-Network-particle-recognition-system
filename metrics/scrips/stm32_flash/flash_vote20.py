"""Identify/backup, then flash the verified particle-display image via one CMSIS-DAP."""
from pathlib import Path
import argparse,hashlib,json,logging,time
from pyocd.core.helpers import ConnectHelper
from pyocd.core.session import Session
from pyocd.flash.file_programmer import FileProgrammer
from intelhex import IntelHex
from elftools.elf.elffile import ELFFile

W=Path(__file__).resolve().parents[2]
DEL=W/'integrated/particle_identifier_20261023_sw6_vote20_512'
BASE=0x08000000
SIZE=256*1024
PROBE='FS-00000000'
def sha(data):return hashlib.sha256(data).hexdigest()
def save(path,data):path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def read(path):return json.loads(path.read_text(encoding='utf-8-sig'))
def memory(target,address,length):
    data=bytearray()
    for i in range(0,length,4096):data.extend(target.read_memory_block8(address+i,min(4096,length-i)))
    return bytes(data)
def identity(target):
    result=dict(dbgmcu_idcode=target.read32(0xE0042000),flash_kb=target.read16(0x1FFFF7E0),
                cpuid=target.read32(0xE000ED00),uid=memory(target,0x1FFFF7E8,12).hex())
    if (result['dbgmcu_idcode']&0xfff)!=0x414 or result['flash_kb']!=256:
        raise RuntimeError('Target is not the expected STM32F103 high-density/256KB device: '+str(result))
    return result
def vote_status(symbols,target):
    import struct
    found=symbols.get_symbol_by_name('vote')
    if not found:return {}
    sym=next((x for x in found if int(x['st_size'])==48),None)
    if sym is None:raise RuntimeError('Unexpected ParticleVote layout; refuse misleading status')
    b=memory(target,int(sym['st_value']),48)
    v=struct.unpack('<20B4B8B4I',b)
    return dict(count=v[25],winner=v[26],online=bool(v[27]),empty=bool(v[28]),
        sequence=v[30],votes=list(v[20:24]),last_fresh_ms=v[32],accepted=v[33],
        duplicates=v[34],missing=v[35])

def main():
    a=argparse.ArgumentParser()
    a.add_argument('phase',choices=['inspect','diagnose','flash','status','complete'])
    a.add_argument('--protocol',choices=['jtag','swd'],required=True)
    a.add_argument('--run',type=Path,required=True)
    a.add_argument('--verbose',action='store_true')
    a.add_argument('--recover',action='store_true',help='Resume our interrupted write using its verified original backup')
    args=a.parse_args();run=args.run.resolve();run.mkdir(parents=True,exist_ok=True)
    logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO,format='%(levelname)s: %(message)s')
    receipt=read(DEL/'verification/deployment_receipt.json')
    firmware=DEL/'output/STM32_PARTICLE_VOTE20.hex'
    assert sha(firmware.read_bytes())==receipt['stm32_hex_sha256']=='81eb93b41f6d19fe58f72b677779ab2046157a382c3f41492e5edafc74848ece'
    hx=IntelHex(str(firmware));segments=hx.segments()
    assert min(hx.addresses())==BASE and max(hx.addresses())<BASE+SIZE
    vector=bytes(hx[BASE+i] for i in range(8))
    sp=int.from_bytes(vector[:4],'little');reset=int.from_bytes(vector[4:],'little')
    assert 0x20000000<sp<=0x2000C000 and BASE<reset<BASE+SIZE and reset&1
    probes=ConnectHelper.get_all_connected_probes(blocking=False)
    assert len(probes)==1 and probes[0].unique_id==PROBE,'Expected the single Fire CMSIS-DAP probe'
    options=dict(target_override='stm32f103rc',frequency=500000,dap_protocol=args.protocol,
        auto_unlock=False,connect_mode='attach' if args.phase=='status' else 'halt',
        resume_on_disconnect=args.phase in ('inspect','status'),no_config=True,
        user_script=None,project_dir=str(run),hide_programming_progress=True,
        **{'cache.enable_memory':False,'cache.enable_register':False})
    session=Session(probes[0],options=options)
    if session is None:raise RuntimeError('Probe disappeared')
    with session:
        target=session.target
        actual=identity(target)
        print('TARGET_CONFIRMED '+json.dumps(actual),flush=True)
        if args.phase=='status':
            assert actual==read(run/'flash_receipt.json')['target']
            result=dict(state=target.get_state().name,time_local=time.strftime('%Y-%m-%d %H:%M:%S %z'))
            with (DEL/'output/STM32_PARTICLE_VOTE20.elf').open('rb') as f:
                symbols=ELFFile(f).get_section_by_name('.symtab')
                for name in ['lcdid','font_ok','received','selected','last_status','uwTick']:
                    found=symbols.get_symbol_by_name(name)
                    if found:
                        s=found[0];size=int(s['st_size'])
                        if size in (1,2,4):result[name]=int.from_bytes(memory(target,int(s['st_value']),size),'little')
                result['vote']=vote_status(symbols,target)
            save(run/'latest_status.json',result)
            print('STATUS '+json.dumps(result),flush=True)
            return
        if args.phase=='diagnose':
            registers={n:target.read_core_register(n) for n in ['pc','sp','lr','xpsr','r0','r1','r2','r3','control','primask']}
            registers.update({name:target.read32(address) for name,address in [
                ('FLASH_ACR',0x40022000),('FLASH_SR',0x4002200C),('FLASH_CR',0x40022010),
                ('RCC_CR',0x40021000),('RCC_CFGR',0x40021004),('HFSR',0xE000ED2C),('CFSR',0xE000ED28)]})
            registers['flash_head']=memory(target,BASE,64).hex()
            save(run/'diagnose.json',registers)
            print(json.dumps(registers,indent=2),flush=True)
            return
        if args.phase=='inspect':
            assert not (run/'before_flash.bin').exists(),'Never overwrite an existing backup'
            print('Reading the full 256KB original flash...',flush=True)
            original=memory(target,BASE,SIZE)
            assert len(original)==SIZE
            original_options=memory(target,0x1FFFF800,16)
            (run/'before_flash.bin').write_bytes(original)
            (run/'before_options.bin').write_bytes(original_options)
            reread=memory(target,BASE,SIZE)
            assert reread==original,'Backup reread differs'
            result=dict(target=actual,probe=PROBE,description=probes[0].description,
                protocol=args.protocol,flash_address=BASE,flash_bytes=SIZE,
                backup_sha256=sha(original),backup_reread_verified=True,
                option_bytes=original_options.hex(),firmware_sha256=sha(firmware.read_bytes()),
                flash_written=False)
            save(run/'target_and_backup.json',result)
            print('BACKUP_PASS '+result['backup_sha256'],flush=True)
            return
        backup=read(run/'target_and_backup.json')
        assert actual==backup['target'] and args.protocol==backup['protocol']
        original=(run/'before_flash.bin').read_bytes()
        assert len(original)==SIZE and sha(original)==backup['backup_sha256']
        assert sha(firmware.read_bytes())==backup['firmware_sha256']
        before_attempt=memory(target,BASE,SIZE)
        sector_end=((max(hx.addresses())-BASE+1+2047)//2048)*2048
        if args.phase=='complete':
            pass  # Verify and finish the already-written image; never erase/program again.
        elif args.recover:
            assert 'FlashEraseFailure' in (run/'program_and_verify.log').read_text(encoding='utf-8-sig')
            assert before_attempt[sector_end:]==original[sector_end:],'Unrelated flash changed; stop recovery'
            (run/'interrupted_flash.bin').write_bytes(before_attempt)
        else:
            assert before_attempt==original,'Flash changed since backup; stop before writing'
        expected=bytearray(original)
        for start,end in segments:
            expected[start-BASE:end-BASE]=bytes(hx[i] for i in range(start,end))
        if args.phase!='complete':
            # Reset peripheral/exception state before running the RAM flash algorithm.
            # A pre-existing SysTick/IRQ must not fetch a vector while its flash page is erased.
            target.reset_and_halt()
            target.write_core_register('primask',1)
            target.write32(0xE000E010,0)
            image=run/'merged_flash_sectors.bin'
            image.write_bytes(expected[:sector_end])
            print('Programming verified HEX; sector erase only, preserving unwritten bytes...',flush=True)
            FileProgrammer(session,chip_erase='sector',smart_flash=False,trust_crc=False,
                           keep_unwritten=True).program(str(image),file_format='bin',base_address=BASE)
        target.halt()
        print('Reading back all 256KB to verify image and untouched flash...',flush=True)
        readback=memory(target,BASE,SIZE)
        (run/'after_flash.bin').write_bytes(readback)
        assert readback==expected,'Flash readback mismatch; do not mark programming successful'
        assert memory(target,0x1FFFF800,16).hex()==backup['option_bytes'],'Option bytes changed unexpectedly'
        print('FLASH_READBACK_PASS',flush=True)
        target.reset();target.resume();time.sleep(1)
        state=target.get_state().name
        target.halt()
        runtime=dict(state_before_halt=state,pc=target.read_core_register('pc'),
                     cfsr=target.read32(0xE000ED28),hfsr=target.read32(0xE000ED2C))
        with (DEL/'output/STM32_PARTICLE_VOTE20.elf').open('rb') as f:
            symbols=ELFFile(f).get_section_by_name('.symtab')
            for name in ['lcdid','font_ok','received','selected','last_status','uwTick']:
                found=symbols.get_symbol_by_name(name)
                if found:
                    s=found[0];size=int(s['st_size'])
                    if size in (1,2,4):runtime[name]=int.from_bytes(memory(target,int(s['st_value']),size),'little')
            runtime['vote']=vote_status(symbols,target)
        target.resume()
        result=dict(programmed=True,readback_verified=True,all_unwritten_flash_preserved=True,
            option_bytes_unchanged=True,target=actual,probe=PROBE,protocol=args.protocol,
            firmware=str(firmware),firmware_sha256=sha(firmware.read_bytes()),
            flash_start=BASE,image_segments=segments,programmed_bytes=len(hx.addresses()),
            before_flash_sha256=sha(original),after_flash_sha256=sha(readback),
            runtime=runtime,fpga_programmed=False,
            time_local=time.strftime('%Y-%m-%d %H:%M:%S %z'))
        save(run/'flash_receipt.json',result)
        print('PROGRAMMING_COMPLETE '+json.dumps(result,ensure_ascii=False),flush=True)

if __name__=='__main__':main()
