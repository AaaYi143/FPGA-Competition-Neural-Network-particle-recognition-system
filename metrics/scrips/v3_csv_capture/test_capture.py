"""Offline tests; no physical COM port is opened."""
import csv
import queue
import random
import shutil
import struct
from pathlib import Path

import pytest

from capture import CaptureWorker, DatasetStore, FrameParser, HEADER, make_row


@pytest.fixture
def tmp_path():
    # Use ordinary Windows directory permissions in the writable workspace;
    # sandboxed pytest's default mode-0700 temporary root is inaccessible here.
    from uuid import uuid4
    root = Path(__file__).resolve().parent / 'test_runs'
    root.mkdir(exist_ok=True)
    target = root / uuid4().hex
    target.mkdir()
    try:
        yield target
    finally:
        assert target.resolve().parent == root.resolve()
        shutil.rmtree(target)


def packet(values):
    return struct.pack('<32H', *values) + b'\xff\xff'


def test_arbitrary_chunks_preserve_all_channels_and_little_endian():
    values = tuple([0, 1, 3, 255, 256, 2047, 2048] + list(range(25)))
    stream = packet(values) * 8
    parser = FrameParser()
    result = []
    randomizer = random.Random(42)
    while stream:
        n = randomizer.randint(1, 31)
        result.extend(parser.feed(stream[:n]))
        stream = stream[n:]
    assert result == [values] * 8
    assert parser.accepted == 8 and parser.rejected == 0
    assert not parser.buffer


def test_partial_frame_bad_range_and_byte_drop_resynchronize():
    good = packet(list(range(32)))
    invalid = packet([2049] + [0]*31)
    parser = FrameParser()
    stream = b'noise' + good[20:] + invalid + good[:-8] + good + good
    result = parser.feed(stream)
    # The truncated frame and its following frame are rejected together. The
    # second complete frame after that is aligned by its preceding FF FF.
    assert result == [tuple(range(32))]
    assert parser.rejected == 3
    assert parser.discarded_bytes > 0


def test_split_trailer_and_no_unbounded_buffer():
    parser = FrameParser()
    good = packet([1]*32)
    assert not parser.feed(good[:-1])
    assert parser.feed(good[-1:]) == [(1,)*32]
    assert not parser.feed(b'x'*100000)
    assert len(parser.buffer) == 1
    assert parser.discarded_bytes == 99999


def test_csv_roundtrip_and_delete_only_owned_dataset(tmp_path):
    store = DatasetStore(tmp_path / 'datasets')
    path, session, handle, writer = store.create()
    metadata = dict(label='试验,玻璃珠', batch='批次1', gain='固定', background='SW7=0')
    writer.writerow(make_row(session, 1, tuple(range(32)), metadata, 1.25))
    handle.close()
    assert path.read_bytes().startswith(b'\xef\xbb\xbf')
    with path.open(encoding='utf-8-sig', newline='') as f:
        row = next(csv.DictReader(f))
    assert row['sample_label'] == '试验,玻璃珠'
    assert row['CH00_code'] == '0' and row['CH31_code'] == '31'
    assert bytes.fromhex(row['raw_frame_hex']) == packet(list(range(32)))
    assert row['suspect_channels'] == '0;1'
    assert row['firmware'] == 'teammate_20261018'
    assert store.list() == [path]
    store.delete(path)
    assert not path.exists()
    assert store.list() == []


def test_delete_rejects_outside_paths_unrelated_files_and_wrong_headers(tmp_path):
    store = DatasetStore(tmp_path / 'datasets')
    foreign = tmp_path / 'trial_20261016_120000_12345678.csv'
    foreign.write_text('important data', encoding='utf-8')
    with pytest.raises(ValueError):
        store.delete(foreign)
    wrong_name = store.directory / 'important.csv'
    wrong_name.write_text('important data', encoding='utf-8')
    with pytest.raises(ValueError):
        store.delete(wrong_name)
    wrong_header = store.directory / foreign.name
    wrong_header.write_text('important data', encoding='utf-8')
    with pytest.raises(ValueError):
        store.delete(wrong_header)
    assert foreign.exists() and wrong_name.exists() and wrong_header.exists()


class FakeSerial:
    def __init__(self, chunks, stop):
        self.chunks, self.stop = list(chunks), stop
        self.closed = False

    def read(self, _size):
        if self.chunks:
            return self.chunks.pop(0)
        self.stop.set()
        return b''

    def close(self):
        self.closed = True


def test_capture_worker_skips_startup_writes_frames_closes_and_can_delete(tmp_path):
    store = DatasetStore(tmp_path)
    events = queue.Queue()
    worker = CaptureWorker(store, 'COM_TEST', dict(label='trial', batch='test', gain='G', background='off'),
                           events, warmup=0, skip_frames=2)
    fake = FakeSerial([packet([n]*32) for n in [1, 2, 3, 4]], worker.stop_event)
    worker.opener = lambda port: fake
    worker.start()
    worker.thread.join(timeout=2)
    assert not worker.thread.is_alive()
    assert fake.closed and worker.saved == 2
    with worker.path.open(encoding='utf-8-sig', newline='') as f:
        rows = list(csv.DictReader(f))
    assert [r['CH31_code'] for r in rows] == ['3', '4']
    notifications = list(events.queue)
    assert not any(kind == 'error' for kind, _ in notifications)
    assert notifications[-1][0] == 'closed'
    store.delete(worker.path)


def test_serial_open_failure_does_not_create_misleading_dataset(tmp_path):
    store = DatasetStore(tmp_path)
    def busy(_port):
        raise PermissionError('port busy')
    events = queue.Queue()
    worker = CaptureWorker(store, 'COM_TEST', {}, events, opener=busy)
    worker.run()
    assert not store.list()
    assert list(events.queue)[0][0] == 'error'


def test_empty_trial_remains_valid_and_deletable(tmp_path):
    store = DatasetStore(tmp_path)
    path, _session, handle, _writer = store.create()
    handle.close()
    assert store.owned(path) == path
    with path.open(encoding='utf-8-sig', newline='') as f:
        assert list(csv.reader(f)) == [HEADER]
    store.delete(path)
