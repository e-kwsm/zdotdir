#. /etc/profile.d/modules.sh
#module list > /dev/null 2>&1
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME=$HOME/.cache
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=$HOME/.config
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=$HOME/.local/share
ZDOTDIR=$XDG_CONFIG_HOME/zsh
[ -r ~/.zshenv_local ] && . ~/.zshenv_local
#MANPATH=:$MANPATH

if [ -r /etc/profile.d/modules.sh ]; then
  . /etc/profile.d/modules.sh
  module list > /dev/null 2>&1
fi
