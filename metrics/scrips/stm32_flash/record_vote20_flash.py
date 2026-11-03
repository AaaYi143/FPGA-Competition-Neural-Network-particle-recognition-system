"""Independently verify the physical readback and record STM32 programming history."""
from pathlib import Path
import argparse
import hashlib
import json
import shutil
from intelhex import IntelHex

W = Path(__file__).resolve().parents[2]
R = W/'integrated/particle_identifier_20261023_sw6_vote20_512'


def read(p):
    return json.loads(p.read_text(encoding='utf-8-sig'))


def save(p, data):
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--run', type=Path, required=True)
    run = parser.parse_args().run.resolve()
    receipt, status = read(run/'flash_receipt.json'), read(run/'latest_status.json')
    assert receipt['programmed'] and receipt['readback_verified'] and receipt['option_bytes_unchanged']
    firmware = R/'output/STM32_PARTICLE_VOTE20.hex'
    assert sha(firmware.read_bytes()) == receipt['firmware_sha256'] == read(R/'verification/deployment_receipt.json')['stm32_hex_sha256']
    before, after = (run/'before_flash.bin').read_bytes(), (run/'after_flash.bin').read_bytes()
    assert len(before) == len(after) == 262144
    assert sha(before) == receipt['before_flash_sha256'] and sha(after) == receipt['after_flash_sha256']
    expected = bytearray(before)
    image = IntelHex(str(firmware))
    for start, end in image.segments():
        expected[start-0x08000000:end-0x08000000] = bytes(image[i] for i in range(start, end))
    assert after == expected
    assert status['state'] == 'RUNNING' and status['lcdid'] == 0x9341
    receipt.update(latest_status=status,
        original_backup=str((run/'before_flash.bin').relative_to(W)).replace('\\', '/'),
        readback_file=str((run/'after_flash.bin').relative_to(W)).replace('\\', '/'),
        note='Physical STM32 programming is later than the build receipt. FPGA was not programmed.')
    save(R/'verification/stm32_flash_receipt.json', receipt)
    shutil.copy2(run/'latest_status.json', R/'verification/stm32_running_status.json')
    shutil.copy2(run/'program_and_verify.log', R/'verification/stm32_program_and_verify.log')
    if (run/'finish_running_check.log').exists():
        shutil.copy2(run/'finish_running_check.log', R/'verification/stm32_finish_running_check.log')
    record = dict(programmed=True, protocol='SWD via Fire CMSIS-DAP', time_local=receipt['time_local'],
        receipt='integrated/particle_identifier_20261023_sw6_vote20_512/verification/stm32_flash_receipt.json',
        firmware_sha256=receipt['firmware_sha256'], full_flash_readback_verified=True,
        untouched_flash_preserved=True, options_preserved=True, lcd_id='0x9341',
        received_packets_at_last_check=status['vote']['accepted'],
        vote_online_at_last_check=status['vote']['online'], fpga_programmed=False)
    reg = read(W/'fpga/current_version.json')
    if reg['version'] == 'project41_sw6_vote20_512_20261024':
        if not (run/'current_version.before.json').exists():
            shutil.copy2(W/'fpga/current_version.json', run/'current_version.before.json')
        reg['stm32_programming'] = record
        save(W/'fpga/current_version.json', reg)
    for path in [R/'verification/deployment_receipt.json', W/'fpga/variants/project41_sw6_vote20_512_20261024.json']:
        data = read(path)
        data['stm32_programming'] = record
        save(path, data)
    save(run/'completion.json', record)
    save(R/'SHA256.json', {str(p.relative_to(R)).replace('\\','/'): sha(p.read_bytes())
        for p in R.rglob('*') if p.is_file() and p.name!='SHA256.json' and '__pycache__' not in p.parts})
    print(json.dumps(record, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
