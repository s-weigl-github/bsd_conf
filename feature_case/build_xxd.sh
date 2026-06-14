#!/usr/bin/env bash
#
## build xxd on openbsd
#
# create the opt dir if it does not exists
[[ -d /usr/opt ]] && echo "opt is present" || mkdir /usr/opt
pushd /usr/opt
# check if xxd already exists
[[ -d /xxd ]] && rm -rf xxd/ || exit 0
# get the unofficial build -- easy build
git clone https://github.com/ckormanyos/xxd
cd xxd/
# change min required version from 3.1 to 3.5
sed -i 's/3.1/3.5/' CMakeLists.txt
#
mkdir build
cd src/
mv xxd.c xxd.c.old # rename the existing file
# get the most recent version to build from the official repo
wget https://raw.githubusercontent.com/vim/vim/refs/heads/master/src/xxd/xxd.c
# change sprintf and strcpy in xxd.c
sed -i 's/sprintf/snprintf/' xxd.c
sed -i 's/strcpy/strlcpy/' xxd.c
#
echo "changes done"
sleep 5
echo "start building"
sleep 2
#
cd ../build/
cmake .. -G Ninja && ninja
cd ..
clang++ -x c -std=c17 -O2 -Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion -Wint-conversion -Wshadow src/xxd.c -o xxd
## ...
popd
