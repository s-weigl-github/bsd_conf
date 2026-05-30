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
    pv \
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
  # test if .profile.old exists if so remove it
  [[ -f ~/.profile.old ]] && rm -rf ~/.profile.old || exit 0
  # test if .profile exists if so move it to .old
  [[ -f ~/.profile ]] && mv ~/.profile ~/.profile.old || exit 0
  #
  cat << EOF >> ~/.profile
####
##
PS1='[\[\e[35m\]\D{%H:%M:%S %a %d %b}\[\e[0m\] \[\e[31m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]]:\n \[\e[1;33m\]\w\[\e[0m\] \[\e[90m\]\\$\[\e[0m\] '
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
alias ls='colorls -FHh'
alias ..='cd ..'
alias cl='clear'
alias grep='grep -ni'
alias mkdir='mkdir -p'
alias diff='diff'
alias tree='tree -aCL 3'
alias updatedb='doas /usr/libexec/locate.updatedb'
alias make='make -j7'
alias sl='sl -a'
alias btop='btop --force-utf'
alias inxi='inxi --admin --verbosity=7 --no-host --width --height'
EOF
  # test if .profile exists and create a symbolic link to bashrc
  [[ -f ~/.profile ]] && ln -fs ~/.profile ~/.bashrc || echo 'file not found'
  #
  # source the profile
  pushd ~
  . .profile
  popd
}
#
##########################################################
# 9 #
##########################################################
install_ports(){
  echo
  echo "############################################"
  echo " Install ports"
  echo "############################################"
  #
  pushd /usr
  wget https://ftp.spline.de/pub/OpenBSD/snapshots/ports.tar.gz
  tar xfz ports.tar.gz
  rm -rf ports.tar.gz
  cd ports/
  rm -rf japanese/ korean/ chinese/
  popd
  #
}
#
##########################################################
# 10 #
##########################################################
maintenance(){
  echo
  echo "############################################"
  echo " run system maintenance"
  echo "############################################"
  #
  echo "running syspatch"
  syspatch
  echo " done syspatch"
  echo "running fw_update"
  fw_update
  echo "fw_update done"
  echo "running updatedb"
  /usr/libexec/locate.updatedb
  echo "updatedb done"
  #
}
#
##########################################################
# 11 #
##########################################################
config(){
  echo
  echo "############################################"
  echo " apply configurations "
  echo "############################################"
  #
  cp nanorc /etc/
  cp sysctl.conf /etc/
  # add config to doas.conf
  mv /etc/examples/doas.conf /etc/
  echo -e 'permit nopass keepenv techadmin' >> /etc/doas.conf
  #
}
#
#
##########################################################
# 12 #
##########################################################
get_xxd(){
  echo
  echo "############################################"
  echo " get xxd "
  echo "############################################"
  #
  cp /myxxd/xxd /usr/bin/
  cp /myxxd/xxd.1 /usr/local/man/man1/
  #
  echo -e "alias xxd='xxd -R always -c 13'" >> ~/.profile
  echo "xxd installed"
  #
}
#
########################### MAIN #########################
show_header
sleep 2
#
##########################################################
# use getopts for install options #
#  #
##########################################################
#
usage() {
  echo
  echo "Usage: ${0} [-aixcpmfuh]" >&2
  echo 'install and congigure'
  echo '  -a    install pkges'
  echo '  -i    to install inxi'
  echo '  -x    to install xxd'
  echo '  -c    create .profile'
  echo '  -p    install ports'
  echo '  -m    run maintenance'
  echo '  -f    apply configs'
  echo '  -u    run pkg update'
  echo '  -h    prints this help'
  echo
}

while getopts ":aixcpmfuh" OPTION; do
  case ${OPTION} in
    a)  install_system_tools
        install_info
        install_dev_tools
        install_net_tools
        install_utils
        install_graphic_tools
        ;;
    i)  install_inxi ;;    # 6 #
    x)  get_xxd ;;         # 12 #
    c)  create_profile ;;  # 8 #
    p)  install_ports ;;   # 9 #
    m)  maintenance ;;     # 10 #
    f)  config ;;          # 11 #
    u)  pkg_add -Uu ;;
    h)  usage
        exit 0 ;;
    \?) echo "Error: Invalid option -$OPTARG"
        usage
        exit 1 ;;
    :)  echo "Error: Option -$OPTARG requires an argument."
        usage
        exit 1 ;;
  esac
done
shift $((OPTIND -1))
#
##########################################################
# end of script #
##########################################################
echo "############################################"
echo "Done! all packages have been installed "
echo "############################################"
