
with open("out/source.txt", "rt") as f:
    source_lines = f.readlines()

with open("src/template.md", "rt") as f:
    template = f.read()

for i, line in enumerate(source_lines):
    source_lines[i] = line.lstrip()
source = "".join(source_lines).upper()

print(template.format(src=source))
