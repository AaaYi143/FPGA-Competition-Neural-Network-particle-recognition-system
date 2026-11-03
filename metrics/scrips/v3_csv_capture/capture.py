"""Local CSV capture for the active EGo1 baseline in fpga/current_version.json."""
from __future__ import annotations

import csv
import hashlib
import json
from pathlib import Path
import queue
import re
import struct
import threading
import time
from datetime import datetime
from uuid import uuid4

ROOT = Path(__file__).resolve().parent
WORKSPACE = ROOT.parents[1]
CURRENT = json.loads((WORKSPACE / 'fpga/current_version.json').read_text(encoding='utf-8'))
BIT = WORKSPACE / CURRENT['bit']
EXPECTED_BIT_SHA256 = CURRENT['bit_sha256']
FIRMWARE = CURRENT['version']
SUSPECTS = ';'.join(str(i) for i in CURRENT['suspect_channels'])
HEADER = [
    'session_id', 'frame_index', 'received_at', 'elapsed_s', 'sample_label',
    'batch_id', 'gain_note', 'background_note', 'firmware', 'bit_sha256',
    'suspect_channels', 'validation',
] + [f'CH{i:02d}_code' for i in range(32)] + ['raw_frame_hex']
NAME = re.compile(r'^trial_\d{8}_\d{6}_[0-9a-f]{8}\.csv$')


class FrameParser:
    """64 payload bytes + FF FF. There is no sequence number or CRC in v3.

    FF FF cannot appear within valid payload (unsigned magnitude <= 2048).
    Reject length/range errors rather than padding, sorting or clipping values.
    """
    def __init__(self):
        self.buffer = bytearray()
        self.accepted = 0
        self.rejected = 0
        self.discarded_bytes = 0

    def feed(self, chunk: bytes) -> list[tuple[int, ...]]:
        self.buffer.extend(chunk)
        result = []
        while True:
            end = self.buffer.find(b'\xff\xff')
            if end < 0:
                if len(self.buffer) > 8192:
                    n = len(self.buffer) - 1
                    self.discarded_bytes += n
                    del self.buffer[:n]
                break
            payload = bytes(self.buffer[:end])
            del self.buffer[:end+2]
            if len(payload) != 64:
                self.rejected += 1
                self.discarded_bytes += len(payload) + 2
                continue
            values = struct.unpack('<32H', payload)
            if any(value > 2048 for value in values):
                self.rejected += 1
                self.discarded_bytes += 66
                continue
            self.accepted += 1
            result.append(values)
        return result


class DatasetStore:
    def __init__(self, directory: Path):
        self.directory = directory.resolve()
        self.directory.mkdir(parents=True, exist_ok=True)

    def create(self):
        session = datetime.now().strftime('%Y%m%d_%H%M%S') + '_' + uuid4().hex[:8]
        path = self.directory / f'trial_{session}.csv'
        # UTF-8 BOM makes Chinese labels readable when opened in Windows Excel.
        handle = path.open('x', encoding='utf-8-sig', newline='')
        writer = csv.writer(handle)
        writer.writerow(HEADER)
        handle.flush()
        return path, session, handle, writer

    def owned(self, path: Path) -> Path:
        if path.is_symlink() or path.resolve().parent != self.directory or not NAME.fullmatch(path.name):
            raise ValueError('只能删除本工具数据目录中的试验 CSV。')
        with path.open(encoding='utf-8-sig', newline='') as handle:
            if next(csv.reader(handle), None) != HEADER:
                raise ValueError('文件格式不属于本工具，拒绝删除。')
        return path

    def list(self):
        return sorted(self.directory.glob('trial_*.csv'), reverse=True)

    def delete(self, path: Path):
        self.owned(path).unlink()


