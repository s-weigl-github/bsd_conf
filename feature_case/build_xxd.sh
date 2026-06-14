#!/usr/bin/env bash
#
## build xxd on openbsd
#
# create the opt dir if it does not exists
[[ -d /usr/opt ]] && echo "opt is present" || mkdir /usr/opt
pushd /usr/opt
# get the unofficial build -- easy build
git clone https://github.com/ckormanyos/xxd
cd xxd/
mkdir build
cd src/
# get the most recent version to build from the official repo
wget -O https://raw.githubusercontent.com/vim/vim/refs/heads/master/src/xxd/xxd.c xxd.c
cd ../build/
cmake .. -G Ninja && ninja
cd ..
clang++ -x c -std=c17 -O2 -Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion -Wint-conversion -Wshadow src/xxd.c -o xxd
## ...
popd
