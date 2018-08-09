echo "$XDG_CACHE_HOME"  | grep -vq "\b$USER\b" && export XDG_CACHE_HOME=$HOME/.cache
echo "$XDG_CONFIG_HOME" | grep -vq "\b$USER\b" && export XDG_CONFIG_HOME=$HOME/.config
echo "$XDG_DATA_HOME"   | grep -vq "\b$USER\b" && export XDG_DATA_HOME=$HOME/.local/share

ZDOTDIR=$XDG_CONFIG_HOME/zsh
[ -r ~/.zshenv_local ] && . ~/.zshenv_local
#MANPATH=:$MANPATH

if [ -r /etc/profile.d/modules.sh ]; then
  . /etc/profile.d/modules.sh
  module list > /dev/null 2>&1
fi
