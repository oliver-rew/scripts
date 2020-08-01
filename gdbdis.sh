#!/bin/bash

# this is a simple macro for gdb's disassemble output, which is often superior
# to objdump

BIN=$1
FUNC=$2

gdb $BIN -batch -ex "disassemble $FUNC" 
