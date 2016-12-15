# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

#setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey \^U backward-kill-line
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

TERM=xterm-256color

: ${XDG_CONFIG_HOME:=$HOME/.config}
[ -f $XDG_CONFIG_HOME/zsh/zsh_aliases ] && . $XDG_CONFIG_HOME/zsh/zsh_aliases

[ -d $XDG_CONFIG_HOME/zsh/functions ] && fpath=($XDG_CONFIG_HOME/zsh/functions $fpath)
autoload -U compinit
compinit

[ -f ~/.zshrc_local ] && . ~/.zshrc_local

[ -f ~/.ssh/config ] && _cache_hosts=($(grep '^Host[[:space:]]' ~/.ssh/config | cut -d' ' -f2-))

function precmd() { print -n "\e]2;$USER@$HOST:${PWD/~HOME/~}\a" }
function preexec() { print -n "\e]2;$USER@$HOST:${PWD/~HOME/~}\a" }
setopt auto_cd
function chpwd() { ls }

PATH=$PATH:$HOME/bin
export PYTHONDONTWRITEBYTECODE=1
export TIME_STYLE=long-iso

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
