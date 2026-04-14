#!/usr/bin/env bash
#
################################################################################
# Config
# set:
# -e: if it finds any error, it ends the execution immediately
set -e
#
# ============================================
# show banner
# ============================================
# link: https://patorjk.com/software/taag/#p=display&f=Big%20Money-ne&t=Base%20Install
show_header(){
cat << "HEADER"
 /$$$$$$$                                      /$$$$$$                       /$$               /$$ /$$
| $$__  $$                                    |_  $$_/                      | $$              | $$| $$
| $$  \ $$  /$$$$$$   /$$$$$$$  /$$$$$$         | $$   /$$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$ | $$| $$
| $$$$$$$  |____  $$ /$$_____/ /$$__  $$        | $$  | $$__  $$ /$$_____/|_  $$_/   |____  $$| $$| $$
| $$__  $$  /$$$$$$$|  $$$$$$ | $$$$$$$$        | $$  | $$  \ $$|  $$$$$$   | $$      /$$$$$$$| $$| $$
| $$  \ $$ /$$__  $$ \____  $$| $$_____/        | $$  | $$  | $$ \____  $$  | $$ /$$ /$$__  $$| $$| $$
| $$$$$$$/|  $$$$$$$ /$$$$$$$/|  $$$$$$$       /$$$$$$| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$| $$
|_______/  \_______/|_______/  \_______/      |______/|__/  |__/|_______/    \___/   \_______/|__/|__/
                                                                          Developed by Sebastian Weigl
  install script for OpenBSD    

HEADER
}
#
##########################################################
# 1 #
##########################################################
install_system_tools(){
  echo
  echo "############################################"
  echo " Install sytem tools"
  echo "############################################"
  #
  pkg_add \
    f3 \
    zip \
    bat \
    most \
    bash \
    nano \
    tree \
    lnav \
    stow \
    unrar \
    rsync \
    bzip2 \
    sl-ls \
    acpica \
    ntfs_3g \
    texinfo \
    colorls \
    rarcrack \
    autoconf \
    whowatch \
    gettext-tools \
    bash-completion
}
#
##########################################################
# 2 #
##########################################################
install_info(){
  echo
  echo "############################################"
  echo " Install info tools"
  echo "############################################"
  #
  pkg_add \
    fzf \
    htop \
    ncdu \
    btop \
    tree \
    lscpu \
    lsblk \
    iperf3 \
    pstree \
    fastfetch \
    dmidecode \
    smartmontools
}
#
##########################################################
# 3 #
##########################################################
install_dev_tools(){
  echo
  echo "############################################"
  echo " Install development tools"
  echo "############################################"
  #
  pkg_add \
    git \
    gcc \
    g++ \
    bison \
    cmake \
    gmake \
    lowdown \
    libtool \
    automake \
    autoconf \
    shellcheck \
    clang-tools-extra
}
#
##########################################################
# 4 #
##########################################################
install_net_tools(){
  echo
  echo "############################################"
  echo " Install network tools"
  echo "############################################"
  #
  pkg_add \
    lynx \
    curl \
    wget \
    samba \
    ipcalc \
    sipcalc \
    minicom \
    arpwatch \
    ssh-askpass-fullscreen
}
#
##########################################################
# 5 #
##########################################################
install_utils(){
  echo
  echo "############################################"
  echo " Install utils"
  echo "############################################"
  #
  pkg_add \
    usbutils \
    binutils \
    pciutils \
    uniutils \
    dateutils \
    moreutils \
    coreutils \
    findutils \
    exfat-fuse \
    fuse-utils
}
#
##########################################################
# 6 #
##########################################################
install_inxi(){
  echo
  echo "############################################"
  echo " Install Inxi"
  echo "############################################"
  #
  pushd /tmp
  wget -O inxi https://smxi.org/inxi
  chmod +x inxi
  mv inxi /usr/local/bin/
  popd
  #
}
#
##########################################################
# 7 #
##########################################################
install_graphic_tools(){
  echo
  echo "############################################"
  echo " Install graphic tools"
  echo "############################################"
  #
  pkg_add \
    gv \
    a2ps \
    groff \
    dialog \
    graphviz \
    imagemagick
}
#
##########################################################
# 8 #
##########################################################
create_profile(){
  echo
  echo "############################################"
  echo " create .profile"
  echo "############################################"
  #
  cat << EOF >> ~/.profile
'''
####
##
PS1='[\D{%H:%M:%S %a %d %b} \u@\h]:\n\w \\$ '
#
# for colored terminal output
export TERM=wsvt25
export LSCOLORS=gxfxcxdxbxegedabagacad
##
if command -v colorls > /dev/null; then
  LS='colorls'
else
  LS='ls'
fi
#
alias ls="$LS -FHh"
##
export CLICOLOR=1
export COLORIZE=1
#
export EDITOR=/usr/local/bin/nano
export HISTSIZE=5000
export HISTFILESIZE=500
#
export PAGER=most
export LESS='-iMRS -x2'
#
alias ..='cd ..'
alias cl='clear'
alias grep='grep -ni'
alias mkdir='mkdir -p'
alias updatedb='doas /usr/libexec/locate.updatedb'
alias make='make -j19'
alias sl='sl -a'
alias btop='btop --force-utf'
'''
EOF
  #
}
#
########################### MAIN #########################
show_header
sleep 2
pkg_add -Uu
#
sleep 2
create_profile        # 8 #
#
sleep 2
install_system_tools  # 1 #
sleep 2
install_info          # 2 #
sleep 2
install_dev_tools     # 3 #
sleep 2
install_net_tools     # 4 #
sleep 2
install_utils         # 5 #
sleep 2
install_graphic_tools # 7 #
sleep 2
install_inxi          # 6 #
#
syspatch
fw_update
/usr/libexec/locate.updatedb
#
##########################################################
# end of script #
##########################################################
echo "############################################"
echo "Done! all packages have been installed "
echo "############################################"