#!/bin/sh -xe

mkdir -p out

cp src/bootstrap.txt out/linked.txt
acme src/xfer.asm
python3 src/encode.py >> out/linked.txt
petcat -w2 -o out/bootstrap.prg out/linked.txt
petcat -nh out/bootstrap.prg | tr a-z A-Z > README.md
