import base64

f = open("out/xfer.bin", "rb")
data = None

with open("out/xfer.bin", "rb") as f:
    data = f.read()

blocks = []
checksum = sum(data)

data = data.ljust((len(data) + 4) // 5 * 5, b'\0')
while data:
    block = data[:5]
    data = data[5:]
    s = base64.b32encode(block).decode().lower()
    blocks.append(s)

print(f'900 data {len(blocks)}, {checksum}')
line = 901
while len(blocks):
    if len(blocks) > 1:
        print(f'{line} data "{blocks.pop(0)}", "{blocks.pop(0)}"')
    else:
        print(f'{line} data "{blocks.pop(0)}"')
    line += 1
