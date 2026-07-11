#!/usr/bin/env bash
#
set -e
## build xxd on openbsd
#
# ============================================
# show banner
# ============================================
# link: https://patorjk.com/software/taag/#p=display&f=Big%20Money-ne&t=Base%20Install
show_header(){
cat << "HEADER"
                           /$$       /$$$$$$                       /$$               /$$ /$$
                          | $$      |_  $$_/                      | $$              | $$| $$
 /$$   /$$ /$$   /$$  /$$$$$$$        | $$   /$$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$ | $$| $$
|  $$ /$$/|  $$ /$$/ /$$__  $$        | $$  | $$__  $$ /$$_____/|_  $$_/   |____  $$| $$| $$
 \  $$$$/  \  $$$$/ | $$  | $$        | $$  | $$  \ $$|  $$$$$$   | $$      /$$$$$$$| $$| $$
  >$$  $$   >$$  $$ | $$  | $$        | $$  | $$  | $$ \____  $$  | $$ /$$ /$$__  $$| $$| $$
 /$$/\  $$ /$$/\  $$|  $$$$$$$       /$$$$$$| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$| $$
|__/  \__/|__/  \__/ \_______/      |______/|__/  |__/|_______/    \___/   \_______/|__/|__/
                                                                Developed by Sebastian Weigl
  xxd install script for OpenBSD

HEADER
}
#
#
##########################################################
# 0 #
##########################################################
show_version(){
  echo
  echo "############################################"
  echo " 1.5 -- 11.07.2026 "
  echo "############################################"
}
#
# create the opt dir if it does not exists
[[ -d /usr/opt ]] && echo "opt is present" || mkdir /usr/opt
pushd /usr/opt
# check if xxd already exists
[[ -e xxd/ ]] && rm -rf xxd/ || echo "done"
# get the unofficial build -- easy build
git clone https://github.com/ckormanyos/xxd
cd xxd/
# change min required version from 3.1 to 3.5
sed -i 's/3.1/3.5/' CMakeLists.txt
sed -i 's/11/17/' CMakeLists.txt
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
clang++ -x c -std=c19 -O2 -Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion -Wint-conversion -Wshadow src/xxd.c -o xxd
## ...
popd
