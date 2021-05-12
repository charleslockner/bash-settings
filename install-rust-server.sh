#!/bin/sh
# https://rust-analyzer.github.io/manual.html#building-from-source
git clone https://github.com/rust-analyzer/rust-analyzer.git && cd rust-analyzer
cargo xtask install --server
#/usr/bin/....
python3 -m pip install --user --upgrade pynvim
