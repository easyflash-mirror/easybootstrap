#!/bin/sh -xe

mkdir -p out

# Append the encoded machine code to the BASIC source code
cp src/bootstrap.txt out/linked.txt
acme src/xfer.asm
python3 src/encode.py >> out/linked.txt

# Convert the BASIC file back and forth to remove empty lines etc.
petcat -w2 -o out/bootstrap.prg out/linked.txt
petcat -nh out/bootstrap.prg | tr a-z A-Z > out/source.txt

# Insert the BASIC file into README template 
python3 src/postprocess.py > README.md