def make_row(session, index, values, metadata, elapsed):
    if len(values) != 32 or any(not 0 <= v <= 2048 for v in values):
        raise ValueError('需要32个范围为0～2048的整数码值。')
    return [session, index, datetime.now().astimezone().isoformat(timespec='milliseconds'),
            f'{elapsed:.6f}', metadata['label'], metadata['batch'], metadata['gain'],
            metadata['background'], FIRMWARE, EXPECTED_BIT_SHA256, SUSPECTS,
            'length_range_only_no_crc', *values,
            (struct.pack('<32H', *values) + b'\xff\xff').hex().upper()]


class CaptureWorker:
    def __init__(self, store, port, metadata, events, opener=None, warmup=1.0, skip_frames=2):
        self.store, self.port, self.metadata, self.events = store, port, dict(metadata), events
        self.opener = opener or self.open_serial
        self.warmup, self.skip_frames = warmup, skip_frames
        self.stop_event = threading.Event()
        self.thread = None
        self.path = None
        self.saved = 0

    @staticmethod
    def open_serial(port):
        import serial
        # No serial write calls. Do not toggle DTR/RTS deliberately.
        return serial.Serial(port=port, baudrate=115200, bytesize=serial.EIGHTBITS,
                             parity=serial.PARITY_EVEN, stopbits=serial.STOPBITS_ONE,
                             timeout=0.1, xonxoff=False, rtscts=False, dsrdtr=False)

    def start(self):
        self.thread = threading.Thread(target=self.run, daemon=True)
        self.thread.start()

    def stop(self):
        self.stop_event.set()
        if self.thread:
            self.thread.join(timeout=1.5)
        return not (self.thread and self.thread.is_alive())

    def run(self):
        parser = FrameParser()
        serial_port = handle = None
        discarded_startup = 0
        started = time.monotonic()
        last_valid = started
        last_update = started
        error = None
        try:
            if not self.port or '://' in self.port:
                raise ValueError('请明确选择本机 COM 串口。')
            serial_port = self.opener(self.port)
            self.path, session, handle, writer = self.store.create()
            self.events.put(('opened', self.path))
            while not self.stop_event.is_set():
                chunk = serial_port.read(4096)
                now = time.monotonic()
                for values in parser.feed(chunk):
                    last_valid = now
                    if now - started < self.warmup:
                        continue
                    if discarded_startup < self.skip_frames:
                        discarded_startup += 1
                        continue
                    writer.writerow(make_row(session, self.saved+1, values, self.metadata, now-started))
                    handle.flush()
                    self.saved += 1
                    self.events.put(('frame', (self.saved, values)))
                if now - last_update >= 1.0:
                    self.events.put(('stats', (parser.rejected, parser.discarded_bytes,
                                               len(parser.buffer), now-last_valid)))
                    last_update = now
        except Exception as exc:
            error = f'{type(exc).__name__}: {exc}'
        finally:
            for resource in [handle, serial_port]:
                if resource is not None:
                    try:
                        resource.close()
                    except Exception as exc:
                        error = error or str(exc)
            if error:
                self.events.put(('error', error))
            self.events.put(('closed', dict(path=self.path, saved=self.saved,
                                            rejected=parser.rejected,
                                            discarded_bytes=parser.discarded_bytes)))


