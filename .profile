# $OpenBSD: dot.profile,v 1.10 2023/11/16 16:03:51 millert Exp $
#
# sh/ksh initialization
#
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin
export PATH
: ${HOME='/home/techadmin'}
export HOME
umask 022
#
case "$-" in
*i*)    # interactive shell
	if [ -x /usr/bin/tset ]; then
		eval `/usr/bin/tset -IsQ '-munknown:?vt220' $TERM`
	fi
	;;
esac
####
##
PS1='[\[\e[35m\]\D{%H:%M:%S %a %d %b}\[\e[0m\] \[\e[31m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]]:\n \[\e[93m\]\w\[\e[0m\] \[\e[90m\]\\$\[\e[0m\] '
#PS1='[\D{%H:%M:%S %a %d %b} \u@\h]:\n\w \\$ '
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
alias ls='$LS -FHh'
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
