
f = open("out/xfer.bin", "rb")
data = None

with open("out/xfer.bin", "rb") as f:
    data = f.read()

blocks = []
data_len = len(data)
checksum = sum(data)

while data:
    block = data[:3]
    data = data[3:]
    s = block.hex()
    blocks.append(s)

print(f'50 data {data_len},{checksum}')
line = 51
while len(blocks):
    left = blocks[:4]
    blocks = blocks[4:]
    s = " ".join(left)
    print(f'{line} data "{s}"')
    line += 1
