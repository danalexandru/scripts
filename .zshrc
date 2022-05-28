# Enable colors and change prompt:
autoload -U colors && colors
# Load version control information
autoload -Uz vcs_info
autoload -U compinit

# precmd() { vcs_info }
# 
# # Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:*' enable git svn
# zstyle ':vcs_info:git:*' formats '%b'

# setopt PROMPT_SUBST
# PROMPT="%B%{$fg[green]%}[%n%{$fg[yellow]%}@%{$fg[cyan]%}%m:%{$fg[red]%}%c %{$fg[magenta]%}(${vcs_info_msg_0_})%{$fg[green]%}] %{$fg[yellow]%}%% %{$reset_color%}%b"

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

PROMPT="%B%{$fg[green]%}[%n%{$fg[yellow]%}@%{$fg[cyan]%}%m:%{$fg[red]%}%c %{$fg[magenta]%}%F{201}($(git_branch))%f%{$fg[green]%}] %{$fg[yellow]%}%% %{$reset_color%}%b"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aldan/.zshrc'

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls --color=auto"

zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# # Load zsh-syntax-highlighting; should be last.
# source zsh-autocomplete.plugin.zsh 2>/dev/null

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Add directories to path
SCRIPTS_DIR="/home/aldan/.config/scripts"
HOME_BIN="/home/aldan/bin"
PATH=$PATH:$SCRIPTS_DIR:$HOME_BIN

# Configure Kubernetes autocomplete
source <(kubectl completion zsh)
#complete -F __start_kubectl kc

# exports
export KUBE_EDITOR=nvim


chpwd() {exec zsh}

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
