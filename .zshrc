# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

unsetopt beep

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey \^U backward-kill-line
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_STATE_HOME/zsh_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history

# Use modern completion system
if [ -d $ZDOTDIR/functions ]; then fpath=($ZDOTDIR/functions $fpath); fi
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if [ ! "$LS_COLORS" ]; then eval "$(dircolors -b)"; fi
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

zstyle ':completion:*' fake-parameters \
  CPATH:string \
  CPLUS_INCLUDE_PATH:string \
  C_INCLUDE_PATH:string \
  LD_LIBRARY_PATH:string \
  LIBRARY_PATH:string \
  OMP_DISPLAY_AFFINITY:string \
  OMP_DISPLAY_ENV:string \
  OMP_NUM_THREADS:string \
  OMP_STACKSIZE:string \
  PKG_CONFIG_PATH:string \
  PYTHONPATH:string \

mychpwd() { ls --color; }
chpwd_functions+=(mychpwd)
mypreexec() { print -n "\e]2;$USER@$HOST:${PWD/~HOME/~}\a"; }
preexec_functions+=(mypreexec)

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd_functions+=(vcs_info)
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

if [ -r ~/.ssh/config ]; then
  _cache_hosts=($(sed -n -e '/^\s*Host\s/ { s///; /\*/d; p }' ~/.ssh/config))
fi

if ! [ -f $ZDOTDIR/.zshrc.zwc ] || [ $ZDOTDIR/.zshrc.zwc -ot $ZDOTDIR/.zshrc ]; then
  zcompile -U -M $ZDOTDIR/.zshrc
fi

if [ -r ~/.zshrc_local ]; then . ~/.zshrc_local; fi
