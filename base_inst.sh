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
    bwm-ng \
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
    screen \
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
  # test if .profile exists
  [[ -e ~/.profile ]] && mv ~/.profile ~/.profile.old || exit 0
  #
  cat << EOF >> ~/.profile
####
##
#PS1='[\D{%H:%M:%S %a %d %b} \u@\h]:\n\w \\$ '
PS1='[\[\e[35m\]\D{%H:%M:%S %a %d %b}\[\e[0m\] \[\e[31m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]]:\n \[\e[93m\]\w\[\e[0m\] \[\e[90m\]\\$\[\e[0m\] '
#
# for colored terminal output
export TERM=wsvt25
export LSCOLORS=gxfxcxdxbxegedabagacad
#
shopt -s histappend
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
##
if command -v colorls > /dev/null; then
  LS='colorls'
else
  LS='ls'
fi
#
alias ls='"$LS" -FHh'
##
export CLICOLOR=1
export COLORIZE=1
#
export EDITOR=/usr/local/bin/nano
export HISTSIZE=500
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE=ls:cd:cl:history:updatedb
#
export PAGER=most
#
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
#
export LESS='-iMRS -x2'
#
alias ..='cd ..'
alias cl='clear'
alias grep='grep -ni'
alias mkdir='mkdir -p'
alias diff='diff -y'
alias tree='tree -aCL 3'
alias updatedb='doas /usr/libexec/locate.updatedb'
alias make='make -j7'
alias sl='sl -a'
alias btop='btop --force-utf'
alias inxi='inxi --admin --verbosity=7 --no-host --width --height'
EOF
#  # test if .bashrc exists and delete it
  [[ -e ~/.bashrc ]] && rm -rf ~/.bashrc || exit 0
  # test if .profile exists and create a symbolic link to bashrc
  [[ -e ~/.profile ]] && ln -s ~/.profile ~/.bashrc || exit 1
  #
  # source the profile
  . ~/.profile
}
#
########################### MAIN #########################
show_header
sleep 2
pkg_add -Uu
#
sleep 2
create_profile        # 8 #
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
