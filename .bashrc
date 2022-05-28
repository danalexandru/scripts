#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1="\[\e[32m\][\u\[\e[33m\]@\[\e[36m\]\h:\[\e[31m\]\W \[\e[35m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\e[32m\]] \[\e[33m\]$\[\e[0m\] "
PS1="\[\033[01;32m\][\u\[\033[01;33m\]@\[\033[01;36m\]\h:\[\033[01;31m\]\W \[\033[01;35m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[01;32m\]] \[\033[01;33m\]$\[\033[01;0m\] "
# PS1=" \[\033[01;36m\]  \[\033[01;31m\]\W \[\033[01;35m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \[\033[01;33m\]\[\033[01;0m\] "
PS2='\u@\h:\W\$'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

SCRIPTS_DIR="/home/aldan/.config/scripts"
HOME_BIN="/home/aldan/bin"
PATH=$PATH:$SCRIPTS_DIR:$HOME_BIN

# Configure Kubernetes autocomplete
source <(kubectl completion bash)
complete -F __start_kubectl kc

# exports
export KUBE_EDITOR=nvim

