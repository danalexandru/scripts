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
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# # Load zsh-syntax-highlighting; should be last.
# source zsh-autocomplete.plugin.zsh 2>/dev/null

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

chpwd() {exec zsh}

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
