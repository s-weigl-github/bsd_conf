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
alias diff='diff -y'
alias tree='tree -aCL 3'
alias updatedb='doas /usr/libexec/locate.updatedb'
alias make='make -j7'
alias sl='sl -a'
alias btop='btop --force-utf'
alias inxi='inxi --admin --verbosity=7 --no-host --width --height'