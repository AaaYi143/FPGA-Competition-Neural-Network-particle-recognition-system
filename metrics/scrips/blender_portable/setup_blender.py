"""Fetch an official portable Blender 5.2 build and verify its published SHA256."""
from pathlib import Path
import hashlib
import json
import re
import urllib.request
import zipfile

root = Path(__file__).resolve().parent
base = 'https://download.blender.org/release/Blender5.2/'
def fetch(url):
    return urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'}), timeout=60)

with fetch(base) as response:
    listing = response.read().decode()
names = sorted(set(re.findall(r'blender-5\.2\.\d+-windows-x64\.zip', listing)),
               key=lambda n: int(n.split('-')[1].split('.')[-1]))
assert names, 'No official Windows x64 archive found'
name = names[-1]
version = name.split('-')[1]
hash_name = f'blender-{version}.sha256'
with fetch(base + hash_name) as response:
    checksums = response.read().decode()
hash_lines = [line for line in checksums.splitlines() if name in line]
assert len(hash_lines) == 1
expected = hash_lines[0].split()[0].lower()
assert re.fullmatch('[0-9a-f]{64}', expected)
archive = root / name
if not archive.exists() or hashlib.sha256(archive.read_bytes()).hexdigest() != expected:
    temp = root / (name + '.partial')
    with fetch(base + name) as response, temp.open('wb') as output:
        count = 0
        while data := response.read(4*1024*1024):
            output.write(data)
            count += len(data)
            if count % (32*1024*1024) == 0:
                print(f'Downloaded {count//1024//1024} MiB', flush=True)
    assert hashlib.sha256(temp.read_bytes()).hexdigest() == expected, 'Official hash mismatch'
    temp.replace(archive)
with zipfile.ZipFile(archive) as z:
    for member in z.namelist():
        target = (root / member).resolve()
        assert target.is_relative_to(root.resolve()), 'Unsafe archive path'
    z.extractall(root)
executable = root / name.removesuffix('.zip') / 'blender.exe'
assert executable.is_file()
receipt = {'version': version, 'archive_url': base+name, 'sha256': expected, 'executable': str(executable)}
(root/'runtime.json').write_text(json.dumps(receipt, indent=2), encoding='utf-8')
print(json.dumps(receipt), flush=True)