def main(smoke=False):
    import tkinter as tk
    from tkinter import ttk, messagebox
    import os

    class App:
        def __init__(self, window):
            self.window = window
            self.store = DatasetStore(ROOT / 'datasets')
            self.worker = None
            self.events = queue.Queue()
            self.window.title(CURRENT['display_name'] + ' · CSV 试验采集')
            self.window.geometry('920x730')
            self.window.minsize(760, 620)
            pane = ttk.Frame(window, padding=16)
            pane.pack(fill='both', expand=True)
            ttk.Label(pane, text='32 路数据 · 本机 CSV 试验采集', font=('Microsoft YaHei UI', 16)).pack(anchor='w')
            ttk.Label(pane, text='先烧录 FINAL_TEAM_CURRENT.bit；SW0=逻辑0、SW7=逻辑0；退出占用串口的 LabVIEW。').pack(anchor='w', pady=(8, 12))
            form = ttk.Frame(pane)
            form.pack(fill='x')
            self.port = tk.StringVar()
            self.label = tk.StringVar(value='试验')
            self.batch = tk.StringVar(value=datetime.now().strftime('%Y%m%d') + '_01')
            self.gain = tk.StringVar(value='未记录')
            self.background = tk.StringVar(value='人工确认SW7逻辑0，未扣背景')
            self.port_box = None
            self.editors = []
            for row, (title, variable) in enumerate([
                ('串口', self.port), ('样品／试验标签', self.label),
                ('实验批次', self.batch), ('增益备注', self.gain),
                ('背景设置备注', self.background),
            ]):
                ttk.Label(form, text=title, width=16).grid(row=row, column=0, sticky='w', pady=3)
                field = ttk.Combobox(form, textvariable=variable, width=65) if row == 0 else ttk.Entry(form, textvariable=variable, width=68)
                field.grid(row=row, column=1, sticky='ew', pady=3)
                self.editors.append(field)
                if row == 0:
                    self.port_box = field
            form.columnconfigure(1, weight=1)
            self.scan_button = ttk.Button(form, text='刷新串口', command=self.scan)
            self.scan_button.grid(row=0, column=2, padx=8)
            buttons = ttk.Frame(pane)
            buttons.pack(fill='x', pady=12)
            self.start_button = ttk.Button(buttons, text='开始采集 → 新建 CSV', command=self.start)
            self.start_button.pack(side='left')
            self.stop_button = ttk.Button(buttons, text='停止采集', command=self.stop, state='disabled')
            self.stop_button.pack(side='left', padx=8)
            ttk.Button(buttons, text='打开数据文件夹', command=lambda: os.startfile(self.store.directory)).pack(side='left')
            self.status = tk.StringVar(value='尚未开始；每次开始都会新建一个 CSV 文件。')
            ttk.Label(pane, textvariable=self.status, wraplength=840).pack(anchor='w', pady=4)
            self.details = tk.StringVar(value=f'完整32路整数码；仅标记可疑通道 {SUSPECTS}，照常保存。版本：{FIRMWARE}')
            ttk.Label(pane, textvariable=self.details, wraplength=840).pack(anchor='w', pady=4)
            self.preview = tk.StringVar(value='等待数据')
            ttk.Label(pane, textvariable=self.preview, font=('Consolas', 10), justify='left').pack(anchor='w', pady=8)
            ttk.Label(pane, text='本机试验数据集（选中文件后可删除，删除不可撤销）').pack(anchor='w', pady=(8, 4))
            self.files = tk.Listbox(pane, height=7, exportselection=False)
            self.files.pack(fill='both', expand=True)
            self.file_paths = []
            bottom = ttk.Frame(pane)
            bottom.pack(fill='x', pady=8)
            ttk.Button(bottom, text='刷新列表', command=self.refresh).pack(side='left')
            ttk.Button(bottom, text='删除所选数据集', command=self.delete).pack(side='left', padx=8)
            ttk.Label(pane, text='只检查帧长度和码值范围；当前固件没有CRC／帧序号，无法检出所有传输错误。', wraplength=840).pack(anchor='w')
            self.scan()
            self.refresh()
            self.window.protocol('WM_DELETE_WINDOW', self.close)
            self.window.after(100, self.poll)

        def scan(self):
            try:
                from serial.tools import list_ports
                ports = sorted(p.device for p in list_ports.comports())
                self.port_box['values'] = ports
                if len(ports) == 1 and not self.port.get():
                    self.port.set(ports[0])
            except Exception as exc:
                self.status.set('无法列出串口：' + str(exc))

        def refresh(self):
            self.file_paths = self.store.list()
            self.files.delete(0, 'end')
            for path in self.file_paths:
                self.files.insert('end', f'{path.name}  ({path.stat().st_size:,} 字节)')
            if self.file_paths:
                self.files.selection_set(0)

        def busy(self, active):
            self.start_button['state'] = 'disabled' if active else 'normal'
            self.stop_button['state'] = 'normal' if active else 'disabled'
            self.scan_button['state'] = 'disabled' if active else 'normal'
            for field in self.editors:
                field['state'] = 'disabled' if active else 'normal'

        def start(self):
            if self.worker and self.worker.thread.is_alive():
                return
            if not self.port.get().strip() or not self.label.get().strip() or not self.batch.get().strip():
                messagebox.showerror('缺少信息', '请选择串口，并填写试验标签和实验批次。')
                return
            if not BIT.is_file() or hashlib.sha256(BIT.read_bytes()).hexdigest() != EXPECTED_BIT_SHA256:
                messagebox.showerror('固件文件核对失败', '当前版本BIT缺失或已更改，请核对 fpga/current_version.json。')
                return
            # Finish any queued notifications from an earlier stopped capture.
            while not self.events.empty():
                self.events.get_nowait()
            self.worker = CaptureWorker(self.store, self.port.get().strip(),
                dict(label=self.label.get().strip(), batch=self.batch.get().strip(),
                     gain=self.gain.get().strip(), background=self.background.get().strip()), self.events)
            self.busy(True)
            self.status.set('正在打开串口；等待1秒并丢弃后续2个启动帧……')
            self.worker.start()

        def stop(self):
            if self.worker and not self.worker.stop():
                messagebox.showerror('正在停止', '文件尚未关闭，请稍后再次停止。')
                return False
            self.busy(False)
            return True

        def delete(self):
            selected = self.files.curselection()
            if not selected:
                return
            path = self.file_paths[selected[0]]
            if not messagebox.askyesno('删除试验数据', f'永久删除这一个 CSV？\n{path.name}\n若正在采集，将先停止采集。'):
                return
            if self.worker and self.worker.path == path and not self.stop():
                return
            try:
                self.store.delete(path)
                self.refresh()
                self.status.set('已删除：' + path.name)
            except Exception as exc:
                messagebox.showerror('删除失败', str(exc))

        def poll(self):
            latest = None
            try:
                while True:
                    kind, payload = self.events.get_nowait()
                    if kind == 'opened':
                        self.status.set('文件已新建，等待有效数据：' + payload.name)
                        self.refresh()
                    elif kind == 'frame':
                        latest = payload
                    elif kind == 'stats':
                        rejected, discarded, pending, silence = payload
                        self.details.set(f'拒绝帧／片段：{rejected}；丢弃字节：{discarded}；待解析字节：{pending}；距上次有效帧 {silence:.1f} 秒')
                        if silence > 5:
                            self.status.set('超过5秒无有效帧：检查当前固件、SW0、串口和接线。')
                    elif kind == 'error':
                        messagebox.showerror('采集停止', payload + '\n若提示拒绝访问，请退出占用串口的上位机。')
                    elif kind == 'closed':
                        latest = None
                        self.busy(False)
                        self.status.set(f"采集已停止，本次保存 {payload['saved']} 帧。")
                        self.refresh()
            except queue.Empty:
                pass
            if latest and self.worker and self.worker.thread.is_alive():
                count, values = latest
                self.status.set(f'正在采集，已保存 {count} 帧；每帧写入后刷新 CSV 文件。')
                self.preview.set('\n'.join('  '.join(f'{i:02d}:{values[i]:4d}' for i in range(j, j+8)) for j in range(0, 32, 8)))
            self.window.after(100, self.poll)

        def close(self):
            if self.stop():
                self.window.destroy()

    window = tk.Tk()
    if smoke:
        window.withdraw()
    app = App(window)
    if smoke:
        assert app.start_button.cget('text') == '开始采集 → 新建 CSV'
        assert app.worker is None
        window.after(100, app.close)
    window.mainloop()


if __name__ == '__main__':
    main()
